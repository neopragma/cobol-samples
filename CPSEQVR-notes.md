# CPSEQVR.CBL 

This sample demonstrates how to read and write sequential datasets (files) that have variable-length records.

## Notes 

This example pertains to processing QSAM datasets that have variable-length logical records. Each block is preceded by a _block descriptor word_ (BDW) that contains the length of the block, and each logical record within a block is preceded by a _record descriptor word_ (RDW) that contains the length of the logical record. The BDW and RDW are not included in the record layout specified in a Cobol program. They are handled by the system. Only the logical records themselves are visible to a Cobol program. 

The record layout under the FD defines a logical record of the maximum length. A separate numeric data item defined in the Working-Storage section will be populated with the logical record length when the program READs a record from an input file. The program sets the length of output records before it WRITEs a variable-length record. 

## Additional information 

- [IBM Documentation: Dataset Record Formats](https://www.ibm.com/support/knowledgecenter/zosbasics/com.ibm.zos.zconcepts/zconcepts_159.htm)
- [IBM Documentation: Processing QSAM files in Cobol](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/tasks/tpqsm01.htm)
- [IBM Documentation: QSAM in an Application](https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.1.0/com.ibm.zos.v2r1.idad400/inanap.htm)
- [IBM Documentation: Logical Record Length](https://www.ibm.com/support/knowledgecenter/SSXJAV_13.1.0/com.ibm.filemanager.doc_13.1/base/fmnu1134.html)
[Columbus State University: Sequential File Processing](http://csc.columbusstate.edu/woolbright/QSAM.HTM) 


