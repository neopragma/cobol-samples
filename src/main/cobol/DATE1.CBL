      *****************************************************************
      * Program name:    DATE1                            
      * Original author: Dave Nicolette            
      *
      * Demonstrates:
      *
      * How to get the current date and time using the intrinsic
      * function CURRENT-DATE
      *
      * This program calls intrinsic function CURRENT-DATE and 
      * displays various date and time fields the function returns.
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  DATE1.
       DATA DIVISION. 
       WORKING-STORAGE SECTION. 
       01  CURRENT-DATE-DATA.
           05  CURRENT-DATE.
               10  FULL-YEAR               PIC 9(04).
               10  FILLER REDEFINES FULL-YEAR.
                   15  CENTURY             PIC 9(02).
                   15  YEAR-2-DIGIT        PIC 9(02).
               10  MONTH                   PIC 9(02).
               10  DAY-OF-MONTH            PIC 9(02).
           05  CURRENT-TIME.
               10  HOUR                    PIC 9(02).
               10  MINUTE                  PIC 9(02).
               10  SECOND                  PIC 9(02).
               10  MILLISECONDS            PIC 9(02).
           05  TIMEZONE-INFORMATION.
               10  TIMEZONE-DIRECTION      PIC X(01).
               10  TIMEZONE-OFFSET-HOURS   PIC 9(02).
               10  TIMEZONE-OFFSET-MINUTES PIC 9(02).    

       01  NCSA-TIMESTAMP.
           05  FILLER                      PIC X VALUE "[".
           05  DAY-OF-MONTH                PIC 9(02).
           05  FILLER                      PIC X VALUE "/".
           05  MONTH-ABBR                  PIC X(3).
           05  FILLER                      PIC X VALUE "/".
           05  FULL-YEAR                   PIC 9(04).
           05  FILLER                      PIC X VALUE ":".
           05  HOUR                        PIC 9(02).
           05  FILLER                      PIC X VALUE ":".
           05  MINUTE                      PIC 9(02).
           05  FILLER                      PIC X VALUE ":".
           05  SECOND                      PIC 9(02).   
           05  FILLER                      PIC X VALUE SPACE.
           05  TIMEZONE-DIRECTION          PIC X.
           05  TIMEZONE-OFFSET-HOURS       PIC 9(02).
           05  TIMEZONE-OFFSET-MINUTES     PIC 9(02).    
           05  FILLER                      PIC X VALUE "]".

       01  FULL-DATE                       PIC X(40).
       01  DAY-CALCULATION-FIELDS.
           05  DAY-DIV-BY-10               PIC 9.
           05  DAY-LAST-DIGIT              PIC 9.

       01  SHORTHAND-DATE-US-STYLE.
           05  MONTH                       PIC 9(02).
           05  FILLER                      PIC X VALUE "/".
           05  DAY-OF-MONTH                PIC 9(02).
           05  FILLER                      PIC X VALUE "/".
           05  YEAR-2-DIGIT                PIC 9(02).

       01  SHORTHAND-DATE-EURO-STYLE.
           05  DAY-OF-MONTH                PIC 9(02).
           05  FILLER                      PIC X VALUE ".".
           05  MONTH                       PIC 9(02).
           05  FILLER                      PIC X VALUE ".".
           05  YEAR-2-DIGIT                PIC 9(02).

       01  MONTH-ABBR-DATA.
           05  FILLER PIC X(11) VALUE '01January'.     
           05  FILLER PIC X(11) VALUE '02February'.     
           05  FILLER PIC X(11) VALUE '03March'.     
           05  FILLER PIC X(11) VALUE '04April'.     
           05  FILLER PIC X(11) VALUE '05May'.     
           05  FILLER PIC X(11) VALUE '06June'.     
           05  FILLER PIC X(11) VALUE '07July'.     
           05  FILLER PIC X(11) VALUE '08August'.     
           05  FILLER PIC X(11) VALUE '09September'.     
           05  FILLER PIC X(11) VALUE '10October'.     
           05  FILLER PIC X(11) VALUE '11November'.     
           05  FILLER PIC X(11) VALUE '12December'.   
       01  FILLER REDEFINES MONTH-ABBR-DATA.
           05  MONTH-ENTRY OCCURS 12 INDEXED BY MONTH-INDEX.
               10  MONTH-NUMBER             PIC 9(02).
               10  MONTH-NAME.
                   15  MONTH-ABBREV         PIC X(03).
                   15  FILLER               PIC X(06).     

       01  DAY-ORDINALS-DATA. 
           05  FILLER PIC X(02) VALUE 'th'.
           05  FILLER PIC X(02) VALUE 'st'.
           05  FILLER PIC X(02) VALUE 'nd'.
           05  FILLER PIC X(02) VALUE 'rd'.
           05  FILLER PIC X(02) VALUE 'th'.
           05  FILLER PIC X(02) VALUE 'th'.
           05  FILLER PIC X(02) VALUE 'th'.
           05  FILLER PIC X(02) VALUE 'th'.
           05  FILLER PIC X(02) VALUE 'th'.
           05  FILLER PIC X(02) VALUE 'th'.
       01  FILER REDEFINES DAY-ORDINALS-DATA.
           05  DAY-ORDINAL OCCURS 10 PIC X(02).

       PROCEDURE DIVISION.
           MOVE FUNCTION CURRENT-DATE to CURRENT-DATE-DATA

      * Format the date and time consistent with the NCSA common 
      * log format

           MOVE CORRESPONDING CURRENT-DATE TO NCSA-TIMESTAMP
           MOVE CORRESPONDING CURRENT-TIME TO NCSA-TIMESTAMP
           MOVE CORRESPONDING TIMEZONE-INFORMATION TO NCSA-TIMESTAMP
           MOVE MONTH-ABBREV(MONTH IN CURRENT-DATE) 
             TO MONTH-ABBR IN NCSA-TIMESTAMP 
           
           DISPLAY SPACE 
           DISPLAY 'Example 1: Timestamp in NCSA common log format: '
                   NCSA-TIMESTAMP

      * Format the date with full month name and ordinal day 

           DIVIDE DAY-OF-MONTH IN CURRENT-DATE BY 10 
               GIVING DAY-DIV-BY-10
               REMAINDER DAY-LAST-DIGIT
           END-DIVIDE    

           STRING 
               MONTH-NAME(MONTH IN CURRENT-DATE)
                   DELIMITED BY SPACE 
               SPACE 
                   DELIMITED BY SIZE 
               DAY-OF-MONTH IN CURRENT-DATE
                   DELIMITED BY SIZE 
               DAY-ORDINAL(DAY-LAST-DIGIT) 
                   DELIMITED BY SIZE 
               ", " 
                   DELIMITED BY SIZE 
               FULL-YEAR OF CURRENT-DATE 
                   DELIMITED BY SIZE      
               INTO FULL-DATE 
           END-STRING    

           DISPLAY SPACE 
           DISPLAY 'Example 2: Current date formatted verbosely: '
                   FULL-DATE

      * Typical shorthand date, US format MM/DD/YY 

           MOVE CORRESPONDING CURRENT-DATE 
                TO SHORTHAND-DATE-US-STYLE
           MOVE YEAR-2-DIGIT IN CURRENT-DATE 
                TO YEAR-2-DIGIT IN SHORTHAND-DATE-US-STYLE      
           DISPLAY SPACE. 
           DISPLAY 'Example 3: Shorthand date, '
                   'US style MM/DD/YY: '
                   SHORTHAND-DATE-US-STYLE 

      * Typical shorthand date, European format DD.MM.YY 

           MOVE CORRESPONDING CURRENT-DATE 
                TO SHORTHAND-DATE-EURO-STYLE
           MOVE YEAR-2-DIGIT IN CURRENT-DATE 
                TO YEAR-2-DIGIT IN SHORTHAND-DATE-EURO-STYLE      
           DISPLAY SPACE. 
           DISPLAY 'Example 4: Shorthand date, '
                   'European style DD.MM.YY: '
                   SHORTHAND-DATE-EURO-STYLE 
           
           


           GOBACK
           .