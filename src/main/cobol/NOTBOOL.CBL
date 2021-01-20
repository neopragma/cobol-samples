      *****************************************************************
      * Program name:    NOTBOOL                           
      * Original author: Dave Nicolette            
      *
      * Demonstrates:
      *
      * Legacy code conventions to simulate boolean data items.
      *
      * Until ANSI 2002 Cobol, the language had no true boolean type.
      * Even with that standard, the implementation of boolean items
      * is unusual and inconsistent from one platform to another. 
      * This program emits no output. Use the source as a reference.
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  NOTBOOL.
       DATA DIVISION. 
       WORKING-STORAGE SECTION. 
       01  FILLER.
           05  THE-ANSWER                     PIC X(40).

      * Bit flags and boolean literals do not compile properly 
      * on GnuCOBOL. This code or very similar code should work
      * with IBM Enterprise Cobol on z/OS.     
      *     05  BIT-FLAGS              PIC 1111 USAGE BIT VALUE B"0000".

           05  EX2-FLAG                 PIC X VALUE SPACE.
           05  EX2-TRUE-VALUE           PIC X VALUE 'T'.

           05  EX3-FLAG                 PIC X VALUE 'N'.
           05  EX3-YES-VALUE            PIC X VALUE 'Y'.

           05  EX4-FLAG                  PIC X VALUE '1'.
           05  EX4-TRUE-VALUE            PIC X VALUE '1'.
           05  EX4-FALSE-VALUE           PIC X VALUE '0'.

           05  EX5-FIELD                 PIC X. 
               88  EX5-FLAG              VALUE 'T'. 

           05  FILLER                    PIC X. 
               88  EX6-FLAG              VALUE 'T', FALSE 'F'. 

           05  EX7-FLAG                  PIC S9 COMP-3 VALUE -1.
           05  EX7-TRUE                  PIC S9 COMP-3 VALUE 1.
           05  EX7-FALSE                 PIC S9 COMP-3 VALUE -1. 

       PROCEDURE DIVISION.
      *----------------------------------------------------------------
      * Example 1: BIT and BOOLEAN types (since ANSI 2002) 

      * Bit flags and boolean literals do not compile properly 
      * on GnuCOBOL. This code or very similar code should work
      * with IBM Enterprise Cobol on z/OS.    
      * B"1" is supposed to evaluate to TRUE.
      * B"0" is supposed to evaluate to FALSE. 

      *     MOVE B"0011" TO BIT-FLAGS
      *     MOVE B"1" TO BIT-FLAGS(1:1)
      *     COMPUTE BIT-FLAGS = BIT-FLAGS B-AND B"0110"
      *     IF BIT-FLAGS(2:1) 
      *         MOVE 'second flag is set' TO THE-ANSWER
      *     END-IF     

      *----------------------------------------------------------------
      * Example 2: Pseudo-boolean based on a coding convention 
      * PIC X where 'T' = true and SPACE = false 

      * Set the flag
           MOVE EX2-TRUE-VALUE TO EX2-FLAG 

      * Test the flag
           IF EX2-FLAG EQUAL EX2-TRUE-VALUE 
               MOVE 'true' TO THE-ANSWER 
           ELSE 
               MOVE 'false' TO THE-ANSWER 
           END-IF         

      * Toggle the flag 
           IF EX2-FLAG EQUAL EX2-TRUE-VALUE 
               MOVE SPACE TO EX2-FLAG 
           ELSE  
               MOVE EX2-TRUE-VALUE TO EX2-FLAG 
           END-IF         

      *----------------------------------------------------------------
      * Example 3: Pseudo-boolean based on a coding convention 
      * PIC X where 'Y' = yes and 'N' = no 

      * Set the flag
           MOVE EX3-YES-VALUE TO EX3-FLAG 

      * Test the flag
           IF EX3-FLAG EQUAL EX3-YES-VALUE 
               MOVE 'yes' TO THE-ANSWER 
           ELSE 
               MOVE 'no' TO THE-ANSWER 
           END-IF         

      * Another coding style:

           if ex3-flag not equal ex3-yes-value 
               move 'no' to the-answer.

      * Toggle the flag 
           IF EX3-FLAG EQUAL EX3-YES-VALUE 
               MOVE 'N' TO EX3-FLAG 
           ELSE          
               MOVE EX3-YES-VALUE TO EX3-FLAG 
           END-IF 

      *----------------------------------------------------------------
      * Example 4: Pseudo-boolean based on a coding convention 
      * PIC X where '1' = true and '0' = false 

      * Set the flag
           MOVE EX4-TRUE-VALUE TO EX4-FLAG 

      * Test the flag
           EVALUATE TRUE
               WHEN EX4-FLAG EQUAL EX4-TRUE-VALUE
                  MOVE 'true' TO THE-ANSWER 
               WHEN EX4-FLAG EQUAL EX4-FALSE-VALUE   
                  MOVE 'false' TO THE-ANSWER  
               WHEN OTHER
                  MOVE 'not set' TO THE-ANSWER
           END-EVALUATE

      * Toggle the flag 
           IF EX4-FLAG EQUAL EX4-TRUE-VALUE 
               MOVE EX4-FALSE-VALUE TO EX4-FLAG 
           ELSE 
               MOVE EX4-TRUE-VALUE TO EX4-FLAG 
           END-IF 

      *----------------------------------------------------------------
      * Example 5: Pseudo-boolean using 88-level items without FALSE

      * Set the flag 
           SET EX5-FLAG TO TRUE 

      * Test the flag 
           if Ex5-Flag 
               move 'true' to The-Answer 
           end-if    
      
      * Toggle the flag 
           IF EX5-FLAG  
               MOVE SPACE TO EX5-FIELD 
           ELSE     
               SET EX5-FLAG TO TRUE
           END-IF 

      *----------------------------------------------------------------
      * Example 6: Pseudo-boolean using 88-level items with FALSE

      * Set the flag 
           SET EX6-FLAG TO TRUE 

      * Test the flag 
           if Ex6-Flag 
               move 'true' to The-Answer 
           end-if    
      
      * Toggle the flag 
           IF EX6-FLAG  
               SET EX6-FLAG TO FALSE 
           ELSE     
               SET EX5-FLAG TO TRUE
           END-IF 

      *----------------------------------------------------------------
      * Example 7: Pseudo-boolean using numeric values

      * Set the flag 
           MOVE EX7-TRUE TO EX7-FLAG 

      * Test the flag 
           if EX7-FLAG EQUAL EX7-TRUE 
               MOVE 'true' TO THE-ANSWER 
           END-IF     
      
      * Toggle the flag 
           COMPUTE EX7-FLAG = EX7-FLAG * -EX7-FLAG

           GOBACK
           .