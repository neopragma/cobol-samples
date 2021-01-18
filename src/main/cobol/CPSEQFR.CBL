      *****************************************************************
      * Program name:    CPSEQFR                            
      * Original author: Dave Nicolette            
      *
      * Demonstrates:
      *
      * How to read and write sequential datasets with fixed-length
      * records.
      *
      * This program copies INFILE to OUTFILE and reverses the two 
      * fields in each record. It also counts the number of records
      * processed.
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  CPSEQFR.
       ENVIRONMENT DIVISION. 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL. 
           SELECT INFILE ASSIGN  TO 'INFILE1'
                  FILE STATUS IS INPUT-FILE-STATUS.
           SELECT OUTFILE ASSIGN TO 'OUTFILE1'
               FILE STATUS IS OUTPUT-FILE-STATUS.
       DATA DIVISION.
       FILE SECTION. 
       FD  INFILE 
           LABEL RECORDS ARE STANDARD       
           DATA RECORD IS INPUT-RECORD    
           RECORD CONTAINS 40 CHARACTERS
           RECORDING MODE IS F
           BLOCK CONTAINS 0 RECORDS.
       01  INPUT-RECORD.
           05 INPUT-FIRST-10      PIC X(10).
           05 INPUT-LAST-30       PIC X(30).

       FD  OUTFILE 
           LABEL RECORDS ARE STANDARD       
           DATA RECORD IS OUTPUT-RECORD    
           RECORD CONTAINS 40 CHARACTERS
           RECORDING MODE IS F
           BLOCK CONTAINS 0 RECORDS.
       01  OUTPUT-RECORD.
           05 OUTPUT-FIRST-30     PIC X(30).
           05 OUTPUT-LAST-10      PIC X(10).

       WORKING-STORAGE SECTION.
       01  WorkAreas.
           05  INPUT-FILE-STATUS  PIC X(02).
               88  GOOD-READ      VALUE '00'.
               88  END-OF-INPUT   VALUE '10'.
           05  OUTPUT-FILE-STATUS PIC X(02). 
               88  GOOD-WRITE     VALUE '00'.   
           05  RECORD-COUNT       PIC S9(5) COMP-3.

       PROCEDURE DIVISION.
           OPEN INPUT INFILE
           IF NOT GOOD-READ 
               DISPLAY 'STATUS ON INFILE OPEN: ' INPUT-FILE-STATUS
               GO TO END-OF-PROGRAM
           END-IF    
           OPEN OUTPUT OUTFILE 
           IF NOT GOOD-WRITE 
               DISPLAY 'STATUS ON OUTFILE OPEN: ' OUTPUT-FILE-STATUS 
           END-IF
           PERFORM UNTIL END-OF-INPUT
               READ INFILE 
               IF GOOD-READ 
                   MOVE INPUT-FIRST-10 TO OUTPUT-LAST-10
                   MOVE INPUT-LAST-30 TO OUTPUT-FIRST-30
                   WRITE OUTPUT-RECORD 
                   IF GOOD-WRITE 
                        ADD 1 TO RECORD-COUNT
                   ELSE
                       DISPLAY 'STATUS ON OUTFILE WRITE: ' 
                               OUTPUT-FILE-STATUS
                       GO TO END-OF-PROGRAM
                   END-IF 
               END-IF  
           END-PERFORM          
           .
       END-OF-PROGRAM.   
           DISPLAY 'NUMBER OF RECORDS PROCESSED: ' RECORD-COUNT 
           CLOSE INFILE
           CLOSE OUTFILE 
           GOBACK.

