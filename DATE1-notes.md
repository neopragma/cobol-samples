# DATE1.CBL 

This sample demonstrates how to obtain the current system date and time via the intrinsic function CURRENT-DATE.

## Notes 

The program uses FUNCTION CURRENT-DATE to get the current date and time values, and formats the date and time information in various ways.  

Compared with the older method of using the ACCEPT statement to obtain system date and time values, the CURRENT-DATE function offers the advantage that it provides timezone offset information. However, it provides the time value only down to a precision of whole seconds. For a comparison with the ACCEPT method, please see the [DATE2 sample program](DATE2-notes.md).

#### Example 1: NCSA common log format 

The format looks like this: 

```
[19/Jan/2021:05:51:04 -0800]
``` 

#### Example 2: Verbose date 

The format looks like this: 

```
January 19th, 2021
```

### Example 3: US-style shorthand date 

The format looks like this (representing January 19, 2021): 

```
01/19/21
```

### Example 4: European-style shorthand date 

The format looks like this (representing January 19, 2021): 

```
19.01.21
```

## Additional information 

- [IBM Documentation: Cobol CURRENT-DATE Intrinsic Function](https://www.ibm.com/support/knowledgecenter/SSQ2R2_9.5.1/com.ibm.ent.cbl.zos.doc/PGandLR/ref/rlinfcur.html)
- [IBM Documentation: Common Log Formats](https://publib.boulder.ibm.com/tividd/td/ITWSA/ITWSA_info45/en_US/HTML/guide/c-logs.html#common)
- [IBM Documentation: Cobol Divide Statement](https://www.ibm.com/support/knowledgecenter/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/ref/rlpsdivi.htm)
- [IBM Documentation: Handling Cobol Tables](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/tasks/tptbl02.htm)

