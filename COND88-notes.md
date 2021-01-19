# COND88.CBL 

This sample demonstrates how to work with _condition names_, or 88-level data items. Cobol did not have a boolean data type until ANSI 2002 Cobol was defined. Even that definition is not particularly convenient. For purposes of supporting legacy Cobol applications on mainframe systems, you will typically work with 88-level data items that represent so-called _condition names_. Condition names can have a "true" or "false" value, but the syntax for working with them is quite different from the syntax for working with boolean data types in other programming languages. 

## Notes 

The sample program COND88 illustrates how to write code to work with various "flavors" of 88-level items, including simple ones (the original implementation, with no FALSE but only TRUE or NOT TRUE), items that have a FALSE clause, conditions that represent multiple values, and conditions that represent ranges of values. 

The program does not emit any output. The source code is provided for reference. 


## Additional information 

- [IBM Documentation: Cobol Level-88 Data Items](https://www.ibm.com/support/knowledgecenter/SSQP76_8.0.1/com.ibm.wodm.dserver.rules.designer.dev/cobol_topics/tpc_xomguidelines_level88_intro.html)
- [IBM Documentation: Cobol Evaluate Statement](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/ref/rlpseval.htm)

