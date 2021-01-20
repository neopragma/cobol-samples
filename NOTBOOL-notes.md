# NOTBOOL.CBL 

This sample demonstrates a few of the workarounds people have created over the years to compensate for the lack of a true boolean data type in Cobol. You will see patterns like these in legacy code. 

## Notes 

The program does not emit any output. The source code is provided for reference. 

#### Example 1: BIT or BOOLEAN types (ANSI 2002 Cobol and later)

This example illustrates how to use BIT flags to represent boolean values. Note the code does not compile under GnuCOBOL on Linux, so the sample code is commented out. 

#### Example 2: Pseudo-boolean based on a coding convention 

Many legacy Cobol programs use values in Data Division items to represent conceptual "boolean" values. The coding conventions vary from team to team or from programmer to programmer. This example shows a coding convention based on a PICTURE X field that may contain 'T' for "true" or blank for "false". 

#### Example 3: Pseudo-boolean based on a coding convention 

This example shows a coding convention based on a PICTURE X field that may contain 'Y' for "yes" or 'N' for "no". 

#### Example 4: Pseudo-boolean based on a coding convention 

This example shows a coding convention based on a PICTURE X field that may contain '1' for "true" or '0' for "false". 

#### Example 5: Pseudo-boolean based on a coding convention 

This example shows a coding convention based on an 88-level item that has no FALSE clause. 

#### Example 6: Pseudo-boolean based on a coding convention 

This example shows a coding convention based on an 88-level item that has a FALSE clause. 

#### Example 7: Pseudo-boolean based on a coding convention 

This example shows a coding convention based on a numeric item where the value +1 represents "true" and the value -1 represents "false". 


## Additional information 

- [COBOL 2002: The Good, the Bad, and the Ugly](https://www.ibm.com/developerworks/rational/cafe/attachments/3149-1-2179/S8204%20-%20Boston%20-%202002%20COBOL%20-%20Good,%20Bad,%20and%20the%20Ugly.pdf)
- [IBM Documentation: Boolean Conditions](https://www.ibm.com/support/knowledgecenter/SS6SG3_6.3.0/lr/ref/rldirbool.html)
- [IBM Documentation: 88-Level Items](https://www.ibm.com/support/knowledgecenter/SSQP76_8.0.1/com.ibm.wodm.dserver.rules.designer.dev/cobol_topics/tpc_xomguidelines_level88_impl.html)

