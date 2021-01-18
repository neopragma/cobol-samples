      *****************************************************************
      * Program name:    STRINGIT                            
      * Original author: Dave Nicolette            
      *
      * Demonstrates:
      *
      * How to manipulate data items using STRING, UNSTRING, INSPECT,
      * and reference modification.
      *
      * This program performs various operations to manipulate text
      * values and displays the results on stdout (SYSOUT).
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  STRINGIT.
       DATA DIVISION. 
       WORKING-STORAGE SECTION. 
       01  FILLER. 
           05  WS-NAME.
               10  WS-FAMILY-NAME            PIC X(60) VALUE 'Kirk'.
               10  WS-GIVEN-NAME             PIC X(60) VALUE 'James'.
               10  WS-MIDDLE-NAME            PIC X(60) VALUE 'Tiberius'.
           05  WS-NAMES-IN-OUTPUT-ORDER.
               10  WS-GIVEN-NAME-OUT         PIC X(60).
               10  WS-MIDDLE-NAME-OUT        PIC X(60).
               10  WS-FAMILY-NAME-OUT        PIC X(60).
           05  WS-NAME-LENGTHS.
               10  WS-GIVEN-NAME-LENGTH      PIC S9(3) COMP-3.
               10  WS-MIDDLE-NAME-LENGTH     PIC S9(3) COMP-3.
               10  WS-FAMILY-NAME-LENGTH     PIC S9(3) COMP-3.   
               10  WS-OUTPUT-LENGTH          PIC S9(3) COMP-3. 
           05  WS-OUTPUT-AREA                PIC X(180).    

       PROCEDURE DIVISION.

           DISPLAY SPACE 
           DISPLAY 'Example 1: Formatting a person''s name '
               'using MOVE statements'
           MOVE WS-GIVEN-NAME TO WS-GIVEN-NAME-OUT
           MOVE WS-MIDDLE-NAME TO WS-MIDDLE-NAME-OUT
           MOVE WS-FAMILY-NAME TO WS-FAMILY-NAME-OUT 
           DISPLAY 'Name in first-middle-last-order:'
           DISPLAY'<' WS-NAMES-IN-OUTPUT-ORDER '>'

           DISPLAY SPACE
           DISPLAY 'Example 2: Formatting a person''s name '
               'using INSPECT and reference modification'
           INITIALIZE WS-NAME-LENGTHS
           INSPECT WS-GIVEN-NAME 
               TALLYING WS-GIVEN-NAME-LENGTH 
               FOR CHARACTERS BEFORE INITIAL SPACE 
           INSPECT WS-MIDDLE-NAME 
               TALLYING WS-MIDDLE-NAME-LENGTH 
               FOR CHARACTERS BEFORE INITIAL SPACE 
           INSPECT WS-FAMILY-NAME 
               TALLYING WS-FAMILY-NAME-LENGTH 
               FOR CHARACTERS BEFORE INITIAL SPACE 
           DISPLAY 'Name in first-middle-last order:'
           DISPLAY 
               '<'
               WS-GIVEN-NAME(1:WS-GIVEN-NAME-LENGTH)
               SPACE 
               WS-MIDDLE-NAME(1:WS-MIDDLE-NAME-LENGTH) 
               SPACE 
               WS-FAMILY-NAME(1:WS-FAMILY-NAME-LENGTH) 
               '>'

           DISPLAY SPACE 
           DISPLAY 'Example 3: Formatting a person''s name '
               'using STRING' 
           STRING 
                   WS-GIVEN-NAME  DELIMITED BY SPACE 
                   SPACE          DELIMITED BY SIZE 
                   WS-MIDDLE-NAME DELIMITED BY SPACE 
                   SPACE          DELIMITED BY SIZE 
                   WS-FAMILY-NAME DELIMITED BY SPACE 
               INTO WS-OUTPUT-AREA 
           END-STRING 
           DISPLAY '<' WS-OUTPUT-AREA '>'

           DISPLAY SPACE 
           DISPLAY 'Example 4: Combining INSPECT, STRING, and '
               'reference modification' 
           INITIALIZE WS-NAME-LENGTHS    
           INSPECT WS-GIVEN-NAME 
               TALLYING WS-GIVEN-NAME-LENGTH 
               FOR CHARACTERS BEFORE INITIAL SPACE 
           INSPECT WS-MIDDLE-NAME 
               TALLYING WS-MIDDLE-NAME-LENGTH 
               FOR CHARACTERS BEFORE INITIAL SPACE 
           INSPECT WS-FAMILY-NAME 
               TALLYING WS-FAMILY-NAME-LENGTH 
               FOR CHARACTERS BEFORE INITIAL SPACE 
           STRING 
                   WS-GIVEN-NAME(1:WS-GIVEN-NAME-LENGTH) 
                     DELIMITED BY SIZE 
                   SPACE DELIMITED BY SIZE 
                   WS-MIDDLE-NAME(1:WS-MIDDLE-NAME-LENGTH)
                     DELIMITED BY SIZE     
                   SPACE DELIMITED BY SIZE 
                   WS-FAMILY-NAME(1:WS-FAMILY-NAME-LENGTH) 
                     DELIMITED BY SIZE     
               INTO WS-OUTPUT-AREA
           END-STRING
           ADD WS-GIVEN-NAME-LENGTH 
               WS-MIDDLE-NAME-LENGTH 
               WS-FAMILY-NAME-LENGTH 
               2
               GIVING WS-OUTPUT-LENGTH 
           END-ADD    
           DISPLAY '<' WS-OUTPUT-AREA(1:WS-OUTPUT-LENGTH) '>'

           GOBACK
           .