      *****************************************************************
      * Program name:    COND88                           
      * Original author: Dave Nicolette            
      *
      * Demonstrates:
      *
      * How to use the 88-level data item in Cobol.
      *
      * This program performs various operations using 88-level data
      * items. It does not emit any output. View the source to see 
      * how to work with 88-level items ("condition names").
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  COND88.
       DATA DIVISION. 
       WORKING-STORAGE SECTION. 
       01  FILLER.
           05  THE-ANSWER               PIC X(10).
           05  FILLER                   PIC X VALUE SPACE. 
               88  SIMPLE-88                  VALUE 'T'. 
           05  FILLER                   PIC X VALUE 'F'.
               88  SIMPLE-88-WITH-FALSE       VALUE 'T', FALSE 'F'.
           05  CATEGORY-CODE            PIC X VALUE SPACE.
               88  CATEGORY-A                 VALUE 'A', '3', '7'.
               88  CATEGORY-B                 VALUE 'B', '9', 'X'.    
           05  PERSON-AGE               PIC 9(03). 
               88  PERSON-IS-A-CHILD          VALUE 0 THRU 12. 
               88  PERSON-IS-A-TEEN           VALUE 13 THRU 19. 
               88  PERSON-IS-YOUNG-ADULT      VALUE 20 THRU 35. 
               88  PERSON-IS-AN-ADULT         VALUE 36 THRU 49. 
               88  PERSON-IS-MIDDLE-AGED      VALUE 50 THRU 59. 
               88  PERSON-IS-A-SENIOR         VALUE 60 THRU 74. 
               88  PERSON-IS-ELDERLY          VALUE 75 THRU 200.     

       PROCEDURE DIVISION.

      * Example 1: Simple 88-level.     

           SET SIMPLE-88 TO TRUE 
           IF SIMPLE-88 
               MOVE 'true' TO THE-ANSWER 
           END-IF 

           IF NOT SIMPLE-88
               MOVE 'false' TO THE-ANSWER 
           END-IF 

      * Example 2: 88-level with FALSE clause

           SET SIMPLE-88-WITH-FALSE TO TRUE 
           IF SIMPLE-88-WITH-FALSE
               MOVE 'true' TO THE-ANSWER 
           END-IF 

           SET SIMPLE-88-WITH-FALSE TO FALSE 
           IF NOT SIMPLE-88-WITH-FALSE
               MOVE 'false' TO THE-ANSWER 
           END-IF     

      * Example 3: 88-level with multiple values 

           SET CATEGORY-A TO TRUE 
           IF  CATEGORY-A 
               MOVE 'true' TO THE-ANSWER 
           END-IF 

           MOVE 'E' TO CATEGORY-CODE 
           EVALUATE TRUE 
               WHEN CATEGORY-A 
                  MOVE 'A' TO THE-ANSWER 
               WHEN CATEGORY-B 
                  MOVE 'B' TO THE-ANSWER     
               WHEN OTHER
                  MOVE '?' TO THE-ANSWER 
           END-EVALUATE
               
      * Example 4: 88-level with a range of values 

           MOVE 37 TO PERSON-AGE 
           EVALUATE TRUE   
               WHEN PERSON-IS-A-CHILD 
                   MOVE 'child' TO THE-ANSWER 
               WHEN PERSON-IS-A-TEEN 
                   MOVE 'teen' TO THE-ANSWER 
               WHEN PERSON-IS-YOUNG-ADULT 
                   MOVE 'young' TO THE-ANSWER 
               WHEN PERSON-IS-AN-ADULT  
                   MOVE 'adult' TO THE-ANSWER 
               WHEN PERSON-IS-MIDDLE-AGED 
                   MOVE 'middle' TO THE-ANSWER 
               WHEN PERSON-IS-A-SENIOR 
                   MOVE 'senior' TO THE-ANSWER 
               WHEN PERSON-IS-ELDERLY 
                   MOVE 'elderly' TO THE-ANSWER                 
               WHEN OTHER 
                   MOVE 'ageless' TO THE-ANSWER     
           END-EVALUATE         

           GOBACK
           .