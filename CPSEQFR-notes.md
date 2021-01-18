# CPSEQFR.CBL 

This sample demonstrates how to read and write sequential datasets (files) that have fixed record lengths.

## Notes 

A variety of dataset types exist, and each is handled in its own way. This example pertains to sequential datasets handled by the Queued Sequential Access Method (QSAM). This is the most common basic sequential dataset type on the mainframe system. It is an extension of the older Basic Sequential Access Method (BSAM) that uses a simple buffering mechanism to improve the efficiency of I/O operations.

Records in QSAM datasets are not delimited by newline characters like text files on other systems. Instead, they contain a string of bytes with no delimiters or markers embedded in the data. For QSAM files with fixed-length logical records, we tell our program the length of a logical record for a given dataset. I/O processing presents each logical record to our program based on the length we specify. 

Open the sample files INFILE1 and OUTFILE1 to see this sort of content. Now compare the contents of INFILE1 with the specifications under the FD for INFILE1 in program CPSEQFR. The relevant statements are:

```
           RECORD CONTAINS 40 CHARACTERS
           RECORDING MODE IS F
           BLOCK CONTAINS 0 RECORDS.
```

Here we are telling our program that this file contains logical records 40 characters long. The "recording mode" of "F" means "fixed-length records." The maximum allowed length of a logical record for fixed-length datasets is 32,760. For variable-length datasets, the limit is 32,752. For fixed-length datasets, you can omit the RECORD CONTAINS clause and let the system determine the logical record size based on JCL or on the length of the 01-level item under the FD that describes the record layout.

A _block_ consists of one or more logical records that the system handles in a single I/O operation. The block size is the number of bytes read or written physically, while the logical record size is the number of bytes our program treats as a "record."

When we specify block size zero in Cobol, it means we want the system to determine the block size and our program doesn't care what it is. This is the usual specification in Cobol programs, as it allows the organization the flexibility to change block sizes of files for efficiency without causing Cobol applications to fail. In rare cases, your program may depend on a file having a particular block size. You can specify that size in the BLOCK CONTAINS clause. 

## Additional information 

- [IBM Documentation: Dataset Record Formats](https://www.ibm.com/support/knowledgecenter/zosbasics/com.ibm.zos.zconcepts/zconcepts_159.htm)
- [IBM Documentation: Processing QSAM files in Cobol](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/tasks/tpqsm01.htm)
- [IBM Documentation: QSAM in an Application](https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.1.0/com.ibm.zos.v2r1.idad400/inanap.htm)
- [IBM Documentation: Logical Record Length](https://www.ibm.com/support/knowledgecenter/SSXJAV_13.1.0/com.ibm.filemanager.doc_13.1/base/fmnu1134.html)
[Columbus State University: Sequential File Processing](http://csc.columbusstate.edu/woolbright/QSAM.HTM) 


