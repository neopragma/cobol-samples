      *****************************************************************
      * Program name:    INVCALC                           
      * Original author: Dave Nicolette            
      *
      * Demonstrates:
      *
      * How to write typical business calculations in Cobol.
      *
      * This program calculates invoice totals for fake invoice data.
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  INVCALC.
       DATA DIVISION. 
       WORKING-STORAGE SECTION. 
       01  FILLER. 
           05  SALES-TAX-RATE           PIC SV9(5) COMP-3 VALUE 0.065.
           05  WORKING-INDEX            PIC S9(04) COMP.
           05  CUMULATIVE-PRICE-BEFORE-TAX PIC S9(07)V99 COMP-3.
           05  CUMULATIVE-PRICE-WITH-TAX   PIC S9(07)V99 COMP-3.
           05  CUMULATIVE-SALES-TAX     PIC S9(05)V9(03) COMP-3.
           05  LINE-WORKING-TOTAL       PIC S9(07)V99 COMP-3.
           05  LINE-WORKING-TAX         PIC S9(05)V9(03) COMP-3.

       01  INVOICE.
           05  INV-DATE                 PIC X(08). 
           05  INV-NUMBER               PIC X(08). 
           05  INV-TOTAL-AMOUNT         PIC S9(07)V99 COMP-3.
           05  INV-TOTAL-BEFORE-TAX     PIC S9(07)V99 COMP-3. 
           05  INV-TOTAL-SALES-TAX      PIC S9(05)V9(03) COMP-3.
           05  INV-RETURN               PIC X.  
               88 IS-RETURN             VALUE 'R'.
           05  INV-LINE-ITEM-COUNT      PIC S9(05) COMP-3.
           05  INV-LINE OCCURS 1 TO 100 
                        DEPENDING ON INV-LINE-ITEM-COUNT.
               10  INV-LINE-SKU         PIC X(10). 
               10  INV-LINE-UNIT-PRICE  PIC S9(05)V99 COMP-3. 
               10  INV-LINE-QUANTITY    PIC S9(05) COMP-3.
               10  INV-LINE-TAXABLE     PIC X. 
                   88  TAXABLE-ITEM     VALUE 'T'.
                   88  NONTAXABLE-ITEM  VALUE 'N'.         

       01  INVOICE-FORMATTED. 
           05  INV-DATE-FORMATTED             PIC X(10).
           05  INV-TOTAL-AMOUNT-FORMATTED     PIC $,$$$,$$9.99.
           05  INV-TOTAL-BEFORE-TAX-FORMATTED PIC $,$$$,$$9.99.
           05  INV-TOTAL-SALES-TAX-FORMATTED  PIC $$,$$9.999.
           05  INV-LINE-QUANTITY-FORMATTED    PIC Z,ZZ9. 
           05  INV-LINE-UNIT-PRICE-FORMATTED  PIC $$,$$9.99. 
           05  SALES-TAX-RATE-FORMATTED       PIC .99999.
           05  LINE-NUMBER-FORMATTED          PIC ZZ9.

       PROCEDURE DIVISION.

      *---------------------------------------------------------------
      * Example 1: Invoice total calculation 

           INITIALIZE INVOICE 
               REPLACING ALPHANUMERIC DATA BY SPACES 
                         NUMERIC DATA BY ZEROES 

           MOVE '20230914' TO INV-DATE  
           MOVE 'Sample 1' TO INV-NUMBER 
           MOVE 3 TO INV-LINE-ITEM-COUNT   
           
           MOVE 'PROD004411' TO INV-LINE-SKU(1)  
           MOVE 18.55 TO INV-LINE-UNIT-PRICE(1)
           MOVE 2 TO INV-LINE-QUANTITY(1)
           SET TAXABLE-ITEM(1) TO TRUE
           
           MOVE 'PROD004412' TO INV-LINE-SKU(2)  
           MOVE 6.32 TO INV-LINE-UNIT-PRICE(2)
           MOVE 4 TO INV-LINE-QUANTITY(2)
           SET NONTAXABLE-ITEM(2) TO TRUE
           
           MOVE 'PROD004413' TO INV-LINE-SKU(3)  
           MOVE 2.28 TO INV-LINE-UNIT-PRICE(3)
           MOVE 8 TO INV-LINE-QUANTITY(3)
           SET TAXABLE-ITEM(1) TO TRUE

           MOVE ZERO TO CUMULATIVE-PRICE-BEFORE-TAX 
                        CUMULATIVE-PRICE-WITH-TAX 
                        CUMULATIVE-SALES-TAX 
                        WORKING-INDEX
                    
           PERFORM WITH TEST BEFORE 
                   VARYING WORKING-INDEX 
                   FROM 1 BY 1 
                   UNTIL WORKING-INDEX > INV-LINE-ITEM-COUNT 
               IF INV-LINE-QUANTITY(WORKING-INDEX) IS NUMERIC 
               AND INV-LINE-UNIT-PRICE(WORKING-INDEX) IS NUMERIC 
                   MOVE ZERO 
                       TO LINE-WORKING-TOTAL 
                          LINE-WORKING-TAX
                   MULTIPLY 
                       INV-LINE-QUANTITY(WORKING-INDEX) 
                       BY INV-LINE-UNIT-PRICE(WORKING-INDEX) 
                       GIVING LINE-WORKING-TOTAL 
                   END-MULTIPLY 
                   ADD LINE-WORKING-TOTAL 
                       TO CUMULATIVE-PRICE-BEFORE-TAX
                   END-ADD    
                   IF TAXABLE-ITEM(WORKING-INDEX) 
                       MULTIPLY LINE-WORKING-TOTAL
                           BY SALES-TAX-RATE 
                           GIVING LINE-WORKING-TAX
                       END-MULTIPLY 
                       ADD LINE-WORKING-TAX 
                           TO LINE-WORKING-TOTAL    
                   END-IF  
                   ADD LINE-WORKING-TOTAL 
                       TO CUMULATIVE-PRICE-WITH-TAX
                   END-ADD     
                   ADD LINE-WORKING-TAX 
                       TO CUMULATIVE-SALES-TAX    
                   END-ADD            
               ELSE 
                   PERFORM INVALID-INVOICE-DATA 
               END-IF 
           END-PERFORM                     

           MOVE CUMULATIVE-SALES-TAX TO INV-TOTAL-SALES-TAX 
           MOVE CUMULATIVE-PRICE-BEFORE-TAX  TO INV-TOTAL-BEFORE-TAX 
           MOVE CUMULATIVE-PRICE-WITH-TAX TO INV-TOTAL-AMOUNT 

           PERFORM PRINT-INVOICE-DETAILS

           GOBACK
           .
       INVALID-INVOICE-DATA. 
           DISPLAY 'Invalid invoice data'  
           . 
       PRINT-INVOICE-DETAILS. 
           DISPLAY SPACE 
           DISPLAY '----------------------------------------'
           DISPLAY 'Invoice Number:   ' INV-NUMBER
           MOVE INV-DATE(1:4) TO INV-DATE-FORMATTED(1:4) 
           MOVE '/' TO INV-DATE-FORMATTED(5:1) 
           MOVE INV-DATE(5:2) TO INV-DATE-FORMATTED(6:2) 
           MOVE '/' TO INV-DATE-FORMATTED(8:1) 
           MOVE INV-DATE(7:2) TO INV-DATE-FORMATTED(9:2)
           DISPLAY 'Invoice Date:     ' INV-DATE-FORMATTED     
           MOVE INV-TOTAL-AMOUNT TO INV-TOTAL-AMOUNT-FORMATTED
           DISPLAY 'Total Amount:     ' INV-TOTAL-AMOUNT-FORMATTED  
           MOVE INV-TOTAL-BEFORE-TAX TO INV-TOTAL-BEFORE-TAX-FORMATTED 
           DISPLAY 'Total Before Tax: ' INV-TOTAL-BEFORE-TAX-FORMATTED 
           MOVE INV-TOTAL-SALES-TAX TO INV-TOTAL-SALES-TAX-FORMATTED
           DISPLAY 'Total Sales Tax:    ' INV-TOTAL-SALES-TAX-FORMATTED
           MOVE SALES-TAX-RATE TO SALES-TAX-RATE-FORMATTED
           DISPLAY 'Sales Tax Rate:     ' SALES-TAX-RATE-FORMATTED
           IF IS-RETURN 
               DISPLAY 'This is a return' 
           END-IF    

           PERFORM 
                   WITH TEST BEFORE 
                   VARYING WORKING-INDEX FROM 1 BY 1 
                   UNTIL WORKING-INDEX > INV-LINE-ITEM-COUNT 
               DISPLAY SPACE 
               MOVE WORKING-INDEX TO LINE-NUMBER-FORMATTED
               DISPLAY 'Line ' LINE-NUMBER-FORMATTED
               DISPLAY 'SKU  ' INV-LINE-SKU(WORKING-INDEX)
               MOVE INV-LINE-QUANTITY(WORKING-INDEX) 
                   TO INV-LINE-QUANTITY-FORMATTED 
               DISPLAY 'Quantity ' INV-LINE-QUANTITY-FORMATTED   
               MOVE INV-LINE-UNIT-PRICE(WORKING-INDEX) 
                   TO INV-LINE-UNIT-PRICE-FORMATTED 
               DISPLAY 'Unit Price:  ' INV-LINE-UNIT-PRICE-FORMATTED   
               IF TAXABLE-ITEM(WORKING-INDEX) 
                   DISPLAY 'Taxable Item'  
               ELSE       
                   DISPLAY 'Nontaxable Item' 
               END-IF     
           END-PERFORM      

           .