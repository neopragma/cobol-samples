      *****************************************************************
      * Program name:    DATE2                            
      * Original author: Dave Nicolette            
      *
      * Demonstrates:
      *
      * How to get the current date and time using the Cobol ACCEPT
      * statement 
      *
      * This program uses ACCEPT to obtain the values of "conceptual
      * data items" related to the current system date and time.
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  DATE2.
       DATA DIVISION. 
       WORKING-STORAGE SECTION. 
       01  DATE-DATA.
           05  DATE-VALUE.
               10  DATE-YY                 PIC X(02).
               10  DATE-MM                 PIC X(02).
               10  DATE-DD                 PIC X(02).
           05  DATE-YYYYMMDD-VALUE.
               10  DATE-YYYY               PIC X(04).
               10  DATE-MM                 PIC 9(02).
               10  DATE-DD                 PIC X(02).
           05  DAY-VALUE.
               10  DAY-YY                  PIC X(02).
               10  DAY-DDD                 PIC X(03).
           05  DAY-YYYYDDD-VALUE.    
               10  DAY-YYYY                PIC X(04).
               10  DAY-DDD                 PIC X(03).
           05  DAY-OF-WEEK-VALUE           PIC 9.
           05  TIME-VALUE.
               10  TIME-HOUR               PIC X(02).    
               10  TIME-MINUTE             PIC X(02).    
               10  TIME-SECOND             PIC X(02).    
               10  TIME-HUNDREDTHS         PIC X(02).    

       01  FULL-DATE                       PIC X(50).
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

       01  DAY-NAMES-DATA.
           05  FILLER PIC X(09) VALUE 'Monday'.    
           05  FILLER PIC X(09) VALUE 'Tuesday'.    
           05  FILLER PIC X(09) VALUE 'Wednesday'.    
           05  FILLER PIC X(09) VALUE 'Thursday'.    
           05  FILLER PIC X(09) VALUE 'Friday'.    
           05  FILLER PIC X(09) VALUE 'Saturday'.    
           05  FILLER PIC X(09) VALUE 'Sunday'. 
       01  FILLER REDEFINES DAY-NAMES-DATA. 
           05  DAY-NAME OCCURS 7 PIC X(09).       

       PROCEDURE DIVISION.
      * These are predefined "conceptual data items" 
           ACCEPT DATE-VALUE          FROM DATE 
           ACCEPT DATE-YYYYMMDD-VALUE FROM DATE YYYYMMDD
           ACCEPT DAY-VALUE           FROM DAY 
           ACCEPT DAY-YYYYDDD-VALUE   FROM DAY YYYYDDD 
           ACCEPT DAY-OF-WEEK-VALUE   FROM DAY-OF-WEEK
           ACCEPT TIME-VALUE          FROM TIME 

      * Format the date with full month name and ordinal day 

           DIVIDE DATE-DD IN DATE-YYYYMMDD-VALUE BY 10 
               GIVING DAY-DIV-BY-10
               REMAINDER DAY-LAST-DIGIT
           END-DIVIDE    

           STRING 
               'Today is ' 
                   DELIMITED BY SIZE 
               DAY-NAME(DAY-OF-WEEK-VALUE) 
                   DELIMITED BY SPACE 
               ', the ' 
                   DELIMITED BY SIZE 
               DATE-DD IN DATE-YYYYMMDD-VALUE
                   DELIMITED BY SIZE 
               DAY-ORDINAL(DAY-LAST-DIGIT) 
                   DELIMITED BY SIZE 
               ' of ' 
                   DELIMITED BY SIZE     
               MONTH-NAME(DATE-MM IN DATE-YYYYMMDD-VALUE)
                   DELIMITED BY SPACE 
               ', '
                   DELIMITED BY SIZE 
               DATE-YYYY OF DATE-YYYYMMDD-VALUE 
                   DELIMITED BY SIZE      
               INTO FULL-DATE 
           END-STRING    

           DISPLAY SPACE 
           DISPLAY 'Example 1: Current date formatted verbosely: '
                   FULL-DATE

      * Typical shorthand date, US format MM/DD/YY 

           MOVE DATE-MM OF DATE-VALUE 
                TO MONTH OF SHORTHAND-DATE-US-STYLE 
           MOVE DATE-DD OF DATE-VALUE 
                TO DAY-OF-MONTH OF SHORTHAND-DATE-US-STYLE 
           MOVE DATE-YY OF DATE-VALUE 
                TO YEAR-2-DIGIT OF SHORTHAND-DATE-US-STYLE     
           DISPLAY SPACE. 
           DISPLAY 'Example 2: Shorthand date, '
                   'US style MM/DD/YY: '
                   SHORTHAND-DATE-US-STYLE 

      * Typical shorthand date, European format DD.MM.YY 

           MOVE DATE-MM OF DATE-VALUE 
                TO MONTH OF SHORTHAND-DATE-EURO-STYLE 
           MOVE DATE-DD OF DATE-VALUE 
                TO DAY-OF-MONTH OF SHORTHAND-DATE-EURO-STYLE 
           MOVE DATE-YY OF DATE-VALUE 
                TO YEAR-2-DIGIT OF SHORTHAND-DATE-EURO-STYLE     
           DISPLAY SPACE. 
           DISPLAY 'Example 3: Shorthand date, '
                   'European style DD.MM.YY: '
                   SHORTHAND-DATE-EURO-STYLE 
           
      * Time with precision of hundredths of a second

           DISPLAY SPACE 
           DISPLAY 'Example 4: Time with precision of hundredths '
                   'of a second:' 
           DISPLAY TIME-HOUR ':' TIME-MINUTE ':' TIME-SECOND 
                   '.' TIME-HUNDREDTHS             

           GOBACK
           .