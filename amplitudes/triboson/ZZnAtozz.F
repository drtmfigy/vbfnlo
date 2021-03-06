      SUBROUTINE ZZnA_ATOZZ(v,N,myazz,NW)
C  
C Generated by MadGraph II Version 3.0. Updated 02/19/04                
C RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C FOR THE POINT WITH EXTERNAL LINES W(0:6,NEXTERNAL)
C  
C FOR PROCESS : a -> e- e+ v- v+  
C  
      IMPLICIT NONE
C  
C CONSTANTS
C  
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=   8)
      INTEGER    NWAVEFUNCS
      PARAMETER (NWAVEFUNCS=  16)
      DOUBLE PRECISION     ZERO
      PARAMETER (ZERO=0D0)
C  
C ARGUMENTS 
C  
      DOUBLE PRECISION P(0:3,2:5), Q(0:3), v(0:3,6)
      double complex myazz(0:5)
      integer NW ! = 0: all diagrams, = 1: no non resonant diagrams
C  
C LOCAL VARIABLES 
C  
      INTEGER I, mu, N
      DOUBLE COMPLEX AMP(NGRAPHS)
      DOUBLE COMPLEX W(6,NWAVEFUNCS)

c  lepton spinors and W+- polarization vectors

#include "tensor.inc"

      logical lswitch
      parameter (lswitch=.true.)

C  
C GLOBAL VARIABLES
C  
#include "VBFNLO/utilities/coupl.inc"          
C                                                                          
C ----------
C BEGIN CODE
C ----------

      do mu = 0,3
         P(mu,2) = v(mu,1)
         P(mu,3) = v(mu,2)
         P(mu,4) = v(mu,3)
         P(mu,5) = v(mu,4)
      enddo

      if (lswitch) then      ! read in lepton an W states from common block
         do i =1,6
            w(i,2) = zem(i,N)
            w(i,3) = zep(i,N)
            w(i,4) = zmm(i,N)
            w(i,5) = zmp(i,N)
         enddo
      endif

      do mu = 0,3
         q(mu) = p(mu,2)+p(mu,3)+p(mu,4)+p(mu,5)
      enddo
c
      do mu = 0,3
      CALL TRIBOSVCARTX(Q(0     ),ZERO ,ZERO,MU,-1,W(1,1   ))     
      CALL FVIXXX(W(1,3   ),W(1,1   ),GAL ,ZERO    ,ZERO    ,W(1,11  ))              
      CALL JIOXXX(W(1,11  ),W(1,2   ),GZL ,ZMASS   ,ZWIDTH  ,W(1,13  ))    
      CALL IOVXXX(W(1,5   ),W(1,4   ),W(1,13  ),GZN ,AMP(6   ))            
      CALL FVOXXX(W(1,2   ),W(1,1   ),GAL ,ZERO    ,ZERO    ,W(1,14  ))               
      CALL JIOXXX(W(1,3   ),W(1,14  ),GZL ,ZMASS   ,ZWIDTH  ,W(1,16  ))    
      CALL IOVXXX(W(1,5   ),W(1,4   ),W(1,16  ),GZN ,AMP(8   ))            
      myazz(   mu) = +AMP(   6)+AMP(   8)
      enddo
      myazz(4) = dcmplx(q(0),q(3))
      myazz(5) = dcmplx(q(1),q(2))
c
      return

      END


      SUBROUTINE ZZnA_ZTOZZ(v,N,myazz,NW)
C  
C Generated by MadGraph II Version 3.0. Updated 02/19/04                
C RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C FOR THE POINT WITH EXTERNAL LINES W(0:6,NEXTERNAL)
C  
C FOR PROCESS : z -> e- e+ v- v+  
C  
      IMPLICIT NONE
C  
C CONSTANTS
C  
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=   8)
      INTEGER    NWAVEFUNCS
      PARAMETER (NWAVEFUNCS=  16)
      DOUBLE PRECISION     ZERO
      PARAMETER (ZERO=0D0)
C  
C ARGUMENTS 
C  
      DOUBLE PRECISION P(0:3,2:5), Q(0:3), v(0:3,6)
      double complex myazz(0:5)
      INTEGER NW ! = 0: all diagrams, = 1: no non resonant diagrams
C  
C LOCAL VARIABLES 
C  
      INTEGER I, mu, N
      DOUBLE COMPLEX AMP(NGRAPHS)
      DOUBLE COMPLEX W(6,NWAVEFUNCS)

c  lepton spinors and W+- polarization vectors
#include "tensor.inc"

      logical lswitch
      parameter (lswitch=.true.)
C  
C GLOBAL VARIABLES
C  
#include "VBFNLO/utilities/coupl.inc"          
C                                                                          
C ----------
C BEGIN CODE
C ----------
      do mu = 0,3
         P(mu,2) = v(mu,1)
         P(mu,3) = v(mu,2)
         P(mu,4) = v(mu,3)
         P(mu,5) = v(mu,4)
      enddo

      if (lswitch) then      ! read in lepton an W states from common block
         do i=1,6
            w(i,2) = zem(i,N)
            w(i,3) = zep(i,N)
            w(i,4) = zmm(i,N)
            w(i,5) = zmp(i,N)
         enddo
      endif

      do mu = 0,3
         q(mu) = p(mu,2)+p(mu,3)+p(mu,4)+p(mu,5)
      enddo
c
      do mu = 0,3
      CALL TRIBOSVCARTX(Q(0),ZMASS ,ZWIDTH, MU,-1,W(1,1   ))          
      CALL JIOXXX(W(1,3   ),W(1,2   ),GZL ,ZMASS   ,ZWIDTH  ,W(1,8   ))    
      CALL FVOXXX(W(1,4   ),W(1,8   ),GZN ,ZERO    ,ZERO    ,W(1,9   ))    
      CALL IOVXXX(W(1,5   ),W(1,9   ),W(1,1   ),GZN ,AMP(2   ))            
      CALL FVOXXX(W(1,4   ),W(1,1   ),GZN ,ZERO    ,ZERO    ,W(1,10  ))               
      CALL IOVXXX(W(1,5   ),W(1,10  ),W(1,8   ),GZN ,AMP(4   ))            
      CALL FVIXXX(W(1,3   ),W(1,1   ),GZL ,ZERO    ,ZERO    ,W(1,11  ))              
      CALL JIOXXX(W(1,11  ),W(1,2   ),GZL ,ZMASS   ,ZWIDTH  ,W(1,13  ))    
      CALL IOVXXX(W(1,5   ),W(1,4   ),W(1,13  ),GZN ,AMP(6   ))            
      CALL FVOXXX(W(1,2   ),W(1,1   ),GZL ,ZERO    ,ZERO    ,W(1,14  ))               
      CALL JIOXXX(W(1,3   ),W(1,14  ),GZL ,ZMASS   ,ZWIDTH  ,W(1,16  ))    
      CALL IOVXXX(W(1,5   ),W(1,4   ),W(1,16  ),GZN ,AMP(8   ))            
      myazz(   mu) = +AMP(   2)+AMP(   4)+AMP(   6)+AMP(   8)
      enddo
      myazz(4) = dcmplx(q(0),q(3))
      myazz(5) = dcmplx(q(1),q(2))

      END
