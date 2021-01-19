# DATE2.CBL 

This sample demonstrates how to obtain the current system date and time via the _conceptual data items_ DATE, DATE YYYYMMDD, DAY, DAY YYYYDDD, DAY-OF-WEEK, and TIME.

## Notes 

The program uses the ACCEPT statement to get the values of the conceptual data items listed above, and formats various displays of date and time values.  

This is an older method of obtaining the current date and time which is still present in many existing legacy Cobol applications. Although an older method, it offers two pieces of information the instrinsic function CURRENT-DATE does not: 

- day of the week 
- time down to the hundredths of a second.  

On the other hand, this method does not provide us with the timezone offset fromm UTC. For a comparison of methods, see the [DATE1 sample program](DATE1-notes.md).

#### Example 1: Verbose date including day of week

The format looks like this: 

```
Today is Tuesday, the 19th of January, 2021
```

### Example 2: US-style shorthand date 

The format looks like this (representing January 19, 2021): 

```
01/19/21
```

### Example 3: European-style shorthand date 

The format looks like this (representing January 19, 2021): 

```
19.01.21
```

### Example 4: Time down to hundredths of a second

The format looks like this:: 

```
07:52:18.29
```

## Additional information 

- [IBM Documentation: Cobol Accept Statement](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/ref/rlpsacce.htm)
- [IBM Documentation: Cobol Divide Statement](https://www.ibm.com/support/knowledgecenter/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/ref/rlpsdivi.htm)
- [IBM Documentation: Handling Cobol Tables](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/tasks/tptbl02.htm)

