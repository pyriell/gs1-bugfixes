ARMIPS assembler v0.7c, released 11th December 2010
by Kingcom

#################################
# 0.   TABLE OF CONTENTS        #
#################################

  1.   Introduction
   1.1 Motivation
   1.2 Usage
   1.3 Change log
  2.   General Information
  3.   Features
   3.1 Files
   3.2 Comments
   3.3 Labels
   3.4 equ
   3.5 Math Parser
   3.6 Load delay detection
   3.7 Strings
   3.8 Areas
  4.   Assembler Directives
   4.1 General Directives
   4.2 MIPS Directives
   4.3 ARM Directives
  5.   Macros
   5.1 Assembler defined MIPS macros
   5.2 User defined macros
  6.   Known issues


#################################
# 1.       INTRODUCTION         #
#################################

1.1  Motivation

I started writing this assembler when I got into PSX hacking,
as the only available assemblers were less than user friendly.
This assembler is an attempt to fix of all of the problems
with currently available assemblers and to allow working with
several different code binaries in the same game. It won't
erase any code, it will just overwrite what the user wants
to overwrite.
In this second version, ARM/THUMB support is finally finished.
It can be used for both GBA and NDS and includes both
instruction sets. ARM has been implemented according to GBATEK
by Martin Korth, and most pseudo opcodes and aliases are
included (for example, mov for mcr/mrc and mrs/msr).
PS2 support is also planned. You can contact me on the
RomHacking.net forums. My nickname there is KC.
Thanks to Gemini for testing it and providing the initial idea.
He also wrote the sample assembly file.


1.2  Usage

The assembler is called from the command line, and the
arguments are as follows:

  armips.exe code.asm [-temp tempfile.txt] [-sym symfile.sym]

Code.asm is the main file of your assembly code. It can
open and include other files, and basically do everything
you want. The optional -temp parameter specifies a
text file where all the temporary assembly data will be
written to for debugging purposes. It will look like this:

  ; 1 file  included
  ; test.asm

  00000000 .open "SLPM_870.50",0x8000F800  ; test.asm line 1
  8000F800 .org 0x800362DC                 ; test.asm line 5
  800362DC   jal     0x801EBA3C            ; test.asm line 7
  800362E0 .Close                          ; test.asm line 9

The other optional parameter, -sym, allows you to specify
a file to output all the labels to. This can be used with
no$gba for easier debugging.


1.3  Change log

  0.7c -Macros can now contain unique local labels
       -area and no$gba debug message directives added
       -sym output enhanced
       -countless bugfixes
       -no$gba debug message support
       -full no$gba sym support
  0.7b -ARM/THUMB support
       -fixed break/syscall MIPS opcodes 
       -added check if a MIPS instruction is valid inside
        a delay slot
       -fixed and extended base detection
       -added "." dummy label to the math parser to get the
        current memory address
       -added dcb/dcw/dcd directives

  0.5b -Initial release


#################################
# 2.    GENERAL INFORMATION     #
#################################

The assembler includes the whole MIPS R3000 instruction
set, as well as the complete ARM7/ARM9 instruction set
used by GBA and NDS, both THUMB and ARM mode. There are
also several other features. Among these features are:

  -a full fledged C-like math parser. It should behave
   exactly like in any C/C++ code, including all the
   weirdness. All immediate values can be specified by
   an expression, though some directives can't use
   variable addresses including labels
  -you can open several files in a row, but only one
   output file can be open at any time. You can specify
   its address in memory to allow overlay support. Any
   file can cross-reference any other included file
  -labels and local labels (see 3.3)
  -table support for user defined text encodings (see 3.7)
  -several MIPS macros to make writing code easier and
   faster (see 4.1)
  -user defined macros (see 4.2)
  -built-in checks for possible load delay problems (see 3.6)
  -optional automatic fix for said problems by inserting
   a nop between the instructions
  -output of the assembled code to a textfile, with RAM
   addresses and origin (see 1.2)
  -a directive to ensure that data is not bigger than a
   user defined size (see 3.8)


#################################
# 3.         FEATURES           #
#################################

3.1  Files

Unlike other assemblers, you don't specify the input/output
file as a command line argument. You have to open the file
in the source code, and also close it yourself. This was
done in order to support overlays, which are very common
in PSX and NDS games. Instead of only having one output file,
you can have as many as you need - each with its own address
in memory. The files can cross-reference each other without
any problems, so you can call code from other, currently
not opened files as well.

  .Open "SLPS_035.71", 0x8000F800
  ; ...
  .Close
  .Open "System\0007.dat", 0x800CC000
  ; ...
  .Close


3.2  Comments

Both ; and // are supported for comments.


3.3  Labels

There is support for both local and global labels. Local
labels are only valid in the area between the previous
and the next global label. Specific directives, like .org,
will also terminate the area. A label is defined by writing
a colon after its name. All labels can be used before they
are defined.

  GlobalLabel:      ; This is a global label
  @@LocalLabel:     ; This is a local label, it is only
                    ; valid until the next global one
  OtherGlobalLabel: ; this will terminate the area where
                    ; @@LocalLabel can be used
  b   @@LocalLabel  ; as a result, this will cause an error


A label name can contain all characters from A-Z and numbers.
However, it cannot start with a digit. All label names are
case insensitive.


3.4  equ

This works as a text replacement and is defined as follows:

  @@StringPointer equ 0x20(r29)


There has to be a space before and after equ. The assembler
will replace any occurance of @@StringPointer with "0x20(r29)".
As it is a local equ, it will only do so in the current
section, which is terminated by any global label or specific
directives. This code:

  @@StringPointer equ 0x20(r29)
 
  lw  a0,@@StringPointer
  nop
  sw  a1,@@StringPointer

will assemble to this:

  lw  a0,0x20(r29)
  nop
  sw  a1,0x20(r29)

There can be both global and local equs, but unlike normal
labels, they have to be defined before they are used.


3.5  Math Parser

A standard math parser with operator precedence and bracket
support has been implemented. It is intended to behave exactly
like any C/C++ parser and supports all unary, binary and
tertiary operators of the C language. Every numeral argument
can be given as an expression, including label names.
However, some directives do not support variable addresses,
so labels can not be used in expressions for them.
The following bases are supported:

  $A, 0xA and 0Ah for hexadecimal numbers
  0o12 and 12o for octal numbers
  1010b for binary numbers

Everything else is interpreted as a decimal numbers, so a
leading zero does not indicate an octal number. Be aware that
every number has to actually start with a digit, unless you
use $ for hexadecimal numbers. For example, as FFh is a
perfectly valid label name, you have to write 0FFh in this case.
Labels, on the other hand, can not start with a digit.

A few examples:

  mov  r0,10+0xA+$A+0Ah+0o12+12o+1010b
  ldr  r1,=ThumbFunction+1
  li   v0,Structure+(3*StructureSize)


3.6  Load delay detection

This feature is still unfinished and experimental. It works
in most cases, though. On MIPS platforms, any load is
asynchronously delayed by one cycle. This means that the CPU
won't stall if you attempt to use it before - and instead
returns the old value on real hardware (emulators do not emulate
this, which makes spotting these mistakes even more difficult).
Therefore, the assembler will attempt to detect when such a
case happens. The following code would result in a warning:

  lw   a0,0x10(r29)
  lbu  a1,(a0)

This code doesn't take the load delay into account and will
therefore only work on emulators. The assembler detects it
and warns the user. In order to work correctly, the code should
look like this:

  lw   a0,0x10(r29)
  nop
  lbu  a1,(a0)

Here, one cycle is wasted with the nop and there will be no
problems.
However, the detection doesn't work in all cases. It can't
check if the instruction at a branch destination uses a
register that was loaded in the branch's delay slot, and it
will give it a false alarm in the following example:

  bnez  a0,@@branch1
  nop
  j     @@branch2
  lw    a0,(a1)
@@branch1:
  lbu   a2,(a0)

You can fix the false warning by using the .resetdelay
directive before the last instruction.

  bnez  a0,@@branch1
  nop
  j     @@branch2
  lw    a0,(a1)
.resetdelay
@@branch1:
  lbu   a2,(a0)

This behavior may be fixed in a future revision.


3.7  Strings

You can write ASCII text by simple using the .db/.ascii
directive. However, you can also write text with custom
encodings. In order to do that, you first have to load a table,
and then use the .string directive to write the text.
It behaves exactly like the .db instruction (so you can also
specify immediate values as arguments), with the exception
that it uses the table to encode the text, and appends a
termination sequence after the last argument. This has to
be specified inside the table, otherwise 0 is used.

  .loadtable "custom.tbl"
  .string "Custom text",0xA,"and more."

The first and third argument are encoded according to the
table, while the second one is written as-is.



3.8  Areas

If you overwrite existing data, it is critical that you
don't overwrite too much. The area directive will take care
of checking if all the data is within a given space. In order
to do that, you just have to give it the maximum size allowed.

.area 10h
  .word 1,2,3,4,5
.endarea

This would cause an error on assembling, because the word
directive takes up 20 bytes instead of the 16 that the
area is allowed to have. This, on the other hand, would
assemble without problems:

.org 8000000h
.area 8000020h-.
  .word 1,2,3,4,5
.endarea

Here, the area is 32 bytes, which is sufficient for the 20
bytes used by .word.


#################################
# 4.    ASSEMBLER DIRECTIVES    #
#################################

These commands tell the assembler to do various things
like opening the output file or opening another source
file.


4.1  General Directives


.psx

Sets the architecture to PSX.


.gba

Sets the architecture to GBA. It will default to THUMB
mode, but it can switch to ARM at any time. ARM9 specific
opcodes are disabled, so it is also usable for NDS ARM7
code.


.nds

Sets the architecture to NDS. It will default to ARM mode,
but it can switch to THUMB at any time.


.open FileName,RamAddress
.open OldFileName,NewFileName,RamAddress

Opens the specified file for output. If two file names
are specified, then the assembler will copy the first
file to the second path. All paths are relative to the
current working directory, so from where the assembler
was called. RamAddress specifies the difference between
the first byte of the file and its position in RAM.
So if file position 0x800 is at position 0x80010000 in
RAM, the header size is 0x80010000-0x800=0x8000F800.
Only the changes specified by the assembly code will
be inserted, the rest of the file remains untouched.


.create FileName,RamAddress
.createfile FileName,RamAddress

Creates the specified file for output. If the file already
exists, it will be erased. All paths are relative to the
current working directory, so from where the assembler was
called. RamAddress specifies the difference between the
first byte of the file and its position in RAM. So if file
position 0x800 is at position 0x80010000 in RAM, the header
size is 0x80010000-0x800=0x8000F800.


.close
.closefile

Closes the currently opened output file.


.headersize RamAddress

Sets the header size to the given size. It will be
used to calculate all addresses from that point on.


.org RamAddress

Sets the output pointer to the specified address. The file
address is computed by subtracting the header size from
the given address.


.orga FileAddress

Sets the output pointer to the specified address. The
absolute file address is given.


.include FileName

Opens the file called FileName to assemble it. All paths
are relative to the current working directory, so from
where the assembler was called. You can include other
files up to a depth level of 64. This limit was added
to prevent the assembler from crashing due to two files
including each other over and over again.


.incbin FileName
.import FileName

Inserts the file specified by FileName into the currently
opened output file. All paths are relative to the current
working directory, so from where the assembler was called.


.align [num]

Writes zeroes into the output file until the output
position is divisible by num. If num is not given,
4 will be used by default. num has to be a power of two. 


.fill length[,value]
defs length[,value]

Inserts length amount of bytes of value. If value isn't
specified, inserts zeros. Only the lowest 8 bits of
value are inserted.


.byte value[,...]
.db value[,...]
.ascii value[,...]
dcb value[,...]

Inserts up to 128 bytes specified by the arguments. Value
can be any equation, but only the lowest 8 bits are inserted.
Value can also be a string in quotation marks.


.halfword value[,...]
.dh value[,...]
dcw value[,...]

Inserts up to 128 halfwords specified by the arguments. Value
can be any equation, but only the lowest 16 bits are inserted.
Value can also be a string in quotation marks, in that case,
every letter is inserted as a halfword.


.word value[,...]
.dw value[,...]
dcd value[,...]

Inserts up to 128 words specified by the arguments. Value can
be any equation. Value can also be a string in quotation marks,
in that case, every letter is inserted as a word.


.if equation

Assembles the next block only if equation is nonzero. Can be
inverted by .else or .elseif and has to be terminated by
.endif. The code is still verified even if the condition is
not met.


.else

Inverts previous .if or .elseif statement.


.elseif equation

Equation will only be checked if previous .if or .elseif
statement was not met. Assembles the next block only if
equation is nonzero. Can be inverted by .else or .elseif
and has to be terminated by .endif. The code is still
verified even if the condition is not met.


.ifdef label

Assembles the next block only if label is defined. Can be
inverted by .else or .elseif and has to be terminated by
.endif. The code is still verified even if the condition is
not met.


.ifndef label

Assembles the next block only if label is not defined. Can
be inverted by .else or .elseif and has to be terminated by
.endif. The code is still verified even if the condition
is not met.


.loadtable TableName
.table TableName

Loads TableName for using it with the .string directive.
The encoding has to be same as the assembly file's,
as a simple binary comparison is used. All paths are relative
to the current working directory, so from where the assembler
was called. You can specify one or several termination bytes
like this:
	02=a
	/FF
FF will be inserted at the end of the string. If it is not
given, zero is used instead.


.string "String"
.str "String"

Inserts the given string using the previously opened table.


.definelabel Label,value

Defines Label with the given value. This may seem similar to equ,
but you don't have to use this before using the label. It will also
be added to the sym output.


.area SizeEquation

Opens a new area with the maximum size of SizeEquation. If the
data inside the area is bigger than the maximum, the assembler
will output an error and refuse to assemble the code. It has to
be closed by a .endarea directive.


.endarea

Closes a previously opened area. If the difference between the
current ram address and that of the previous .area directive is
bigger than the given size, an error will prevent successful
assembling.


4.2  MIPS Directives

.resetdelay

Resets the current load delay status. This can be useful if
the instruction after a delay slot access the delayed register,
as the assembler can't detect that yet.


.fixloaddelay

Automatically fixes any load delay problems by inserting a
nop between the instructions. Best used in combination with
.resetdelay.


4.3  ARM Directives

.arm

This tells the assembler to use the full 32 bit ARM instruction
set. It can be switched to THUMB at any time. NDS will default
to this instruction set.


.thumb

This tells the assembler to use the cut-down 16bit THUMB
instruction set. It can be switched to ARM at any time. GBA will
default to this instruction set.


.pool

This directive works together with a pseudo opcode. In the code,
you can use an ldr instruction to load a full 32 bit immediate.
This immediate will be saved inside one of these pools.
Example:

  ldr  r0,=0xFFEEDDCC
  ; ...
  .pool

Here, the ldr instruction will be assembled as a PC-relative
load and the value will be written into the pool. The range is
limited, so you may have to define several pools.
.pool will automatically align the position to a multiple of 4.

.msg

Adds a no$gba debug message as described by GBATEK.


#################################
# 5.          MACROS            #
#################################

5.1  Assembler defined MIPS macros.

There are various macros built into the assembler for ease
of use. They are intended to make using some of the assembly
simpler and faster.
At the moment, these are all the MIPS macros included:

   li   reg,Immediate
   la   reg,Immediate

   Loads Immediate into the specified register by using a
   combination of lui/ori, a simple addiu or a simple ori.


   lb   reg,Address
   lbu  reg,Address
   lh   reg,Address
   lhu  reg,Address
   lw   reg,Address

   Loads a byte/halfword/word from the given address into
   the specified register by using a combination of lui
   and lb/lbu/lh/lhu/lw.


   ulh  destreg,imm(sourcereg)
   ulh  destreg,(sourcereg)
   ulhu destreg,imm(sourcereg)
   ulhu destreg,(sourcereg)

   Loads an unaligned halfword from the address in sourcereg.
   It uses a combination of several lb/lbus and oris.


   ulw  destreg,imm(sourcereg)
   ulw  destreg,(sourcereg)

   Loads an unaligned word from the address in sourcereg.
   It uses a combination of lwl/lwr.


   sb   reg,Address
   sh   reg,Address
   sw   reg,Address

   Writes a byte/halfword/word to the given address by
   using a combination of lui and sb/sh/sw.


   ush  destreg,imm(sourcereg)
   ush  destreg,(sourcereg)

   Loads an unaligned halfword to the address in sourcereg.
   It uses a combination of several sb/sbus and shifts.


   usw  destreg,imm(sourcereg)
   usw  destreg,(sourcereg)

   Loads an unaligned word to the address in sourcereg.
   It uses a combination of swl/swr.


   blt   reg1,reg2,Dest
   bge   reg1,reg2,Dest

   If reg1 is lower than/greate or equal than reg2, branches
   to the given address. A combination of sltu and beq/bne
   is used.


   blt   reg,Imm,Dest
   bge   reg,Imm,Dest

   If reg is lower than/greater or equal than Imm, branches
   to the given address. A combination of li, sltu and beq/bne
   is used.


   bne   reg,Imm,Dest
   beq   reg,Imm,Dest

   If reg is not the same/the same as Imm, branches to the
   given address. A combination of li and beq/bne is used.


   rol    reg1,reg2,reg3
   ror    reg1,reg2,reg3

   Rotates reg2 left/right by the value of the lower 5 bits
   of reg3 and stores the result in reg1. A combination of
   sll, srl and ori is used.


   rol    reg1,reg2,Imm
   ror    reg1,reg2,Imm

   Rotates reg2 left/right by Imm and stores the result in
   reg1. A combination of sll, srl and ori is used.


5.2  User defined macros

The assembler allows the user to create his own macros.
This is an example macro, a recreation of the builtin
macro for li:

  .macro myli,dest,value
      .if value < 0x10000
          ori   dest,r0,value
       .elseif (value & 0xFFFF8000) == 0xFFFF8000
          addiu dest,r0,value & 0xFFFF
       .elseif (value & 0xFFFF) == 0
          lui   dest,value >> 16
       .else
          lui   dest,value >> 16 + (value & 0x8000 != 0)
          addiu dest,dest,value & 0xFFFF
       .endif
  .endmacro

The macro has to be initiated by a .macro directive. The
first argument is the macro name, followed by a variable
amount of arguments. The code inside the macro can be
anything, and it can even call other macros (up to a nesting
level of 128 calls). The macro is terminated by a .endmacro
directive. It is not assembled when it is defined, but other
code can call it from now on. All arguments are simple text
replacements, so they can be anything from a number to a
whole instruction parameter list.
The macro is then called like this:

  myli  a0,0xFFEEDDCC

This code will, in this case, assemble to the following:

  lui   a0,0xFFEF
  addiu a0,a0,0xDDCC

The user can define a theoretically infinite amount of
macros. Like all the other code, any equs are inserted
before they are resolved.

With the latest revision, macros can also contain local
labels that are changed to an unique name. Global labels,
however, are uneffected by this. The label name is prefixed
by the macro name and a counter id. This label:

.macro test
  @@MainLoop:
.endmacro

will therefore be changed to:

  @@test_00000000_mainloop

Each call of the macro will increase the counter.


#################################
# 6.      KNOWN ISSUES          #
#################################

  -the last line of any file has to be empty, otherwise
   it is ignored due to limitations in the code
  -the load delay check can't detect if an opcode is inside
   a delay slot, and if it will be used by the first
   instruction of the branch destination

