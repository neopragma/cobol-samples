      *****************************************************************
      * Program name:    MOVEME                            
      * Original author: Dave Nicolette            
      *
      * Demonstrates:
      *
      * How to assign alphanumeric values to Data Division items using
      * the MOVE statement.
      *
      * This program performs various assignments using MOVE and
      * displays the results on stdout (SYSOUT). The accompanying
      * notes file (MOVE-notes.md) provides explanations of the effects
      * of the assignments on data in memory.
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  MOVEME.
       DATA DIVISION. 
       WORKING-STORAGE SECTION. 
       01  WS-DATA-ITEMS.
           05  WS-ELEMENTARY-ITEM                   PIC X(20).
           05  WS-SAMPLE-DATA-ITEMS. 
               10  WS-BINARY-ITEM-4-AS-TEXT.
                   15  WS-BINARY-ITEM-4             PIC S9(09) COMP. 
               10  WS-BINARY-ITEM-8-AS-TEXT.
                   15  WS-BINARY-ITEM-8             PIC S9(16) COMP. 
               10  WS-PACKED-DECIMAL-ITEM-AS-TEXT.
                   15  WS-PACKED-DECIMAL-ITEM       
                   PIC S9(04)V9(03) COMP-3.
               10  WS-SINGLE-PRECISION-AS-TEXT.
                   15  WS-SINGLE-PRECISION          COMP-1.
               10  WS-DOUBLE-PRECISION-AS-TEXT.
                   15  WS-DOUBLE-PRECISION          COMP-2.

               10  WS-DISPLAY-NUMERIC-SIGNED-TEXT.    
                   15  WS-DISPLAY-NUMERIC-SIGNED    PIC S9(05)V9(02).
               10  WS-DISPLAY-NUMERIC-UNSIGNED-T.    
                   15  WS-DISPLAY-NUMERIC-UNSIGNED  PIC 9(05).
               10  WS-DISPLAY-NUMERIC-FORMATTED-T.
                   15  WS-DISPLAY-NUMERIC-FORMATTED PIC -ZZ,ZZ9.99.
               10  WS-DISPLAY-CURRENCY-VALUE-TEXT.
                   15  WS-DISPLAY-CURRENCY-VALUE    PIC -$$,$$9.99.
      *         10  WS-EXTERNAL-FLOATING-POINT-T.  
      *             15  WS-EXTERNAL-FLOATING-POINT   PIC -9V(9)E-99.  
       01  WS-GROUP-ITEM.
           05  WS-ALPHA-FIELD-1       PIC X(05).
           05  WS-PACKED-FIELD-2      PIC S9(05) COMP-3.
           05  WS-BOOLEAN-FIELD-3     PIC X.
               88  IT-IS-NOT-SO       VALUE SPACES.
               88  IT-IS-SO           VALUE 'T'.
           05  WS-TABLE-SIZE          PIC S9(3) COMP-3.    
           05  WS-TABLE-4             VALUE 'ABCD'.
               10  WS-TABLE-ENTRY OCCURS 1 TO 4 
                                      DEPENDING ON WS-TABLE-SIZE
                                      PIC X.    
       01  WS-HEX2TEXT-CONVERSION.
           05  WS-ORIGINAL-LENGTH     PIC S9(09) COMP.
           05  WS-ORIGINAL-VALUE      PIC X(120).  
           05  WS-RESULT              PIC X(240).          
    
       PROCEDURE DIVISION.
           DISPLAY SPACE 
           DISPLAY 'Results of MOVE statements'
           DISPLAY 'Text values shown in hexadecimal will be in '
           DISPLAY '  ASCII when the sample program is run on an '
           DISPLAY '  ASCII-based system, and in EBCDIC when run '
           DISPLAY '  on an EBCDIC-based system.'

      * Example 1: Alphanumeric MOVE 
           MOVE 'Repent, Harlequin!' 
                TO WS-ORIGINAL-VALUE
           MOVE  18 TO WS-ORIGINAL-LENGTH 
           DISPLAY SPACE 
           DISPLAY 'Example 1' 
           DISPLAY 'Result of MOVE ''Repent, Harlequin!'' '
                'to item defined as PIC X(...)'
           DISPLAY 'Text value: ' 
                '"' WS-ORIGINAL-VALUE(1:WS-ORIGINAL-LENGTH) '"'       

      * Example 2: 32-bit binary value - normal MOVE 
           MOVE 375502 TO WS-BINARY-ITEM-4
           MOVE WS-BINARY-ITEM-4-AS-TEXT TO WS-ORIGINAL-VALUE
           MOVE LENGTH OF WS-BINARY-ITEM-4 TO WS-ORIGINAL-LENGTH
           CALL 'HEX2TEXT' USING WS-HEX2TEXT-CONVERSION
           DISPLAY SPACE 
           DISPLAY 'Example 2' 
           DISPLAY 'Result of MOVE 375502 to item defined as '
                '"PIC S9(09) COMP"'
           DISPLAY 'Hex value: '
               WS-RESULT(1:WS-ORIGINAL-LENGTH * 2)        

      * Example 3: 64-bit binary value - normal MOVE 
           MOVE -281064762375502 TO WS-BINARY-ITEM-8
           MOVE WS-BINARY-ITEM-8-AS-TEXT TO WS-ORIGINAL-VALUE
           MOVE LENGTH OF WS-BINARY-ITEM-8 TO WS-ORIGINAL-LENGTH
           CALL 'HEX2TEXT' USING WS-HEX2TEXT-CONVERSION
           DISPLAY SPACE 
           DISPLAY 'Example 3' 
           DISPLAY 'Result of MOVE -281064762375502 to item defined as '
                '"PIC S9(16) COMP"'
           DISPLAY 'Hex value: '
               WS-RESULT(1:WS-ORIGINAL-LENGTH * 2)        

      * Example 4: 32-bit binary value - overwrite with spaces 
           MOVE SPACES TO WS-BINARY-ITEM-4-AS-TEXT
           MOVE WS-BINARY-ITEM-4-AS-TEXT TO WS-ORIGINAL-VALUE
           MOVE LENGTH OF WS-BINARY-ITEM-4 TO WS-ORIGINAL-LENGTH
           CALL 'HEX2TEXT' USING WS-HEX2TEXT-CONVERSION
           DISPLAY SPACE 
           DISPLAY 'Example 4' 
           DISPLAY 'Result of MOVE SPACES that overwrites an item '
                'defined as "PIC S9(09) COMP"'
           DISPLAY 'Hex value: '
               WS-RESULT(1:WS-ORIGINAL-LENGTH * 2)        

      * Example 5: Single-precision floating-point value 
           MOVE 06.23E-24 TO WS-SINGLE-PRECISION
           MOVE WS-SINGLE-PRECISION-AS-TEXT
                TO WS-ORIGINAL-VALUE 
           MOVE LENGTH OF WS-SINGLE-PRECISION 
                TO WS-ORIGINAL-LENGTH
           CALL 'HEX2TEXT' USING WS-HEX2TEXT-CONVERSION 
           DISPLAY SPACE 
           DISPLAY 'Example 5'
           DISPLAY 'Result of MOVE numeric value to COMP-1 item'
           DISPLAY 'Hex value: '
                WS-RESULT(1:WS-ORIGINAL-LENGTH * 2)        

      * Example 6: Double-precision floating-point value 
           MOVE 3246.16E-32 TO WS-DOUBLE-PRECISION
           MOVE WS-DOUBLE-PRECISION-AS-TEXT
                TO WS-ORIGINAL-VALUE 
           MOVE LENGTH OF WS-DOUBLE-PRECISION 
                TO WS-ORIGINAL-LENGTH
           CALL 'HEX2TEXT' USING WS-HEX2TEXT-CONVERSION 
           DISPLAY SPACE 
           DISPLAY 'Example 6'
           DISPLAY 'Result of MOVE numeric value to COMP-2 item'
           DISPLAY 'Hex value: '
                WS-RESULT(1:WS-ORIGINAL-LENGTH * 2)        

      * Example 7: Packed Decimal value - normal MOVE 
           MOVE -256.095 TO WS-PACKED-DECIMAL-ITEM.
           MOVE WS-PACKED-DECIMAL-ITEM-AS-TEXT 
                TO WS-ORIGINAL-VALUE 
           MOVE LENGTH OF WS-PACKED-DECIMAL-ITEM
                TO WS-ORIGINAL-LENGTH
           CALL 'HEX2TEXT' USING WS-HEX2TEXT-CONVERSION
           DISPLAY SPACE 
           DISPLAY 'Example 7'
           DISPLAY 'Result of MOVE -256.095 '
                   'to item defined as "PIC S9(04)V9(03) COMP-3"'
           DISPLAY 'Hex value: ' 
                WS-RESULT(1:WS-ORIGINAL-LENGTH * 2)           

      * Example 8: Packed Decimal value - overwrite value with spaces 
           MOVE SPACES TO WS-PACKED-DECIMAL-ITEM-AS-TEXT.
           MOVE WS-PACKED-DECIMAL-ITEM-AS-TEXT 
                TO WS-ORIGINAL-VALUE 
           MOVE LENGTH OF WS-PACKED-DECIMAL-ITEM
                TO WS-ORIGINAL-LENGTH
           CALL 'HEX2TEXT' USING WS-HEX2TEXT-CONVERSION
           DISPLAY SPACE 
           DISPLAY 'Example 8'
           DISPLAY 'Result of MOVE SPACES that overwrites an item '
                   'defined as "PIC S9(04)V9(03) COMP-3"'
           DISPLAY 'Hex value: ' 
                WS-RESULT(1:WS-ORIGINAL-LENGTH * 2)    

      * Example 9: Display Numeric Signed 
           MOVE -4832.61 TO WS-DISPLAY-NUMERIC-SIGNED 
           DISPLAY SPACE 
           DISPLAY 'Example 9'
           DISPLAY 'Result of MOVE-4832.61 to item defined as '
                   '"PIC S9(05)V9(02)" (with implicit USAGE DISPLAY)'
           DISPLAY 'Result: ' 
                WS-DISPLAY-NUMERIC-SIGNED    

      * Example 10: Display Numeric with formatting
           MOVE -4832.61 TO WS-DISPLAY-NUMERIC-FORMATTED 
           DISPLAY SPACE 
           DISPLAY 'Example 10'
           DISPLAY 'Result of MOVE -4832.61 to item defined as '
                   '"PIC -ZZ,ZZ9.99" (with implicit USAGE DISPLAY)'
           DISPLAY 'Result: ' 
                WS-DISPLAY-NUMERIC-FORMATTED    

      * Example 11: Display Numeric with formatting for currency
           MOVE -4832.61 TO WS-DISPLAY-CURRENCY-VALUE  
           DISPLAY SPACE 
           DISPLAY 'Example 11'
           DISPLAY 'Result of MOVE -4832.61 to item defined as '
                   '"PIC -$$,$$9.99" (with implicit USAGE DISPLAY)'
           DISPLAY 'Result: ' 
                WS-DISPLAY-CURRENCY-VALUE   

      * Example 12: Display floating point value with formatting
      *     MOVE 06.23E-24 TO WS-EXTERNAL-FLOATING-POINT  
      *     DISPLAY SPACE 
      *     DISPLAY 'Example 11'
      *     DISPLAY 'Result of MOVE 06.23E-24 to item defined as '
      *             '"PIC -9V(9)E-99" (with implicit USAGE DISPLAY)'
      *     DISPLAY 'Result: ' 
      *          WS-EXTERNAL-FLOATING-POINT   

      * Example 13: Using INITIALIZE to initialize a group item 
           INITIALIZE WS-GROUP-ITEM
               REPLACING ALPHANUMERIC DATA BY SPACES
                         NUMERIC DATA BY ZEROES 
           MOVE WS-GROUP-ITEM TO WS-ORIGINAL-VALUE 
           MOVE LENGTH OF WS-GROUP-ITEM TO WS-ORIGINAL-LENGTH
           CALL 'HEX2TEXT' USING WS-HEX2TEXT-CONVERSION
           DISPLAY SPACE
           DISPLAY 'Example 13'
           DISPLAY 'WS-GROUP-ITEM after INITIALIZE statement'
           DISPLAY WS-RESULT(1:WS-ORIGINAL-LENGTH * 2)              

      * Example 14: Using MOVE SPACES to initialize a group item 
           MOVE SPACES TO WS-GROUP-ITEM
           MOVE WS-GROUP-ITEM TO WS-ORIGINAL-VALUE 
           MOVE LENGTH OF WS-GROUP-ITEM TO WS-ORIGINAL-LENGTH
           CALL 'HEX2TEXT' USING WS-HEX2TEXT-CONVERSION
           DISPLAY SPACE
           DISPLAY 'Example 14'
           DISPLAY 'WS-GROUP-ITEM after MOVE SPACES statement'
           DISPLAY WS-RESULT(1:WS-ORIGINAL-LENGTH * 2)              



           GOBACK
           .