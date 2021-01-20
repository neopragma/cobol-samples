# ATTRACK.CBL 

This sample demonstrates scientific computing in Cobol. 

## Notes 

Cobol is not the language of choice for scientific computing, but it can perform computations using floating-point values and has a few intrinsic functions that are useful in this domain. The sample program computes the gravitational attraction between two moving bodies in space at a point in time. 

The result is not accurate, as there is no atan2 function for Cobol (as of this writing). You can see the source comments and workaround in the source code. 

The point is not to calculate the gravitational attraction accurately, but rather to illustrate how you might write computations like this in Cobol.

The style of coding is also a little different from the other examples, in that it uses lower case and mixed case. The point of doing that is to demonstrate that the Cobol compiler is case-agnostic. That is, all these item names refer to the same item in a Cobol program: 

```
           account-number 
           ACCOUNT-NUMBER 
           Account-Number 
           acCoUnT-nuMBeR 
``` 

These names are also possible, if this style makes sense to you. They aren't equivalent to the ones above, as there is no dash between the two words. But they are equivalent to each other.  

``` 
           accountNumber 
           AccountNumber 
```           

#### Running ATTRACT 

ATTRACT prompts the user to enter (on stdin or CONSOLE) the following attributes of two bodies in space: 

- mass 
- velocity on the x axis 
- velocity on the y axis 
- position on the x axis 
- position on the y axis 

It then computes the force of graviational attraction between the two bodies, and the direction of force along the x and y axes (except for the lack of an atan2 function) and displays the results on stdout (SYSOUT).

## Additional information 

- [Simulating Planetary Orbits](https://fiftyexamples.readthedocs.io/en/latest/gravity.html) 
- [atan2 general information](https://en.wikipedia.org/wiki/Atan2)
- [C function source for atan2](https://opensource.apple.com/source/Libm/Libm-93/ppc.subproj/atan2.c.auto.html)
- [IBM Documentation: Cobol ATAN Function](https://www.ibm.com/support/knowledgecenter/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/ref/rlinfata.htm)
- [IBM Documentation: Cobol COS Function](https://www.ibm.com/support/knowledgecenter/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/ref/rlinfcos.htm)
- [IBM Documentation: Cobol SIN Function](https://www.ibm.com/support/knowledgecenter/SS6SG3_4.2.0/com.ibm.entcobol.doc_4.2/PGandLR/ref/rlinfsin.htm)
- [IBM Documentation: Formats for Numeric Data](https://www.ibm.com/support/knowledgecenter/SS6SG3_6.2.0/pg/concepts/cpari09.html)


