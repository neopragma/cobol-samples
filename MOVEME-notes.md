# MOVEME.CBL 

This sample demonstrates the effect of the Cobol MOVE statement on values in memory for various PICTURE and USAGE specifications.

## Notes 

The program executes MOVE statements to assign values to Data Division items that have various different PICTURE and USAGE clauses, and displays the results of the MOVE statements as text or hexadecimal values on stdout (SYSOUT). Hexadecimal text values will be displayed in ASCII if you are running the examples on an ASCII-based system, and in EBCDIC if on an EBCDIC-based system. 

#### Example 1: Alphanumeric MOVE

Example 1 is a MOVE statement of an alphanumeric literal to an item defined as PICTURE X USAGE DISPLAY.

#### Example 2: Numeric MOVE, 32-bit binary (USAGE COMP)

Example 2 is a MOVE statement of a numeric literal to an item defined as PIC S9(09) COMP (or USAGE IS COMPUTATIONAL). It illustrates the fact an item defined this way takes up four bytes in memory. 

#### Example 3: Numeric MOVE, 64-bit binary (USAGE COMP)

Example 3 is a MOVE statement of a numeric literal to an item defined as PIC S9(16) COMP (or USAGE IS COMPUTATIONAL). It illustrates the fact an item defined this way takes up eight bytes in memory. 

#### Example 4: Overwrite binary value with SPACES (USAGE COMP)

Example 4 shows the effect of a MOVE statement that overwrites a COMPUTATIONAL item with spaces. For a COMPUTATIONAL item, the system treats the binary representation of "spaces" as if it were a binary number. This is not usually the programmer's intent, but it does happen. The result is that computations using the item yield incorrect results.

USAGE COMPUTATIONAL-4 or COMP-4 is the same as COMPUTATIONAL or COMP.

#### Example 5: Numeric MOVE, single-precision floating point (USAGE COMP-1)

Example 5 shows the effect of a MOVE statement of a numeric literal expressed in scientific notation to an item defined as COMP-1 or COMPUTATIONAL-1. This is the IEEE single-precision floating-point format, which takes up 32 bits (4 bytes) of memory. Note that the PICTURE clause is omitted, as this format is always the same internally. 

Floating point values are not common in business applications.

#### Example 6: Numeric MOVE, double-precision floating point (USAGE COMP-2)

Example 6 shows the effect of a MOVE statement of a numeric literal expressed in scientific notation to an item defined as COMP-2 or COMPUTATIONAL-2. This is the IEEE double-precision floating-point format, which takes up 64 bits (8 bytes) of memory. Note that the PICTURE clause is omitted, as this format is always the same internally. 

Floating point values are not common in business applications.

#### Example 7: Numeric MOVE, packed decimal format (USAGE COMP-3)

Example 7 is a MOVE statement of a numeric literal to an item defined as PIC S9(04)V9(03) COMP-3 (or USAGE IS COMPUTATIONAL-3). In IBM Enterprise Cobol, COMP-3 denotes a Packed Decimal item. The example illustrates the following:
- a seven-digit Packed Decimal item takes up four bytes in memory
- the implied decimal point (the "V" in the PICTURE clause) is not represented in memory
- the contents of a packed decimal field consist of _binary coded decimal_ (BCD) digits in each nybble except the last nybble, which contains the sign. The hexadecimal value "C" represents the positive sign, "D" the negative sign, and "F" means "unsigned." 

#### Example 8: Overwrite packed decimal value with SPACES (USAGE COMP-3)

Example 8 shows the effect of a MOVE statement that overwrites a Packed Decimal item with spaces. The system does not complain about this, but as the low-order nybble does not contain a valid Packed Decimal sign, when the item is used in an arithmetic operation such as ADD, SUBTRACT, or COMPUTE, the result will be a Data Exception runtime error (reported as error code S0C7 or "sock seven" on z/OS and as "Data Exception" on z/VSE). 

Moving spaces into a Packed Decimal field is the cause of the majority of runtime errors Cobol programmers create. When the field is used as the "depending on" variable for a variable-length Cobol table, the system will overwrite a large swath of memory with spaces, extending beyond the boundary of the program's working storage area, and wiping out other programs' data and possibly system control blocks. In the CICS environment, this is the most common cause of Storage Violation errors. 

#### Example 9: Numeric MOVE to Display Numeric Signed (PIC 9, USAGE DISPLAY)

This example shows the effect of moving a numeric value to an item defined as PICTURE 9(...) and USAGE DISPLAY. 

#### Example 10: Numeric MOVE to Display Numeric with formatting (PIC -ZZ,ZZ9.99, USAGE DISPLAY)

This example shows the effect of moving a numeric value to an item defined with special formatting symbols for output.

#### Example 11: Numeric MOVE to Display Numeric with formatting for a currency value 

Similar to Example 10, but the format specification includes a floating currency symbol: PICTURE -$$,$$9.99.

#### Example 12: Numeric MOVE to external floating-point item with formatting for output 

This example shows the effect of moving a numeric value to an "external" floating-point item with a PICTURE clause to format the value for output: PIC -9V(9)E-99 (with implicit USAGE DISPLAY). 

Note this example is commented-out. This form of the PICTURE clause is not supported on GnuCOBOL. If you are running the examples on a system that supports this feature, you can un-comment the relevant lines in MOVEMENT.CBL.

#### Examples 13 and 14: Initializing a group item 

Example 13 shows the effect of using the INITIALIZE statement to initialize all the data items defined under a group item, WS-GROUP-ITEM. Each alphanumeric item is filled with spaces, and each numeric items is assigned "zero" in the appropriate format. 

Example 14 shows a common programming mistake whereby a group item is initialized by moving SPACES to it. You can see that memory is overwritten well beyond the length of the group item, and numeric fields are assigned values that can lead to incorrect results or run time errors. 

## Additional information 

- [IBM Documentation: Formats for Numeric Data](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/concepts/cpari09.htm)
- [IBM Documentation: Numeric Data and Internal Representation](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/concepts/cpari20e.htm) 
- [IBM Documentation: Displaying Numeric Data](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/tasks/tpari06.htm)
- [IBM Documentation: Internal Floating-Point (COMP-1 and COMP-2) items](https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_71/rzase/sc092540205.htm)
- [IBM Documentation: External Floating-Point (USAGE DISPLAY) Items](https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_71/rzase/sc092540205.htm) 
- [IBM Documentation: Initializing a Table at the Group Level](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/tasks/tptbl21b.htm)
- [IBM Documentation: Cobol Initialize Statement](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/ref/rlpsinit.htm)
