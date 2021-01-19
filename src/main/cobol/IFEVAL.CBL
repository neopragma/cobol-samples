      *****************************************************************
      * Program name:    IFEVAL                           
      * Original author: Dave Nicolette            
      *
      * Demonstrates:
      *
      * The Cobol IF/ELSE statement and EVALUATE statement.
      *
      * This program performs various comparisons using IF/ELSE 
      * statements and EVALUATE statements. It does not emit any
      * output. The source code is meant as a reference/guide.
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  COND88.
       DATA DIVISION. 
       WORKING-STORAGE SECTION. 
       01  FILLER.
           05  RESULT-OF-COMPARE        PIC X(10).
           05  ALPHA-1                  PIC X(10).
           05  ALPHA-2                  PIC X(10). 
           05  NUMERIC-1                PIC S9(03) COMP-3.
           05  NUMERIC-2-X.
               10  NUMERIC-2            PIC S9(13) COMP-3. 

       PROCEDURE DIVISION.

      *---------------------------------------------------------------
      * Example 1: IF statement, 2 alphanumeric items.

           MOVE 'cucumber' TO ALPHA-1 
           MOVE 'radish' TO ALPHA-2

      * Compare two alphanumeric items, conventional style
           IF ALPHA-1 IS EQUAL TO ALPHA-2 
               MOVE 'equal' TO RESULT-OF-COMPARE 
           END-IF 

           IF ALPHA-1 IS NOT EQUAL TO ALPHA-2    
               MOVE 'different' TO RESULT-OF-COMPARE    
           END-IF  

           IF ALPHA-1 IS EQUAL TO ALPHA-2    
               MOVE 'equal' TO RESULT-OF-COMPARE   
           ELSE   
               MOVE 'different' TO RESULT-OF-COMPARE    
           END-IF             

      * Compare two alphanumeric items, traditional style 
           IF ALPHA-1 IS EQUAL TO ALPHA-2 
               MOVE 'equal' TO RESULT-OF-COMPARE.     

           IF ALPHA-1 IS EQUAL TO ALPHA-2 
               MOVE 'equal' TO RESULT-OF-COMPARE
           ELSE     
               MOVE 'different' TO RESULT-OF-COMPARE.           

      * Compare two alphanumeric items, modern style 
           if alpha-1 equal alpha-2   
               move 'equal' to result-of-compare   
           end-if              

      *---------------------------------------------------------------
      * Example 2: IF statement, alphanumeric field vs literal   

           IF ALPHA-1 IS EQUAL TO 'foobar'    
               MOVE 'equal' TO RESULT-OF-COMPARE    
           ELSE    
               MOVE 'different' TO RESULT-OF-COMPARE  
           END-IF 

      *---------------------------------------------------------------
      * Example 3: Verify a numeric item contains numeric data 
      * (This is to avoid a Data Exception or S0C7 runtime error)

           MOVE 'garbage' TO NUMERIC-2-X    
           IF NUMERIC-2 IS NUMERIC   
               ADD 1 TO NUMERIC-2 
           ELSE  
               MOVE 1 TO NUMERIC-2              
           END-IF 

      *---------------------------------------------------------------
      * Example 4: Verify a numeric item is greater than zero 
      * (This is to avoid divide-by-zero exceptions)  

           MOVE ZERO TO NUMERIC-1
           MOVE 100 TO NUMERIC-2 
           IF NUMERIC-1 IS GREATER THAN ZERO   
               DIVIDE 
                   NUMERIC-2 BY NUMERIC-1 
                   GIVING NUMERIC-2 
               END-DIVIDE     
           ELSE   
               SUBTRACT 1 
                   FROM NUMERIC-2 
                   GIVING NUMERIC-2  
               END-SUBTRACT    
           END-IF 

      *---------------------------------------------------------------
      * Example 5: IF statement, two numeric fields   

           MOVE 7 TO NUMERIC-1 
           MOVE 36 TO NUMERIC-2 
           IF  NUMERIC-1 IS GREATER THAN NUMERIC-2 
               MOVE 'numeric-1' TO RESULT-OF-COMPARE
           ELSE 
               MOVE 'numeric-2' TO RESULT-OF-COMPARE
           END-IF        

      *---------------------------------------------------------------
      * Example 6: EVALUATE statement  

           MOVE 8 TO NUMERIC-1  
           MOVE 13 TO NUMERIC-2 

           EVALUATE TRUE 
               WHEN NUMERIC-1 IS GREATER THAN NUMERIC-2 
                  MOVE 'numeric-1' TO RESULT-OF-COMPARE   
               WHEN NUMERIC-1 < NUMERIC-2 
                  MOVE 'numeric-2' TO RESULT-OF-COMPARE    
               WHEN OTHER
                  MOVE 'equal' TO RESULT-OF-COMPARE
           END-EVALUATE

      *---------------------------------------------------------------
      * Example 6: EVALUATE statement, two conditions  

           MOVE 8 TO NUMERIC-1  
           MOVE 13 TO NUMERIC-2 
           MOVE 'THX-1138' TO ALPHA-1    
           MOVE 'Terminator' TO ALPHA-2 

           EVALUATE TRUE ALSO TRUE 
               WHEN NUMERIC-1 IS GREATER THAN NUMERIC-2 
               ALSO ALPHA-1(1:3) EQUAL 'THX'
                  MOVE 'THX and numeric-1' TO RESULT-OF-COMPARE   
               WHEN NUMERIC-1 < NUMERIC-2 
               ALSO ALPHA-1(1:3) EQUAL 'THX'
                  MOVE 'THX and numeric-2' TO RESULT-OF-COMPARE 
               WHEN NUMERIC-1 = NUMERIC-1 
               ALSO ALPHA-2 = 'Terminator'
                  MOVE 'Terminator and equal numbers' 
                      TO RESULT-OF-COMPARE      
               WHEN OTHER
                  MOVE 'undefined' TO RESULT-OF-COMPARE
           END-EVALUATE

           GOBACK
           .


