# Cobol Samples 

Short sample programs that illustrate how to carry out various programming tasks in Cobol. 

## How to run the sample programs 

On z/OS, compile-link-go. HEX2TEXT is a subprogram. The other samples are main programs.

On Linux, Unix, Windows, or OS X, install a Cobol compiler that offers source-level compatibility with IBM Enterprise Cobol. Compile HEX2TEXT as a subprogram (.so or .dll), and the other sample programs as main programs. 

Assuming Linux and GnuCOBOL, you can use these Bash scripts to compile and run the sample programs. Use -s for a subprogram (e.g., HEX2TEXT). Script compile-all compiles all the programs in src/main/cobol.

- compile [-s] _programname_ 
- compile-all 
- run _programname_

## Using basic Cobol statements

### How can I...

- [MOVEME](MOVEME-notes.md) ...assign values to Data Division items?

## Conditional logic 

#### How can I... 

- [IFEVAL](IFEVAL-notes.md) ...use IF/ELSE and EVALUATE for conditional logic? 
- [COND88](COND88-notes.md) ...work with _condition names_ (or 88-level data items)?
- [NOTBOOL](NOTBOOL-notes.md) ...work with legacy workarounds for boolean values?

## Working with datasets

#### How can I... 

- [CPSEQFR](CPSEQFR-notes.md) ...read and write sequential (QSAM) files with fixed-length records?
- [CPSEQVR](CPSEQVR-notes.md) ...read and write sequential (QSAM) files with variable-length records ?

## Working with text data

#### How can I... 

- [STRINGIT](STRINGIT-notes.md) ...use INSPECT, STRING, and reference modification to manipulate text data?
- [HELLO](HELLO-notes.md) ...eliminate trailing spaces in variable-length text data?
- [REFORMER](REFORMER-notes.md) ...use various Cobol statements to reformat records?

## Working with numeric data

#### How can I...

- [INVCALC](INVCALC-notes.md) ...code business calculations in Cobol? 
- [BRAKES](BRAKES-notes.md) ...code engineering calculations in Cobol? 
- [ATTRACT](ATTRACT-notes.md) ...code scientific calculations in Cobol?

## Working with dates and times 

#### How can I...

- [DATE1](DATE1-notes.md) ...get the current date and time using the CURRENT-DATE intrinsic function? 
- [DATE2](DATE2-notes.md) ...get the current date and time using the Cobol ACCEPT statement? 
- [HourGlass](HOURGLASS-notes.md) ...set a date and time for the duration of a job or job step? 


