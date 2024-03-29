from cgitb import small
from math import ceil
from textwrap import wrap
from typing import Dict, List

from numpy import number
from parser import Data, Instruction, Label, Macro, Operand, OperandType, Parser, Interrupt

operand_types = {
    "reg": OperandType.REGISTER,
    "addr": OperandType.ADDRESS,
    "imm": OperandType.IMMEDIATE,
    "dev": OperandType.DEVICE
}


class Assembler:
    parser: Parser

    def __init__(self):
        self.parser = Parser()
        self.address = 0
        self.binary = bytearray()
        self.operations: List[Instruction] = []
        self.labels: Dict[Label] = {}
        self.interrupts: List[Label] = [0 for i in range(16)]
        self.macros: Dict[Macro] = {}

    def assemble(self, file):
        self.stream = self.parser.parse_file(file)
        self.codegen()

    def parse_instructions(self, instruction_files: List[str]):
        self.instruction_map = {}
        number_of_instructions = 0
        for file in instruction_files:
            with open(file, "r") as f:
                lines = f.readlines()
                for line in lines:
                    if line.startswith("#"):
                        continue
                    parts = line.split()
                    if parts[0] == "nop":
                        self.instruction_map[("nop", tuple([]))] = 0
                        continue
                    elif parts[0] == "halt":
                        self.instruction_map[("halt", tuple([]))] = 0b111111
                        continue
                    mnemonic = parts.pop(0)
                    operands = []
                    for part in parts:
                        try:
                            operands.append(operand_types[part])
                        except KeyError:
                            raise Exception(
                                f"Unknown operand type '{part}' in '{line}'.")
                    number_of_instructions += 1
                    self.instruction_map[(mnemonic, tuple(
                        operands))] = number_of_instructions

    def codegen_macro(self, instruction):
        macro = self.macros[instruction.opcode]
        for i, operand in enumerate(instruction.operands):
            if not operand.type == macro.argument_types[i]:
                raise Exception("Macro argument type mismatch {} for macro {}".format(
                    instruction.opcode, macro.name))
        if not len(instruction.operands) == len(macro.argument_types):
            raise Exception("Macro argument count mismatch for macro {}: Expected {} operands, but got {}".format(
                macro.name, len(macro.argument_types), len(instruction.operands)))

        for macro_instruction in macro.instructions:
            self.codegen_instruction(
                macro_instruction, instruction.operands, macro.argument_types)

    def codegen_data(self, data):
        for operand in data.operands:
            if operand.type == OperandType.IMMEDIATE or operand.type == OperandType.ADDRESS:
                self.binary += operand.value.to_bytes(2, byteorder="little")
            elif operand.type == OperandType.STRING:
                for char in operand.value:
                    self.binary += ord(char).to_bytes(1, byteorder="little")
            elif operand.type == OperandType.LABEL:
                self.binary += self.labels[operand.value].to_bytes(
                    2, byteorder="little")

    def codegen_instruction(self, instruction: Instruction, macro_arguments=[], macro_argument_types=[]):
        if instruction.mnemonic in self.macros.keys():
            self.codegen_macro(instruction)
            return
        elif instruction.mnemonic == "data":
            self.codegen_data(instruction)
            return

        # expand macros and labels
        for operand in instruction.operands:
            if operand.type == OperandType.MACRO_ARGUMENT:
                operand.value = macro_arguments[operand.value]
                operand.type = macro_argument_types[operand.value]
            if operand.type == OperandType.LABEL:
                try:
                    operand.value = self.labels[operand.value]
                    operand.type = OperandType.ADDRESS
                except KeyError:
                    raise Exception(
                        "Label not found: {}".format(operand.value))

        # get opcode
        try:
            opcode = self.instruction_map[(instruction.mnemonic, tuple(
                [operand.type for operand in instruction.operands]))]
        except KeyError:
            raise Exception(
                "Unknown instruction: {}".format(instruction.mnemonic))

        # calculate number of bytes needed to store operands
        number_of_bytes = int(self.length_in_bytes(
            instruction, macro_argument_types)) - 1
        self.binary += (number_of_bytes << 6 |
                        opcode).to_bytes(1, byteorder="little")

        # store operands
        # TODO: Refactor this, it's ugly
        bits = ""
        for operand in instruction.operands:
            if operand.type == OperandType.REGISTER or operand.type == OperandType.DEVICE:
                bits += bin(operand.value)[2:].zfill(4)
            else:
                if not len(bits) % 8 == 0:
                    bits += "0" * (8 - len(bits) % 8)
                if operand.value < 0:
                    operand.value &= 0xFFFF
                bits += "".join(wrap(bin(int(operand.value))
                                [2:].zfill(16), 8)[::-1])
        if not len(bits) % 8 == 0:
            bits += "0" * (8 - len(bits) % 8)
        self.binary += bytes([int(byte, 2) for byte in wrap(bits, 8)])

    def length_in_bytes(self, instruction: Instruction, macro_argument_types=[]):
        instruction = instruction
        if instruction.mnemonic in self.macros.keys():
            length = 0
            for instr in self.macros[instruction.name].instructions:
                length += self.length_in_bytes(instr,
                                               self.macros[instruction.name].argument_types)
            return length
        length = 1
        for operand in instruction.operands:
            actual_type = operand.type
            if actual_type == OperandType.MACRO_ARGUMENT:
                operand.type = macro_argument_types[operand.value]
            elif actual_type == OperandType.LABEL:
                actual_type = OperandType.ADDRESS
            match actual_type:
                case OperandType.REGISTER | OperandType.DEVICE:
                    length += 0.5
                case OperandType.IMMEDIATE | OperandType.ADDRESS:
                    length = ceil(length + 2)
        return length

    def codegen(self):
        self.parse_instructions(["instructions/core.instr"])

        for item in self.stream:  # Collect macros
            if isinstance(item, Macro):
                self.macros[item.name] = item

        for item in self.stream:  # Collect label addresses
            if isinstance(item, Label):
                self.labels[item.name] = self.address
            if isinstance(item, Interrupt):
                self.interrupts[item.number] = self.address
            elif isinstance(item, Data):
                self.address += 2*len(item.operands)
                self.operations.append(item)
            elif isinstance(item, Instruction):
                self.address += self.length_in_bytes(item)
                self.operations.append(item)

        for operation in self.operations:  # Codegen instructions
            if isinstance(operation, Instruction):
                self.codegen_instruction(operation)
            elif isinstance(operation, Data):
                self.codegen_data(operation)

        self.binary += bytearray([0] * (2**15-32-len(self.binary)))
        for i in range(16):
            numbers = [int(byte, 2) for byte in wrap(
                bin(self.interrupts[i])[2:].zfill(16), 8)]
            self.binary += bytes(numbers[::-1])
