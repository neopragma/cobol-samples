      *****************************************************************
      * Program name:    CPSEQFR                            
      * Original author: Dave Nicolette            
      *
      * Demonstrates:
      *
      * How to read and write sequential datasets (QSAM) with 
      * variable-length records.
      *
      * This program reads VARFILE1, appends data to each record, and
      * writes the records to VARFILE2. It also counts the number of 
      * records processed.
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  CPSEQVR.
       ENVIRONMENT DIVISION. 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL. 
           SELECT INFILE ASSIGN  TO 'VARFILE1'
                  FILE STATUS IS INPUT-FILE-STATUS.
           SELECT OUTFILE ASSIGN  TO 'VARFILE2'
                  FILE STATUS IS OUTPUT-FILE-STATUS.
       DATA DIVISION.
       FILE SECTION. 
       FD  INFILE 
           DATA RECORD IS INPUT-RECORD    
           RECORDING MODE IS V
           BLOCK CONTAINS 0
           RECORD IS VARYING 5 TO 50 DEPENDING ON IN-RECLEN.
       01  INPUT-RECORD            PIC X(50).
       FD  OUTFILE 
           DATA RECORD IS OUTPUT-RECORD    
           RECORDING MODE IS V
           BLOCK CONTAINS 0
           RECORD IS VARYING 5 TO 50 DEPENDING ON OUT-RECLEN.
       01  OUTPUT-RECORD            PIC X(50).
       WORKING-STORAGE SECTION.
       01  WorkAreas.
           05  IN-RECLEN            PIC S9(9) COMP.
           05  OUT-RECLEN           PIC S9(4) COMP.
           05  INPUT-FILE-STATUS    PIC X(02).
               88  INFILE-OK        VALUE '00'.
               88  END-OF-INPUT     VALUE '10'.
           05  OUTPUT-FILE-STATUS   PIC X(02).
               88  OUTFILE-OK       VALUE '00'.
           05  RECORD-COUNT         PIC S9(5) COMP-3.
           05  FIELD-COUNT          PIC S9(3) COMP-3.
       01  RECORD-AREA.
           05  RECORD-FIELD OCCURS 1 TO 10 DEPENDING ON FIELD-COUNT
                                    PIC X(05).    

       PROCEDURE DIVISION.
           OPEN INPUT INFILE
           IF NOT INFILE-OK 
               DISPLAY 'INFILE STATUS ON OPEN: ' INPUT-FILE-STATUS
               GO TO END-OF-PROGRAM
           END-IF    
           OPEN OUTPUT OUTFILE
           IF NOT OUTFILE-OK
               DISPLAY 'OUTFILE STATUS ON OPEN: ' OUTPUT-FILE-STATUS
               GO TO END-OF-PROGRAM
           END-IF   
           PERFORM UNTIL END-OF-INPUT 
               READ INFILE 
               IF INFILE-OK
                   COMPUTE FIELD-COUNT = 
                       IN-RECLEN / LENGTH OF RECORD-FIELD
                   MOVE INPUT-RECORD TO RECORD-AREA
                   ADD 1 TO FIELD-COUNT 
                   MOVE 'XXXXX' TO RECORD-FIELD(FIELD-COUNT)
                   COMPUTE OUT-RECLEN = 
                       FIELD-COUNT * LENGTH OF RECORD-FIELD
                   WRITE OUTPUT-RECORD FROM RECORD-AREA
                   ADD 1 TO RECORD-COUNT
           END-PERFORM    
               .
       END-OF-PROGRAM.   
           DISPLAY 'NUMBER OF RECORDS PROCESSED: ' RECORD-COUNT 
           CLOSE INFILE
           CLOSE OUTFILE
           GOBACK.

