//===----------------------------------------------------------------------===//
// Target-independent interfaces
//===----------------------------------------------------------------------===//

include "llvm/Target/Target.td"

//===----------------------------------------------------------------------===//
// Target-dependent interfaces
//===----------------------------------------------------------------------===//
def Feature64Bit
    : SubtargetFeature<"64bit", "HasRV64", "true", "Implements RV64">;
def IsRV64 : Predicate<"Subtarget->is64Bit()">,
                       AssemblerPredicate<(all_of Feature64Bit),
                       "RV64I Base Instruction Set">;
def IsRV32 : Predicate<"!Subtarget->is64Bit()">,
                       AssemblerPredicate<(all_of (not Feature64Bit)),
                       "RV32I Base Instruction Set">;

defvar RV32 = DefaultMode;
def RV64           : HwMode<"+64bit">;

include "MyArchRegisterInfo.td"

//===----------------------------------------------------------------------===//
// Calling Conv, Instruction Descriptions
//===----------------------------------------------------------------------===//

include "MyArchInstrInfo.td"
def MyArchInstrInfo : InstrInfo;

//===----------------------------------------------------------------------===//
// Sim processors supported.
//===----------------------------------------------------------------------===//

// Will generate SimGenAsmWrite.inc included by SimInstPrinter.cpp, contents
//  as follows,
// void SimInstPrinter::printInstruction(const MCInst *MI, raw_ostream &O) {...}
// const char *SimInstPrinter::getRegisterName(unsigned RegNo) {...}
def MyArch : Target {
  let InstructionSet = MyArchInstrInfo;
}