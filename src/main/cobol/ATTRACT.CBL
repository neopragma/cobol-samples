      *****************************************************************
      * Program name:    ATTRACT                           
      * Original author: Dave Nicolette            
      *
      * Demonstrates:
      *
      * Illustrates the use of floating-point operations to perform
      * scientific calculations.
      *
      * Cobol is designed to support business application development,
      * but it can be used in other domains, as well. This program
      * calculates the gravitational attraction between two bodies
      * in space. You would probably not choose Cobol for work in this
      * domain. The sample is only meant for demonstration purposes.
      *****************************************************************
       Identification Division.
       Program-ID.  ATTRACT.
       Data Division. 
       Working-Storage Section. 
       01  ComputationalWorkAreas.
      * Gravitational constant G 
           05  G                  comp-2 value 6.67428e-11.
      * distance between the two bodies on x, y, and computed d 
           05  dx                 comp-2. 
           05  dy                 comp-2.
           05  d                  comp-2.     
      * force of attraction 
           05  f                  comp-2.  
      * intermediate result when calculating force direction 
           05  theta              comp-2.   
      * force along the x and y axes 
           05  fx                 comp-2. 
           05  fy                 comp-2.                                

      * Bodies 
           05  Body occurs 2 indexed by BodyIx.
      * mass in kg     
               10  mass           comp-2.
      * x and y velocities in meters per second 
               10  vx             comp-2.
               10  vy             comp-2.
      * x and y positions in meters 
               10  px             comp-2.
               10  py             comp-2.  

       01  GeneralWorkAreas.
           05  PseudoConstants. 
               10  VelocityText   pic x(08) value "velocity".
               10  PositionText   pic x(08) value "position".
           05  IdentifyTheBody. 
               10  filler         pic X(27) 
                   value "Enter attributes of body # ".
               10  BodyNumber     pic 9.    
           05  PromptForBodyMass  pic x(40) 
               value "Please enter the mass of the body in KG:".
           05  PromptForVelocityOrPosition. 
               10  filler         pic x(24)
               Value "Please enter the body's ". 
               10  VelocityOrPosition pic x(08). 
               10  filler         pic x(08) value " on the ". 
               10  PromptAxis     pic x. 
               10  filler         pic x(06) value " axis:".   

           05  BodyAttributesDisplay.
               10  filler         pic x(06) value "Body #". 
               10  BodyNumberDisplay pic 9.
               10  filler         pic x(12) value " attributes:".
           05  BodyMassDisplay. 
               10  filler         pic x(10) value "    mass: ".
           05  BodyVelocityDisplay. 
               10  filler         pic x(12) value "    vx, vy: ".
           05  BodyPositionDisplay. 
               10  filler         pic x(12) value "    px, py: ".
           05  PromptToContinue   pic x(29) 
               value "Do you want to proceed? (Y/n)".               
           05  ContinueReply      pic x.    
           05  GoodbyeDisplay     pic x(21) 
               value "Maybe next time. Bye!".
           05  DistanceDisplay    pic x(36) 
               value "The distance between the bodies is: ". 
           05  DistanceIsZeroDisplay pic x(36) 
               value "The bodies are in the same position!".    
           05  ForceDisplay       pic x(27) 
               value "The force of attaction is: ".    
           05  ForceAlongAxisDisplay.
               10  filler       pic x(20) value "The force along the ".
               10  ForceAxis    pic x. 
               10  filler       pic x(07) value " axis: ".    
                   
       Procedure Division.

           perform with test before 
                  varying BodyIx from 1 by 1 
                   until BodyIx > 2 
               perform SolicitAttributesOfBody    
           end-perform

           perform with test before 
                   varying BodyIx from 1 by 1 
                   until BodyIx > 2 
               perform VerifyAttributesOfBody    
           end-perform

           display space 
           display PromptToContinue 
           accept ContinueReply 

           if ContinueReply equal 'n' or 'N' 
               display GoodbyeDisplay 
               goback    
           end-if     

           perform ComputeAttraction 


           goback
           .

       SolicitAttributesOfBody. 
           move BodyIx to BodyNumber
           display space 
           display IdentifyTheBody 
           display PromptForBodyMass 
           accept mass(BodyIx) from CONSOLE 

           move VelocityText to VelocityOrPosition
           move "X" to PromptAxis 
           display PromptForVelocityOrPosition 
           accept vx(BodyIx) from console 

           move "Y" to PromptAxis 
           display PromptForVelocityOrPosition
           accept vy(BodyIx) from console

           move PositionText to VelocityOrPosition
           move "X" to PromptAxis 
           display PromptForVelocityOrPosition 
           accept px(BodyIx) from console 

           move "Y" to PromptAxis 
           display PromptForVelocityOrPosition
           accept py(BodyIx) from console
           . 
       
       VerifyAttributesOfBody. 
           move BodyIx to BodyNumberDisplay 
           display space 
           display BodyAttributesDisplay 
           display BodyMassDisplay mass(BodyIx) 
           display BodyVelocityDisplay vx(BodyIx) ", " vy(BodyIx) 
           display BodyPositionDisplay px(BodyIx) ", " py(BodyIx) 
           .

       ComputeAttraction. 
      * Compute the distance between the two bodies 
           compute dx = px(1) - px(2) 
           compute dy = py(1) - py(2) 
           compute d = function sqrt((dx * dx) + (dy * dy))

           if d = zero  
               display DistanceIsZeroDisplay 
               goback
           end-if
           display DistanceDisplay  d 

      * Compute the force of attraction 
           compute f = (G * mass(1) * mass(2)) / (d * d)
           display ForceDisplay f 

      * Compute the direction of force 

      *    Ah, if only...
      *    compute theta = function atan2(dy, dx)

      *    ...instead, this: wrong, but OK for this demo.
           compute theta = function atan(dx)
           compute fx = function cos(theta * f) 
           compute fy = function sin(theta * f) 

           move 'X' to ForceAxis 
           display ForceAlongAxisDisplay fx 
           move 'Y' to ForceAxis 
           display ForceAlongAxisDisplay fy 
           .    