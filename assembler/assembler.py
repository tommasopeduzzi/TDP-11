from cgitb import small
from math import ceil
from textwrap import wrap
from typing import Dict, List
from parser import Data, Instruction, Label, Macro, OperandType, Parser

opcode_map = {
    # General instructions
    ("halt",           ()):                                                0b111111,
    ("nop",            ()):                                                0b000000,
    # Memory instructions
    ("load",           (OperandType.REGISTER, OperandType.REGISTER)):      0b000001,
    ("load8",          (OperandType.REGISTER, OperandType.REGISTER)):      0b000010,
    ("load",           (OperandType.REGISTER, OperandType.ADDRESS)):       0b000011,
    ("load8",          (OperandType.REGISTER, OperandType.ADDRESS)):       0b000100,
    ("load-imm",       (OperandType.REGISTER, OperandType.IMMEDIATE)):     0b000101,
    ("load-addr",      (OperandType.REGISTER, OperandType.ADDRESS)):       0b000101,
    ("store",          (OperandType.REGISTER, OperandType.REGISTER)):      0b000110,
    ("store<",         (OperandType.REGISTER, OperandType.REGISTER)):      0b000111,
    ("store>",         (OperandType.REGISTER, OperandType.REGISTER)):      0b001000,
    ("store",          (OperandType.REGISTER, OperandType.ADDRESS)):       0b001001,
    ("store<",         (OperandType.REGISTER, OperandType.ADDRESS)):       0b001010,
    ("store>",         (OperandType.REGISTER, OperandType.ADDRESS)):       0b001011,
    # Stack manipulation instructions
    ("push",           (OperandType.REGISTER,)):                           0b001100,
    ("pop",            (OperandType.REGISTER,)):                           0b001101,
    # Arithmetic instructions
    ("add",            (OperandType.REGISTER, OperandType.REGISTER)):      0b001110,
    ("sub",            (OperandType.REGISTER, OperandType.REGISTER)):      0b001111,
    ("cmp",            (OperandType.REGISTER, OperandType.REGISTER)):      0b010000,
    # Bitwise instructions
    ("not",            (OperandType.REGISTER,)):                           0b010001,
    ("shiftl",         (OperandType.REGISTER,)):                           0b010010,
    ("shiftr",         (OperandType.REGISTER,)):                           0b010011,
    ("and",            (OperandType.REGISTER, OperandType.REGISTER)):      0b010100,
    ("or",             (OperandType.REGISTER, OperandType.REGISTER)):      0b010101,
    ("xor",            (OperandType.REGISTER, OperandType.REGISTER)):      0b010110,
    # Control flow instructions
    ("jump",           (OperandType.ADDRESS,)):                            0b010111,
    ("jump==",         (OperandType.ADDRESS,)):                            0b011000,
    ("jump<",          (OperandType.ADDRESS,)):                            0b011001,
    ("jump>",          (OperandType.ADDRESS,)):                            0b011010,
    ("jumpc",          (OperandType.ADDRESS,)):                            0b011011,
    # IO instructions
    ("in",             (OperandType.REGISTER, OperandType.DEVICE)):        0b011100,
    ("out",            (OperandType.REGISTER, OperandType.DEVICE)):        0b011101,
}


class Assembler:
    parser: Parser

    def __init__(self):
        self.parser = Parser()
        self.address = 0
        self.binary = bytearray()
        self.operations: List[Instruction] = []
        self.labels: Dict[Label] = {}
        self.macros: Dict[Macro] = {}

    def assemble(self, file):
        self.stream = self.parser.parse_file(file)
        self.codegen()

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
            elif operand.type == OperandType.LABEL:
                self.binary += self.labels[operand.value].to_bytes(2, byteorder="little")

    def codegen_instruction(self, instruction: Instruction, macro_arguments=[], macro_argument_types=[]):
        if instruction.mnemonic in self.macros.keys():
            self.codegen_macro(instruction)
            return
        elif instruction.mnemonic == "data":
            self.codegen_data(instruction)
            return
        
        # expand macros and labels
        for operand in instruction.operands:
            # TODO: Refactor support for macros
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
            key = (instruction.mnemonic, tuple(operand.type for operand in instruction.operands))
            opcode = opcode_map[(instruction.mnemonic, tuple(operand.type for operand in instruction.operands))]
        except KeyError:
            raise Exception(
                "Unknown instruction: {}".format(instruction.mnemonic))
        
        # calculate number of bytes needed to store operands
        number_of_bytes = 0
        for i, operand in enumerate(instruction.operands):
            if operand.type == OperandType.REGISTER or operand.type == OperandType.DEVICE:
                number_of_bytes += 0.5
            else: 
                number_of_bytes += 2
        number_of_bytes = ceil(number_of_bytes)
        self.binary += (number_of_bytes << 6 | opcode).to_bytes(1, byteorder="little")

        # store operands
        bits = ""
        for operand in instruction.operands:
            if operand.type == OperandType.REGISTER or operand.type == OperandType.DEVICE:
                bits += bin(operand.value)[2:].zfill(4)
            else:
                if not len(bits) % 8 == 0:
                    bits += "0" * (8 - len(bits) % 8)
                bits += "".join(wrap(bin(operand.value)[2:].zfill(16), 8)[::-1])
        self.binary += bytes([int(byte, 2) for byte in wrap(bits, 8)])

    def codegen(self):
        for item in self.stream: # Collect label addresses
            if isinstance(item, Label):
                self.labels[item.name] = self.address
            elif isinstance(item, Instruction):
                self.address += 1
                for i, operand in enumerate(item.operands):
                    if [OperandType.REGISTER, OperandType.DEVICE].count(operand.type) > 0 and not i == 0:
                        self.address += 1
                    elif [OperandType.ADDRESS, OperandType.LABEL, OperandType.IMMEDIATE].count(operand.type) > 0:
                        self.address += 2
                self.operations.append(item)
            elif isinstance(item, Data):
                self.address += 2*len(item.operands)
                self.operations.append(item)
            elif isinstance(item, Macro):
                self.macros[item.name] = item
    
        for operation in self.operations: # Codegen instructions
            if isinstance(operation, Instruction):
                self.codegen_instruction(operation)
            elif isinstance(operation, Data):
                self.codegen_data(operation)
