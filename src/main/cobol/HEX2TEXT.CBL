      ****************************************************************
      * Convert any value into displayable hexadecimal characters.
      *
      * This is a generalized version of the sample code found here:
      * https://www.ibm.com/support/pages/
      *   how-display-hexadecimal-using-cobol
      ****************************************************************
       IDENTIFICATION DIVISION.                      
       PROGRAM-ID. HEX2TEXT.
       ENVIRONMENT DIVISION.                          
       DATA DIVISION.                                
       WORKING-STORAGE SECTION.
       01  HEXVAL   PIC X(8).                          
       01  HEXSTR   PIC X(16) VALUE "0123456789ABCDEF".
       01  DEC      PIC S9(4) COMP.
       01  FILLER   REDEFINES DEC.                    
           02  FILLER PIC X.                          
           02  DECBYTE PIC X.                          
       01  I   PIC S9(8) COMP.                        
       01  J   PIC S9(8) COMP.                        
       01  Q   PIC S9(8) COMP.                        
       01  R   PIC S9(8) COMP.                        
       01  J1  PIC S9(8) COMP.                        
       01  Q1  PIC S9(8) COMP.                        
       01  R1  PIC S9(8) COMP.       

       LINKAGE SECTION.
       01  LS-HEX2TEXT-CONVERSION.
           05  LS-ORIGINAL-LENGTH     PIC S9(09) COMP.
           05  LS-ORIGINAL-VALUE      PIC X(120).  
           05  LS-RESULT              PIC X(240).          
       PROCEDURE DIVISION USING LS-HEX2TEXT-CONVERSION.                             
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > LS-ORIGINAL-LENGTH
               COMPUTE J = 2 * I - 1    
               MOVE LS-ORIGINAL-VALUE(I:1) TO DECBYTE              
               DIVIDE DEC BY 16 GIVING Q REMAINDER R  
               COMPUTE J1 = J + 1                      
               COMPUTE Q1 = Q + 1                      
               COMPUTE R1 = R + 1                      
               MOVE HEXSTR(Q1:1) TO LS-RESULT(J:1)        
               MOVE HEXSTR(R1:1) TO LS-RESULT(J1:1)      
           END-PERFORM.
           GOBACK.