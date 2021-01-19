      *****************************************************************
      * Program name:    REFORMER                            
      * Original author: Dave Nicolette            
      *
      * Demonstrates:
      *
      * How to manipulate data items using INSPECT REPLACING, UNSTRING,
      * and reference modification.
      *
      * This program uses various Cobol features to reformat the data
      * from an "input record" originating with an external business
      * entity into "our" company's internal record format.
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  REFORMER.
       DATA DIVISION. 
       WORKING-STORAGE SECTION.
       01  FILLER. 
      * Record received from external business entity. 
           05  INPUT-RECORD.
               10  IN-PRODUCT-CODE           PIC X(04).
               10  FILLER                    PIC X(04).
               10  IN-PRODUCT-DESC           PIC X(60).
               10  FILLER                    PIC X(02).
               10  IN-INVOICE-NO             PIC X(08).
               10  IN-QUANTITY               PIC 9(04). 
               10  IN-UNIT-PRICE             PIC S9(03)V99.
               10  FILLER                    PIC X(02).
      *        Date is in MM/DD/YY format         
               10  IN-INVOICE-DATE           PIC X(08).
      *        Taxable = 'Y', Non-taxable = space     
               10  IN-TAXABLE                PIC X.

      * Our company's record format.          
           05  OUTPUT-RECORD.
               10  OUT-SKU                    PIC X(10).
               10  FILLER                     PIC X.
                   88  TAXABLE-ITEM           VALUE 'T', FALSE 'N'.
               10  OUT-ITEM-DESC              PIC X(30).
               10  OUT-QUANTITY               PIC S9(5) COMP-3.
               10  OUT-UNIT-PRICE             PIC S9(7)V99 COMP-3.
               10  OUT-INVOICE-NO             PIC X(16).
               10  OUT-INV-DATE-YYYY-MM-DD    PIC X(08).

           05  WS-WORK-AREAS.
               10  WS-SLASH                   PIC X VALUE "/".
               10  WS-DATE-WORK-AREA. 
                   15  WS-DATE-FULL-YEAR.
                       20  WS-DATE-CENTURY    PIC XX. 
                       20  WS-DATE-YEAR       PIC XX. 
                   15  WS-DATE-MONTH          PIC XX.
                   15  WS-DATE-DAY            PIC XX.           
           05 WS-CURRENT-DATE-DATA.   
               10  WS-CURRENT-DATE.
                   15  WS-CURRENT-FULL-YEAR.
                       20  WS-CURRENT-CENTURY  PIC X(02).
                       20  FILLER              PIC X(02).
                   15  WS-CURRENT-MONTH        PIC 9(02).
                   15  WS-CURRENT-DAY          PIC 9(02).
               10  WS-CURRENT-TIME.
                   15  WS-CURRENT-HOURS        PIC 9(02).
                   15  WS-CURRENT-MINUTE       PIC 9(02).
                   15  WS-CURRENT-SECOND       PIC 9(02).
                   15  WS-CURRENT-MILLISECONDS PIC 9(02).

           05  WS-SKU-LOOKUP-DATA. 
               10  FILLER PIC X(6) VALUE 'ABTC45'.
               10  FILLER PIC X(6) VALUE 'GTHH05'.
               10  FILLER PIC X(6) VALUE 'KRNB13'.
               10  FILLER PIC X(6) VALUE 'PKCC19'.
               10  FILLER PIC X(6) VALUE 'ZWYT54'.
           05  WS-SKU-LOOKUP-TABLE REDEFINES WS-SKU-LOOKUP-DATA.
               10  WS-SKU-LOOKUP-ENTRY 
                       OCCURS 5 TIMES 
      *                ASCENDING THEIR-PRODUCT-CODE-PREFIX
                       INDEXED BY SKU-INDEX.
                   15  THEIR-PRODUCT-CODE-PREFIX PIC XX. 
                   15  OUR-SKU-GROUP-CODE        PIC X(04).  
           05  WS-DEFAULT-SKU-PREFIX             PIC X(04) VALUE 'XX00'.
           05  WS-SKU-PREFIX                     PIC X(04).    

       01  WS-HEX2TEXT-CONVERSION.
           05  WS-ORIGINAL-LENGTH     PIC S9(09) COMP.
           05  WS-ORIGINAL-VALUE      PIC X(120).  
           05  WS-RESULT              PIC X(240).    

       01  HEX-OUTPUT-RECORD.
           05  HEX-OFFSET                   PIC S9(3) COMP-3.
           05  HEX-TARGET                   PIC S9(3) COMP-3.
           05  HEX-OUTPUT-RECORD-HIGH-ORDER PIC X(73).          
           05  HEX-OUTPUT-RECORD-LOW-ORDER  PIC X(73).          

       PROCEDURE DIVISION.

      * Input record we might receive from the external entity

           MOVE 'PK29'           TO IN-PRODUCT-CODE 
           MOVE 'Pastel 29'      TO IN-PRODUCT-DESC 
           MOVE 'I00956A5'       TO IN-INVOICE-NO 
           MOVE 3                TO IN-QUANTITY 
           MOVE 5.49             TO IN-UNIT-PRICE 
           MOVE '10/15/22'       TO IN-INVOICE-DATE 
           MOVE 'Y'              TO IN-TAXABLE 

      * Reformat the date value            

           UNSTRING IN-INVOICE-DATE 
               DELIMITED BY WS-SLASH 
               INTO 
                   WS-DATE-MONTH 
                   WS-DATE-DAY 
                   WS-DATE-YEAR 
           END-UNSTRING  

           MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DATE-DATA
           MOVE WS-CURRENT-CENTURY TO WS-DATE-CENTURY
           MOVE WS-DATE-WORK-AREA TO OUT-INV-DATE-YYYY-MM-DD

           DISPLAY SPACE 
           DISPLAY 'Using CURRENT-DATE function call, MOVE statement:'
           DISPLAY 'IN-INVOICE-DATE <' IN-INVOICE-DATE '>'
               ' converted to '
               'OUT-INV-DATE-YYYY-MM-DD <' 
               OUT-INV-DATE-YYYY-MM-DD  '>'        

      * Lookup the SKU prefix for our system 

           SEARCH WS-SKU-LOOKUP-ENTRY 
               AT END  
                   MOVE WS-DEFAULT-SKU-PREFIX TO WS-SKU-PREFIX 
               WHEN  
                   THEIR-PRODUCT-CODE-PREFIX (SKU-INDEX) 
                       IS EQUAL TO IN-PRODUCT-CODE(1:2) 
                           MOVE OUR-SKU-GROUP-CODE (SKU-INDEX) 
                               TO WS-SKU-PREFIX 
           END-SEARCH 

           MOVE SPACES TO OUT-SKU
           
           STRING 
                   WS-SKU-PREFIX DELIMITED BY SIZE 
                   IN-PRODUCT-CODE(3:2) DELIMITED BY SIZE 
               INTO 
                   OUT-SKU
           END-STRING 

           DISPLAY SPACE 
           DISPLAY 'Using Table search, STRING statement:'
           DISPLAY 'IN-PRODUCT-CODE <' IN-PRODUCT-CODE 
               '> converted to OUT-SKU <' OUT-SKU '>'                   

      * Convert the 'taxable item' indicator to our format 

           IF IN-TAXABLE IS EQUAL TO 'Y' 
               SET TAXABLE-ITEM TO TRUE 
           ELSE  
               SET TAXABLE-ITEM TO FALSE 
           END-IF 

           DISPLAY SPACE  
           DISPLAY 'Using IF/ELSE, SET statement:'
           DISPLAY 'IN-TAXABLE <' IN-TAXABLE '> converted to ' 
           IF TAXABLE-ITEM 
               DISPLAY 'TAXABLE-ITEM condition name TRUE' 
           ELSE     
               DISPLAY 'TAXABLE-ITEM condition name FALSE'    
           END-IF             

      * Move quantity and unit price and convert to packed decimal 

           MOVE IN-QUANTITY TO OUT-QUANTITY 
           MOVE IN-UNIT-PRICE TO OUT-UNIT-PRICE 

           DISPLAY SPACE 
           DISPLAY 'Using MOVE statements:' 
           DISPLAY 'IN-QUANTITY <' IN-QUANTITY '> converted to packed '
               'OUT-QUANTITY <' OUT-QUANTITY '>'
           DISPLAY 'IN-UNIT-PRICE <' IN-UNIT-PRICE '> converted to '
               'packed OUT-UNIT-PRICE <' OUT-UNIT-PRICE '>'    

      * Move invoice number - no conversion necessary 

           MOVE IN-INVOICE-NO TO OUT-INVOICE-NO

           DISPLAY SPACE 
           DISPLAY 'Converted record: ' 
           DISPLAY '<' OUTPUT-RECORD(1:41) '........' 
               OUTPUT-RECORD(50:24) '>'

           MOVE OUTPUT-RECORD TO WS-ORIGINAL-VALUE 
           MOVE LENGTH OF OUTPUT-RECORD TO WS-ORIGINAL-LENGTH
           CALL 'HEX2TEXT' USING WS-HEX2TEXT-CONVERSION

           MOVE ZERO TO HEX-TARGET
           PERFORM 
                   WITH TEST BEFORE 
                   VARYING HEX-OFFSET FROM 1 BY 2 
                   UNTIL HEX-OFFSET IS GREATER THAN 
                       LENGTH OF OUTPUT-RECORD * 2    
                ADD 1 TO HEX-TARGET       
                MOVE WS-RESULT(HEX-OFFSET:1) 
                    TO HEX-OUTPUT-RECORD-HIGH-ORDER(HEX-TARGET:1) 
                MOVE WS-RESULT(HEX-OFFSET + 1:1) 
                    TO HEX-OUTPUT-RECORD-LOW-ORDER(HEX-TARGET:1)           
           END-PERFORM

           DISPLAY '<' HEX-OUTPUT-RECORD-HIGH-ORDER '>'
           DISPLAY '<' HEX-OUTPUT-RECORD-LOW-ORDER '>'

           GOBACK
           .