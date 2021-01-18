# HELLO.CBL 

This sample demonstrates how to handle variable-length text data using the Cobol verbs INSPECT and STRING and the intrinsic function REVERSE.

## Notes 

The program prompts the user to enter a name. We don't know the length of the name the user might enter. The name may contain embedded spaces. 

We want to find the end of the name so we can append the exclamation point immediately after the last character in the name. 

There is no such thing as a zero-delimited string in (mainframe) Cobol. References to a Data Division item with Picture X always operate on the full length of the item. If we concatenate the greeting, name, and exclamation point, the result will have spaces in between the name and the exclamation point. We want to have no intervening spaces.

To do this, we use the INSPECT verb. It can count the number of leading spaces in an alphanumeric value. 

To avoid stopping when we encounter an embedded space, we count backward from the end of the WS-FRIEND field. 

To count backward, we combine the intrinsic function REVERSE with the INSPECT verb. The REVERSE function doesn't actually cause INSPECT to work backward; it just reverses the order of characters in the field. Then, INSPECT goes "forward" and counts the bytes until it finds a character other than SPACE.

We can then use the LENGTH OF special name to get the length of the WS-FRIEND field, and subtract from that the number of trailing spaces we found with the INSPECT verb. 

Then we can use STRING to concatenate the greeting message, name, and exclamation point with no intervening spaces. 

## Additional information 

- [IBM Documentation: Cobol ACCEPT statement](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/ref/rlpsacce.htm)
- [IBM Documentation: Cobol DISPLAY statement](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/ref/rlpsdisp.htm) 
- [IBM Documentation: Cobol INSPECT statement](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/ref/rlpsinsp.htm)
- [IBM Documentation: Cobol STRING statement](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/ref/rlpsstri.htm)
- [IBM Documentation: Cobol REVERSE function](https://www.ibm.com/support/knowledgecenter/en/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/tasks/tpstr19b.htm)