      subroutine ATOWWA_mg2_had(P,N,h,wwa,NW)

      IMPLICIT NONE

      DOUBLE PRECISION P(0:3,2:7)
      COMPLEX*16 wwa(0:5)
      INTEGER lsign(2:7,2),ll,mu,nu,h,N
      INTEGER NW ! = 0: all diagrams, = 1: no non resonant diagrams

      ! possible lepton helicities:
      DATA (lsign(ll,1),ll=2,7) / -1, -1, -1, -1, -1, -1/  !h=1
      DATA (lsign(ll,2),ll=2,7) / -1, -1, -1, -1, +1, +1/  !h=2

      call ATOWWA1_mg2_had(P,N,lsign(2,h),wwa(0),NW)

      ! helicity combi nr.h is selected

      end

c ------------------------------------------------------------

      SUBROUTINE ATOWWA1_mg2_had(P,N,lsign,wwatens,NW)
C  
C Generated by MadGraph II Version 3.0. Updated 02/19/04                
C RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C FOR THE POINT WITH EXTERNAL LINES W(0:6,NEXTERNAL)
C  
C FOR PROCESS : a -> ve e+ vm~ mu- a  
C  
      IMPLICIT NONE
C  
C CONSTANTS
C  
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=  21)
      INTEGER    NWAVEFUNCS
      PARAMETER (NWAVEFUNCS=  31)
      DOUBLE PRECISION     ZERO
      PARAMETER (ZERO=0D0)
C  
C ARGUMENTS 
C  
      DOUBLE PRECISION P(0:3,2:7), Q(0:3)
      INTEGER N
      COMPLEX*16 wwatens(0:5)
      INTEGER lsign(2:7)
      INTEGER NW ! = 0: all diagrams, = 1: no non resonant diagrams
C  
C LOCAL VARIABLES 
C  
      INTEGER I,J, mu
      COMPLEX*16 AMP(NGRAPHS)
      COMPLEX*16 W(6,NWAVEFUNCS)
c  lepton spinors and W+-, Z/A polarization vector
#include "tensor.inc"

      logical lswitch
      parameter (lswitch=.true.)

C
C GLOBAL VARIABLES
C
#include "VBFNLO/utilities/coupl.inc"      
#include "VBFNLO/utilities/process.inc"
#include "VBFNLO/utilities/global.inc"
C                                                                          
C ----------
C BEGIN CODE
C ----------
      if (lswitch) then      ! read in lepton an W states from common block
         do i=1,6
            w(i,2)  = wve(i,N)
            w(i,3)  = wep(i,N)
            w(i,4)  = wvm(i,N)
            w(i,5)  = wmu(i,N)
            w(i,6)  = atau(i,N)
            w(i,10) = wp(i,N)
            w(i,14) = wm(i,N)
         enddo
      endif

      do mu = 0,3
         q(mu) = p(mu,2)+p(mu,3)+p(mu,4)+p(mu,5)+p(mu,6)+p(mu,7)
      enddo
c
      do mu = 0,3
      CALL TRIBOSVCARTX(Q(0),ZERO ,ZERO, MU,-1,W(1,1   )) 

      if (procid .eq. WPhadWMA) then

      CALL FVOXXX(W(1,5   ),W(1,1   ),GAL ,ZERO    ,ZERO    ,W(1,7   ))    
      CALL JIOXXX(W(1,4   ),W(1,7   ),GWF ,WMASS   ,WWIDTH  ,W(1,8   ))    
      CALL FVIXXX(W(1,3   ),W(1,8   ),GWF ,ZERO    ,ZERO    ,W(1,9   ))    
      CALL IOVXXX(W(1,9   ),W(1,2   ),W(1,6   ),GAU ,AMP(1   ))            
      CALL FVOXXX(W(1,2   ),W(1,8   ),GWF ,ZERO    ,ZERO    ,W(1,10  ))    
      CALL IOVXXX(W(1,3   ),W(1,10  ),W(1,6   ),GAD ,AMP(2   ))            
      CALL JIOXXX(W(1,3   ),W(1,2   ),GWF ,WMASS   ,WWIDTH  ,W(1,11  ))    
      CALL FVIXXX(W(1,4   ),W(1,11  ),GWF ,ZERO    ,ZERO    ,W(1,12  ))    
      CALL FVIXXX(W(1,12  ),W(1,1   ),GAL ,ZERO    ,ZERO    ,W(1,13  ))    
      CALL IOVXXX(W(1,13  ),W(1,5   ),W(1,6   ),GAL ,AMP(3   ))            
      CALL VVVXXX(W(1,8   ),W(1,11  ),W(1,6   ),GWWA ,AMP(4   ))           
      CALL IOVXXX(W(1,12  ),W(1,7   ),W(1,6   ),GAL ,AMP(5   ))            
      CALL JIOXXX(W(1,4   ),W(1,5   ),GWF ,WMASS   ,WWIDTH  ,W(1,14  ))    
      CALL JVVXXX(W(1,1   ),W(1,14  ),GWWA ,WMASS   ,WWIDTH  ,W(1,         
     &     15  ))                                                          
      CALL FVIXXX(W(1,3   ),W(1,15  ),GWF ,ZERO    ,ZERO    ,W(1,16  ))    
      CALL IOVXXX(W(1,16  ),W(1,2   ),W(1,6   ),GAU ,AMP(6   ))            
      CALL FVOXXX(W(1,2   ),W(1,15  ),GWF ,ZERO    ,ZERO    ,W(1,17  ))    
      CALL IOVXXX(W(1,3   ),W(1,17  ),W(1,6   ),GAD ,AMP(7   ))            
      CALL JVVXXX(W(1,11  ),W(1,1   ),GWWA ,WMASS   ,WWIDTH  ,W(1,         
     &     18  ))                                                          
      CALL FVIXXX(W(1,4   ),W(1,18  ),GWF ,ZERO    ,ZERO    ,W(1,19  ))    
      CALL IOVXXX(W(1,19  ),W(1,5   ),W(1,6   ),GAL ,AMP(8   ))            
      CALL VVVXXX(W(1,15  ),W(1,11  ),W(1,6   ),GWWA ,AMP(9   ))           
      CALL VVVXXX(W(1,14  ),W(1,18  ),W(1,6   ),GWWA ,AMP(10  ))           
      CALL W3W3XX(W(1,14  ),W(1,1   ),W(1,11  ),W(1,6   ),GWWA ,GWWA ,     
     &     AMP(11  ))                                                      
      CALL FVIXXX(W(1,3   ),W(1,1   ),GAD ,ZERO    ,ZERO    ,W(1,20  ))    
      CALL FVIXXX(W(1,20  ),W(1,14  ),GWF ,ZERO    ,ZERO    ,W(1,21  ))    
      CALL IOVXXX(W(1,21  ),W(1,2   ),W(1,6   ),GAU ,AMP(12  ))            
      CALL FVOXXX(W(1,2   ),W(1,14  ),GWF ,ZERO    ,ZERO    ,W(1,22  ))    
      CALL FVOXXX(W(1,22  ),W(1,1   ),GAD ,ZERO    ,ZERO    ,W(1,23  ))    
      CALL IOVXXX(W(1,3   ),W(1,23  ),W(1,6   ),GAD ,AMP(13  ))            
      CALL JIOXXX(W(1,20  ),W(1,2   ),GWF ,WMASS   ,WWIDTH  ,W(1,24  ))    
      CALL FVIXXX(W(1,4   ),W(1,24  ),GWF ,ZERO    ,ZERO    ,W(1,25  ))    
      CALL IOVXXX(W(1,25  ),W(1,5   ),W(1,6   ),GAL ,AMP(14  ))            
      CALL IOVXXX(W(1,20  ),W(1,22  ),W(1,6   ),GAD ,AMP(15  ))            
      CALL VVVXXX(W(1,14  ),W(1,24  ),W(1,6   ),GWWA ,AMP(16  ))           
      CALL FVIXXX(W(1,3   ),W(1,14  ),GWF ,ZERO    ,ZERO    ,W(1,26  ))    
      CALL FVIXXX(W(1,26  ),W(1,1   ),GAU ,ZERO    ,ZERO    ,W(1,27  ))    
      CALL IOVXXX(W(1,27  ),W(1,2   ),W(1,6   ),GAU ,AMP(17  ))            
      CALL FVOXXX(W(1,2   ),W(1,1   ),GAU ,ZERO    ,ZERO    ,W(1,28  ))    
      CALL FVOXXX(W(1,28  ),W(1,14  ),GWF ,ZERO    ,ZERO    ,W(1,29  ))    
      CALL IOVXXX(W(1,3   ),W(1,29  ),W(1,6   ),GAD ,AMP(18  ))            
      CALL JIOXXX(W(1,3   ),W(1,28  ),GWF ,WMASS   ,WWIDTH  ,W(1,30  ))    
      CALL FVIXXX(W(1,4   ),W(1,30  ),GWF ,ZERO    ,ZERO    ,W(1,31  ))    
      CALL IOVXXX(W(1,31  ),W(1,5   ),W(1,6   ),GAL ,AMP(19  ))            
      CALL IOVXXX(W(1,26  ),W(1,28  ),W(1,6   ),GAU ,AMP(20  ))            
      CALL VVVXXX(W(1,14  ),W(1,30  ),W(1,6   ),GWWA ,AMP(21  ))           
       wwatens(mu) = -(-AMP(   1)-AMP(   2)-AMP(   3)-AMP(   4)-AMP(   5)
     &             -AMP(   6)-AMP(   7)-AMP(   8)-AMP(   9)-AMP(  10)
     &             -AMP(  11)-AMP(  12)-AMP(  13)-AMP(  14)-AMP(  15)
     &             -AMP(  16)-AMP(  17)-AMP(  18)-AMP(  19)-AMP(  20)
     &             -AMP(  21))

      elseif (procid .eq. WPWMhadA) then
      
      CALL FVOXXX(W(1,5   ),W(1,1   ),GAD ,ZERO    ,ZERO    ,W(1,7   ))    
      CALL JIOXXX(W(1,4   ),W(1,7   ),GWF ,WMASS   ,WWIDTH  ,W(1,8   ))    
      CALL FVOXXX(W(1,2   ),W(1,8   ),GWF ,ZERO    ,ZERO    ,W(1,9   ))    
      CALL IOVXXX(W(1,3   ),W(1,9   ),W(1,6   ),GAL ,AMP(1   ))            
      CALL JIOXXX(W(1,3   ),W(1,2   ),GWF ,WMASS   ,WWIDTH  ,W(1,10  ))    
      CALL FVOXXX(W(1,7   ),W(1,10  ),GWF ,ZERO    ,ZERO    ,W(1,11  ))    
      CALL IOVXXX(W(1,4   ),W(1,11  ),W(1,6   ),GAU ,AMP(2   ))            
      CALL FVIXXX(W(1,4   ),W(1,10  ),GWF ,ZERO    ,ZERO    ,W(1,12  ))    
      CALL FVIXXX(W(1,12  ),W(1,1   ),GAD ,ZERO    ,ZERO    ,W(1,13  ))    
      CALL IOVXXX(W(1,13  ),W(1,5   ),W(1,6   ),GAD ,AMP(3   ))            
      CALL VVVXXX(W(1,8   ),W(1,10  ),W(1,6   ),GWWA ,AMP(4   ))           
      CALL IOVXXX(W(1,12  ),W(1,7   ),W(1,6   ),GAD ,AMP(5   ))            
      CALL JIOXXX(W(1,4   ),W(1,5   ),GWF ,WMASS   ,WWIDTH  ,W(1,14  ))    
      CALL JVVXXX(W(1,1   ),W(1,14  ),GWWA ,WMASS   ,WWIDTH  ,W(1,         
     &     15  ))                                                          
      CALL FVOXXX(W(1,2   ),W(1,15  ),GWF ,ZERO    ,ZERO    ,W(1,16  ))    
      CALL IOVXXX(W(1,3   ),W(1,16  ),W(1,6   ),GAL ,AMP(6   ))            
      CALL JVVXXX(W(1,10  ),W(1,1   ),GWWA ,WMASS   ,WWIDTH  ,W(1,         
     &     17  ))                                                          
      CALL FVOXXX(W(1,5   ),W(1,17  ),GWF ,ZERO    ,ZERO    ,W(1,18  ))    
      CALL IOVXXX(W(1,4   ),W(1,18  ),W(1,6   ),GAU ,AMP(7   ))            
      CALL FVIXXX(W(1,4   ),W(1,17  ),GWF ,ZERO    ,ZERO    ,W(1,19  ))    
      CALL IOVXXX(W(1,19  ),W(1,5   ),W(1,6   ),GAD ,AMP(8   ))            
      CALL VVVXXX(W(1,15  ),W(1,10  ),W(1,6   ),GWWA ,AMP(9   ))           
      CALL VVVXXX(W(1,14  ),W(1,17  ),W(1,6   ),GWWA ,AMP(10  ))           
      CALL W3W3XX(W(1,14  ),W(1,1   ),W(1,10  ),W(1,6   ),GWWA ,GWWA ,     
     &     AMP(11  ))                                                      
      CALL FVIXXX(W(1,4   ),W(1,1   ),GAU ,ZERO    ,ZERO    ,W(1,20  ))    
      CALL JIOXXX(W(1,20  ),W(1,5   ),GWF ,WMASS   ,WWIDTH  ,W(1,21  ))    
      CALL FVOXXX(W(1,2   ),W(1,21  ),GWF ,ZERO    ,ZERO    ,W(1,22  ))    
      CALL IOVXXX(W(1,3   ),W(1,22  ),W(1,6   ),GAL ,AMP(12  ))            
      CALL FVOXXX(W(1,5   ),W(1,10  ),GWF ,ZERO    ,ZERO    ,W(1,23  ))    
      CALL FVOXXX(W(1,23  ),W(1,1   ),GAU ,ZERO    ,ZERO    ,W(1,24  ))    
      CALL IOVXXX(W(1,4   ),W(1,24  ),W(1,6   ),GAU ,AMP(13  ))            
      CALL FVIXXX(W(1,20  ),W(1,10  ),GWF ,ZERO    ,ZERO    ,W(1,25  ))    
      CALL IOVXXX(W(1,25  ),W(1,5   ),W(1,6   ),GAD ,AMP(14  ))            
      CALL IOVXXX(W(1,20  ),W(1,23  ),W(1,6   ),GAU ,AMP(15  ))            
      CALL VVVXXX(W(1,21  ),W(1,10  ),W(1,6   ),GWWA ,AMP(16  ))           
      CALL FVOXXX(W(1,2   ),W(1,14  ),GWF ,ZERO    ,ZERO    ,W(1,26  ))    
      CALL FVOXXX(W(1,26  ),W(1,1   ),GAL ,ZERO    ,ZERO    ,W(1,27  ))    
      CALL IOVXXX(W(1,3   ),W(1,27  ),W(1,6   ),GAL ,AMP(17  ))            
      CALL FVIXXX(W(1,3   ),W(1,1   ),GAL ,ZERO    ,ZERO    ,W(1,28  ))    
      CALL JIOXXX(W(1,28  ),W(1,2   ),GWF ,WMASS   ,WWIDTH  ,W(1,29  ))    
      CALL FVOXXX(W(1,5   ),W(1,29  ),GWF ,ZERO    ,ZERO    ,W(1,30  ))    
      CALL IOVXXX(W(1,4   ),W(1,30  ),W(1,6   ),GAU ,AMP(18  ))            
      CALL FVIXXX(W(1,4   ),W(1,29  ),GWF ,ZERO    ,ZERO    ,W(1,31  ))    
      CALL IOVXXX(W(1,31  ),W(1,5   ),W(1,6   ),GAD ,AMP(19  ))            
      CALL IOVXXX(W(1,28  ),W(1,26  ),W(1,6   ),GAL ,AMP(20  ))            
      CALL VVVXXX(W(1,14  ),W(1,29  ),W(1,6   ),GWWA ,AMP(21  ))           
      wwatens(mu) = -(-AMP(   1)-AMP(   2)-AMP(   3)-AMP(   4)-AMP(   5)
     &             -AMP(   6)-AMP(   7)-AMP(   8)-AMP(   9)-AMP(  10)
     &             -AMP(  11)-AMP(  12)-AMP(  13)-AMP(  14)-AMP(  15)
     &             -AMP(  16)-AMP(  17)-AMP(  18)-AMP(  19)-AMP(  20)
     &             -AMP(  21))

      endif

      enddo
      wwatens(4) = dcmplx(q(0),q(3))
      wwatens(5) = dcmplx(q(1),q(2))
c
      END

c ------------------------------------------------------------

      subroutine ZTOWWA_mg2_had(P,N,h,wwa,NW)

      IMPLICIT NONE

      DOUBLE PRECISION P(0:3,2:7)
      COMPLEX*16 wwa(0:5)
      INTEGER lsign(2:7,2),ll,mu,nu,h,N
      INTEGER NW ! = 0: all diagrams, = 1: no non resonant diagrams

      ! possible lepton helicities:
      DATA (lsign(ll,1),ll=2,7) / -1, -1, -1, -1, -1, -1/  !h=1
      DATA (lsign(ll,2),ll=2,7) / -1, -1, -1, -1, +1, +1/  !h=2

      call ZTOWWA1_mg2_had(P,N,lsign(2,h),wwa(0),NW)

      ! helicity combi nr.h is selected

      end

c ------------------------------------------------------------


      SUBROUTINE ZTOWWA1_mg2_had(P,N,lsign,wwatens,NW)
C  
C Generated by MadGraph II Version 3.0. Updated 02/19/04                
C RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C FOR THE POINT WITH EXTERNAL LINES W(0:6,NEXTERNAL)
C  
C FOR PROCESS : z -> ve e+ vm~ mu- a  
C  
      IMPLICIT NONE
C  
C CONSTANTS
C  
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=  25)
      INTEGER    NWAVEFUNCS
      PARAMETER (NWAVEFUNCS=  36)
      DOUBLE PRECISION     ZERO
      PARAMETER (ZERO=0D0)
C  
C ARGUMENTS 
C  
      DOUBLE PRECISION P(0:3,2:7), Q(0:3)
      INTEGER N
      COMPLEX*16 wwatens(0:5)
      INTEGER lsign(2:7)
      integer NW ! = 0: all diagrams, = 1: no non resonant diagrams
C  
C LOCAL VARIABLES 
C  
      INTEGER I,J, mu
      COMPLEX*16 AMP(NGRAPHS)
      COMPLEX*16 W(6,NWAVEFUNCS)

c  lepton spinors and W+-, Z/A polarization vectors
#include "tensor.inc"

      logical lswitch
      parameter (lswitch=.true.)

C
C GLOBAL VARIABLES
C
#include "VBFNLO/utilities/coupl.inc"      
#include "VBFNLO/utilities/process.inc"
#include "VBFNLO/utilities/global.inc"

C                                                                          
C ----------
C BEGIN CODE
C ----------
      if (lswitch) then      ! read in lepton an W states from common block
         do i=1,6
            w(i,2)  = wve(i,N)
            w(i,3)  = wep(i,N)
            w(i,4)  = wvm(i,N)
            w(i,5)  = wmu(i,N)
            w(i,6)  = atau(i,N)
            w(i,10) = wp(i,N)
            w(i,14) = wm(i,N)
         enddo
      endif

      do mu = 0,3
         q(mu) = p(mu,2)+p(mu,3)+p(mu,4)+p(mu,5)+p(mu,6)+p(mu,7)
      enddo
c
      do mu = 0,3
      CALL TRIBOSVCARTX(Q(0),ZMASS ,ZWIDTH, MU,-1,W(1,1   )) 

      if (procid .eq. WPhadWMA) then

      CALL FVOXXX(W(1,5   ),W(1,1   ),GZL ,ZERO    ,ZERO    ,W(1,7   ))    
      CALL JIOXXX(W(1,4   ),W(1,7   ),GWF ,WMASS   ,WWIDTH  ,W(1,8   ))    
      CALL FVIXXX(W(1,3   ),W(1,8   ),GWF ,ZERO    ,ZERO    ,W(1,9   ))    
      CALL IOVXXX(W(1,9   ),W(1,2   ),W(1,6   ),GAU ,AMP(1   ))            
      CALL FVOXXX(W(1,2   ),W(1,8   ),GWF ,ZERO    ,ZERO    ,W(1,10  ))    
      CALL IOVXXX(W(1,3   ),W(1,10  ),W(1,6   ),GAD ,AMP(2   ))            
      CALL JIOXXX(W(1,3   ),W(1,2   ),GWF ,WMASS   ,WWIDTH  ,W(1,11  ))    
      CALL FVIXXX(W(1,4   ),W(1,11  ),GWF ,ZERO    ,ZERO    ,W(1,12  ))    
      CALL FVIXXX(W(1,12  ),W(1,1   ),GZL ,ZERO    ,ZERO    ,W(1,13  ))    
      CALL IOVXXX(W(1,13  ),W(1,5   ),W(1,6   ),GAL ,AMP(3   ))            
      CALL VVVXXX(W(1,8   ),W(1,11  ),W(1,6   ),GWWA ,AMP(4   ))           
      CALL IOVXXX(W(1,12  ),W(1,7   ),W(1,6   ),GAL ,AMP(5   ))            
      CALL JIOXXX(W(1,4   ),W(1,5   ),GWF ,WMASS   ,WWIDTH  ,W(1,14  ))    
      CALL JVVXXX(W(1,1   ),W(1,14  ),GWWZ ,WMASS   ,WWIDTH  ,W(1,         
     &     15  ))                                                          
      CALL FVIXXX(W(1,3   ),W(1,15  ),GWF ,ZERO    ,ZERO    ,W(1,16  ))    
      CALL IOVXXX(W(1,16  ),W(1,2   ),W(1,6   ),GAU ,AMP(6   ))            
      CALL FVOXXX(W(1,2   ),W(1,15  ),GWF ,ZERO    ,ZERO    ,W(1,17  ))    
      CALL IOVXXX(W(1,3   ),W(1,17  ),W(1,6   ),GAD ,AMP(7   ))            
      CALL JVVXXX(W(1,11  ),W(1,1   ),GWWZ ,WMASS   ,WWIDTH  ,W(1,         
     &     18  ))                                                          
      CALL FVIXXX(W(1,4   ),W(1,18  ),GWF ,ZERO    ,ZERO    ,W(1,19  ))    
      CALL IOVXXX(W(1,19  ),W(1,5   ),W(1,6   ),GAL ,AMP(8   ))            
      CALL VVVXXX(W(1,15  ),W(1,11  ),W(1,6   ),GWWA ,AMP(9   ))           
      CALL VVVXXX(W(1,14  ),W(1,18  ),W(1,6   ),GWWA ,AMP(10  ))           
      CALL W3W3XX(W(1,14  ),W(1,1   ),W(1,11  ),W(1,6   ),GWWZ ,GWWA ,     
     &     AMP(11  ))                                                      
      CALL FVIXXX(W(1,4   ),W(1,1   ),GZN ,ZERO    ,ZERO    ,W(1,20  ))    
      CALL JIOXXX(W(1,20  ),W(1,5   ),GWF ,WMASS   ,WWIDTH  ,W(1,21  ))    
      CALL FVIXXX(W(1,3   ),W(1,21  ),GWF ,ZERO    ,ZERO    ,W(1,22  ))    
      CALL IOVXXX(W(1,22  ),W(1,2   ),W(1,6   ),GAU ,AMP(12  ))            
      CALL FVOXXX(W(1,2   ),W(1,21  ),GWF ,ZERO    ,ZERO    ,W(1,23  ))    
      CALL IOVXXX(W(1,3   ),W(1,23  ),W(1,6   ),GAD ,AMP(13  ))            
      CALL FVIXXX(W(1,20  ),W(1,11  ),GWF ,ZERO    ,ZERO    ,W(1,24  ))    
      CALL IOVXXX(W(1,24  ),W(1,5   ),W(1,6   ),GAL ,AMP(14  ))            
      CALL VVVXXX(W(1,21  ),W(1,11  ),W(1,6   ),GWWA ,AMP(15  ))           
      CALL FVIXXX(W(1,3   ),W(1,1   ),GZD ,ZERO    ,ZERO    ,W(1,25  ))    
      CALL FVIXXX(W(1,25  ),W(1,14  ),GWF ,ZERO    ,ZERO    ,W(1,26  ))    
      CALL IOVXXX(W(1,26  ),W(1,2   ),W(1,6   ),GAU ,AMP(16  ))            
      CALL FVOXXX(W(1,2   ),W(1,14  ),GWF ,ZERO    ,ZERO    ,W(1,27  ))    
      CALL FVOXXX(W(1,27  ),W(1,1   ),GZD ,ZERO    ,ZERO    ,W(1,28  ))    
      CALL IOVXXX(W(1,3   ),W(1,28  ),W(1,6   ),GAD ,AMP(17  ))            
      CALL JIOXXX(W(1,25  ),W(1,2   ),GWF ,WMASS   ,WWIDTH  ,W(1,29  ))    
      CALL FVIXXX(W(1,4   ),W(1,29  ),GWF ,ZERO    ,ZERO    ,W(1,30  ))    
      CALL IOVXXX(W(1,30  ),W(1,5   ),W(1,6   ),GAL ,AMP(18  ))            
      CALL IOVXXX(W(1,25  ),W(1,27  ),W(1,6   ),GAD ,AMP(19  ))            
      CALL VVVXXX(W(1,14  ),W(1,29  ),W(1,6   ),GWWA ,AMP(20  ))           
      CALL FVIXXX(W(1,3   ),W(1,14  ),GWF ,ZERO    ,ZERO    ,W(1,31  ))    
      CALL FVIXXX(W(1,31  ),W(1,1   ),GZU ,ZERO    ,ZERO    ,W(1,32  ))    
      CALL IOVXXX(W(1,32  ),W(1,2   ),W(1,6   ),GAU ,AMP(21  ))            
      CALL FVOXXX(W(1,2   ),W(1,1   ),GZU ,ZERO    ,ZERO    ,W(1,33  ))    
      CALL FVOXXX(W(1,33  ),W(1,14  ),GWF ,ZERO    ,ZERO    ,W(1,34  ))    
      CALL IOVXXX(W(1,3   ),W(1,34  ),W(1,6   ),GAD ,AMP(22  ))            
      CALL JIOXXX(W(1,3   ),W(1,33  ),GWF ,WMASS   ,WWIDTH  ,W(1,35  ))    
      CALL FVIXXX(W(1,4   ),W(1,35  ),GWF ,ZERO    ,ZERO    ,W(1,36  ))    
      CALL IOVXXX(W(1,36  ),W(1,5   ),W(1,6   ),GAL ,AMP(23  ))            
      CALL IOVXXX(W(1,31  ),W(1,33  ),W(1,6   ),GAU ,AMP(24  ))            
      CALL VVVXXX(W(1,14  ),W(1,35  ),W(1,6   ),GWWA ,AMP(25  ))           
      wwatens(mu) = -(-AMP(   1)-AMP(   2)-AMP(   3)-AMP(   4)-AMP(   5)
     &             -AMP(   6)-AMP(   7)-AMP(   8)-AMP(   9)-AMP(  10)
     &             -AMP(  11)-AMP(  12)-AMP(  13)-AMP(  14)-AMP(  15)
     &             -AMP(  16)-AMP(  17)-AMP(  18)-AMP(  19)-AMP(  20)
     &             -AMP(  21)-AMP(  22)-AMP(  23)-AMP(  24)-AMP(  25))

      elseif (procid .eq. WPWMhadA) then
      
      CALL FVOXXX(W(1,5   ),W(1,1   ),GZD ,ZERO    ,ZERO    ,W(1,7   ))    
      CALL JIOXXX(W(1,4   ),W(1,7   ),GWF ,WMASS   ,WWIDTH  ,W(1,8   ))    
      CALL FVOXXX(W(1,2   ),W(1,8   ),GWF ,ZERO    ,ZERO    ,W(1,9   ))    
      CALL IOVXXX(W(1,3   ),W(1,9   ),W(1,6   ),GAL ,AMP(1   ))            
      CALL JIOXXX(W(1,3   ),W(1,2   ),GWF ,WMASS   ,WWIDTH  ,W(1,10  ))    
      CALL FVOXXX(W(1,7   ),W(1,10  ),GWF ,ZERO    ,ZERO    ,W(1,11  ))    
      CALL IOVXXX(W(1,4   ),W(1,11  ),W(1,6   ),GAU ,AMP(2   ))            
      CALL FVIXXX(W(1,4   ),W(1,10  ),GWF ,ZERO    ,ZERO    ,W(1,12  ))    
      CALL FVIXXX(W(1,12  ),W(1,1   ),GZD ,ZERO    ,ZERO    ,W(1,13  ))    
      CALL IOVXXX(W(1,13  ),W(1,5   ),W(1,6   ),GAD ,AMP(3   ))            
      CALL VVVXXX(W(1,8   ),W(1,10  ),W(1,6   ),GWWA ,AMP(4   ))           
      CALL IOVXXX(W(1,12  ),W(1,7   ),W(1,6   ),GAD ,AMP(5   ))            
      CALL JIOXXX(W(1,4   ),W(1,5   ),GWF ,WMASS   ,WWIDTH  ,W(1,14  ))    
      CALL JVVXXX(W(1,1   ),W(1,14  ),GWWZ ,WMASS   ,WWIDTH  ,W(1,         
     &     15  ))                                                          
      CALL FVOXXX(W(1,2   ),W(1,15  ),GWF ,ZERO    ,ZERO    ,W(1,16  ))    
      CALL IOVXXX(W(1,3   ),W(1,16  ),W(1,6   ),GAL ,AMP(6   ))            
      CALL JVVXXX(W(1,10  ),W(1,1   ),GWWZ ,WMASS   ,WWIDTH  ,W(1,         
     &     17  ))                                                          
      CALL FVOXXX(W(1,5   ),W(1,17  ),GWF ,ZERO    ,ZERO    ,W(1,18  ))    
      CALL IOVXXX(W(1,4   ),W(1,18  ),W(1,6   ),GAU ,AMP(7   ))            
      CALL FVIXXX(W(1,4   ),W(1,17  ),GWF ,ZERO    ,ZERO    ,W(1,19  ))    
      CALL IOVXXX(W(1,19  ),W(1,5   ),W(1,6   ),GAD ,AMP(8   ))            
      CALL VVVXXX(W(1,15  ),W(1,10  ),W(1,6   ),GWWA ,AMP(9   ))           
      CALL VVVXXX(W(1,14  ),W(1,17  ),W(1,6   ),GWWA ,AMP(10  ))           
      CALL W3W3XX(W(1,14  ),W(1,1   ),W(1,10  ),W(1,6   ),GWWZ ,GWWA ,     
     &     AMP(11  ))                                                      
      CALL FVIXXX(W(1,4   ),W(1,1   ),GZU ,ZERO    ,ZERO    ,W(1,20  ))    
      CALL JIOXXX(W(1,20  ),W(1,5   ),GWF ,WMASS   ,WWIDTH  ,W(1,21  ))    
      CALL FVOXXX(W(1,2   ),W(1,21  ),GWF ,ZERO    ,ZERO    ,W(1,22  ))    
      CALL IOVXXX(W(1,3   ),W(1,22  ),W(1,6   ),GAL ,AMP(12  ))            
      CALL FVOXXX(W(1,5   ),W(1,10  ),GWF ,ZERO    ,ZERO    ,W(1,23  ))    
      CALL FVOXXX(W(1,23  ),W(1,1   ),GZU ,ZERO    ,ZERO    ,W(1,24  ))    
      CALL IOVXXX(W(1,4   ),W(1,24  ),W(1,6   ),GAU ,AMP(13  ))            
      CALL FVIXXX(W(1,20  ),W(1,10  ),GWF ,ZERO    ,ZERO    ,W(1,25  ))    
      CALL IOVXXX(W(1,25  ),W(1,5   ),W(1,6   ),GAD ,AMP(14  ))            
      CALL IOVXXX(W(1,20  ),W(1,23  ),W(1,6   ),GAU ,AMP(15  ))            
      CALL VVVXXX(W(1,21  ),W(1,10  ),W(1,6   ),GWWA ,AMP(16  ))           
      CALL FVOXXX(W(1,2   ),W(1,14  ),GWF ,ZERO    ,ZERO    ,W(1,26  ))    
      CALL FVOXXX(W(1,26  ),W(1,1   ),GZL ,ZERO    ,ZERO    ,W(1,27  ))    
      CALL IOVXXX(W(1,3   ),W(1,27  ),W(1,6   ),GAL ,AMP(17  ))            
      CALL FVIXXX(W(1,3   ),W(1,1   ),GZL ,ZERO    ,ZERO    ,W(1,28  ))    
      CALL JIOXXX(W(1,28  ),W(1,2   ),GWF ,WMASS   ,WWIDTH  ,W(1,29  ))    
      CALL FVOXXX(W(1,5   ),W(1,29  ),GWF ,ZERO    ,ZERO    ,W(1,30  ))    
      CALL IOVXXX(W(1,4   ),W(1,30  ),W(1,6   ),GAU ,AMP(18  ))            
      CALL FVIXXX(W(1,4   ),W(1,29  ),GWF ,ZERO    ,ZERO    ,W(1,31  ))    
      CALL IOVXXX(W(1,31  ),W(1,5   ),W(1,6   ),GAD ,AMP(19  ))            
      CALL IOVXXX(W(1,28  ),W(1,26  ),W(1,6   ),GAL ,AMP(20  ))            
      CALL VVVXXX(W(1,14  ),W(1,29  ),W(1,6   ),GWWA ,AMP(21  ))           
      CALL FVOXXX(W(1,2   ),W(1,1   ),GZN ,ZERO    ,ZERO    ,W(1,32  ))    
      CALL FVOXXX(W(1,32  ),W(1,14  ),GWF ,ZERO    ,ZERO    ,W(1,33  ))    
      CALL IOVXXX(W(1,3   ),W(1,33  ),W(1,6   ),GAL ,AMP(22  ))            
      CALL JIOXXX(W(1,3   ),W(1,32  ),GWF ,WMASS   ,WWIDTH  ,W(1,34  ))    
      CALL FVOXXX(W(1,5   ),W(1,34  ),GWF ,ZERO    ,ZERO    ,W(1,35  ))    
      CALL IOVXXX(W(1,4   ),W(1,35  ),W(1,6   ),GAU ,AMP(23  ))            
      CALL FVIXXX(W(1,4   ),W(1,34  ),GWF ,ZERO    ,ZERO    ,W(1,36  ))    
      CALL IOVXXX(W(1,36  ),W(1,5   ),W(1,6   ),GAD ,AMP(24  ))            
      CALL VVVXXX(W(1,14  ),W(1,34  ),W(1,6   ),GWWA ,AMP(25  ))           
      wwatens(mu) = -(-AMP(   1)-AMP(   2)-AMP(   3)-AMP(   4)-AMP(   5)
     &             -AMP(   6)-AMP(   7)-AMP(   8)-AMP(   9)-AMP(  10)
     &             -AMP(  11)-AMP(  12)-AMP(  13)-AMP(  14)-AMP(  15)
     &             -AMP(  16)-AMP(  17)-AMP(  18)-AMP(  19)-AMP(  20)
     &             -AMP(  21)-AMP(  22)-AMP(  23)-AMP(  24)-AMP(  25))

      endif

      enddo
      wwatens(4) = dcmplx(q(0),q(3))
      wwatens(5) = dcmplx(q(1),q(2))
c
      END


c ------------------------------------------------------------

      SUBROUTINE WMTOWA_mg2_had(v,N,h,wmatens,NW)

      IMPLICIT NONE

      DOUBLE PRECISION P(0:3,2:5), v(0:3,6)
      COMPLEX*16 wmatens(0:5)
      INTEGER lsign(2:5,2),ll,mu,h,N
      INTEGER NW ! = 0: all diagrams, = 1: no non resonant diagrams

      !possible lepton helicities: 
      DATA (lsign(ll,1),ll=2,5) / -1, -1, -1, -1/ !h=1
      DATA (lsign(ll,2),ll=2,5) / -1, -1, +1, +1/ !h=2

      do mu = 0,3
         P(mu,2) = v(mu,3)
         P(mu,3) = v(mu,4)
         P(mu,4) = v(mu,5)
         P(mu,5) = v(mu,6)
      enddo

      call WMTOWA1_mg2_had(P,N,lsign(2,h),wmatens,NW)

      ! helicity combi nr.h is selected

      end

c ------------------------------------------------------------

      SUBROUTINE WMTOWA1_mg2_had(P,N,lsign,wmatens,NW)
C  
C Generated by MadGraph II Version 3.0. Updated 02/19/04                
C RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C FOR THE POINT WITH EXTERNAL LINES W(0:6,NEXTERNAL)
C  
C FOR PROCESS : w- -> vm~ mu- a  
C  
      IMPLICIT NONE
C  
C CONSTANTS
C  
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=   3) 
      INTEGER    NWAVEFUNCS
      PARAMETER (NWAVEFUNCS=   7) 
      DOUBLE PRECISION     ZERO
      PARAMETER (ZERO=0D0)
C  
C ARGUMENTS 
C  
      DOUBLE PRECISION P(0:3,2:5), Q(0:3)
      INTEGER N
      COMPLEX*16 wmatens(0:5)
      INTEGER lsign(2:5)
      INTEGER NW ! = 0: all diagrams, = 1: no non resonant diagrams

C  
C LOCAL VARIABLES 
C  
      INTEGER I,J, mu
      COMPLEX*16 AMP(NGRAPHS)
      COMPLEX*16 W(6,NWAVEFUNCS)

c  lepton spinors and W+-, Z/A polarization vectors
#include "tensor.inc"

      LOGICAL lswitch
      PARAMETER (lswitch=.true.)

C  
C GLOBAL VARIABLES
C  
#include "VBFNLO/utilities/coupl.inc"                       
#include "VBFNLO/utilities/global.inc"
#include "VBFNLO/utilities/process.inc"
C                                                                          
C ----------
C BEGIN CODE
C ----------
      if (lswitch) then      ! read in lepton an W states from common block
         do i=1,6
            w(i,2)  = wvm(i,N)
            w(i,3)  = wmu(i,N)
            w(i,4)  = atau(i,N)
         enddo
      endif

      do mu = 0,3
         q(mu) = p(mu,2)+p(mu,3)+p(mu,4)+p(mu,5)
      enddo

      if (.not.lswitch) then     
         CALL OXXXXX(P(0,2   ),ZERO ,  lsign(2),+1, W(1,2   )) ! mu-       
         CALL IXXXXX(P(0,3   ),ZERO , -lsign(3),-1, W(1,3   )) ! vm~       
         CALL VXXXXX(P(0,4)+P(0,5),ZERO ,  +1,  +1, W(1,4   )) ! A
         print*," mu  ",(wmu(i,N)/w(i,2),i=1,6)
         print*," vm  ",(wvm(i,N)/w(i,3),i=1,6)
         print*," A   ",(atau(i,N)/w(i,4),i=1,6)
      endif
      do mu = 0,3
      CALL TRIBOSVCARTX(Q(0),WMASS ,WWIDTH, MU,-1,W(1,1   ))

      if (procid .eq. WPhadWMA) then

      CALL JIOXXX(W(1,2   ),W(1,3   ),GWF ,WMASS   ,WWIDTH  ,W(1,5   ))    
      CALL VVVXXX(W(1,5   ),W(1,1   ),W(1,4   ),GWWA ,AMP(1   ))           
      CALL FVIXXX(W(1,2   ),W(1,1   ),GWF ,ZERO    ,ZERO    ,W(1,6   ))    
      CALL IOVXXX(W(1,6   ),W(1,3   ),W(1,4   ),GAL ,AMP(2   ))            
      wmatens(   mu) = +AMP(   1)+AMP(   2)

      elseif (procid .eq. WPWMhadA) then
      
      CALL JIOXXX(W(1,2   ),W(1,3   ),GWF ,WMASS   ,WWIDTH  ,W(1,5   ))    
      CALL VVVXXX(W(1,5   ),W(1,1   ),W(1,4   ),GWWA ,AMP(1   ))           
      CALL FVOXXX(W(1,3   ),W(1,1   ),GWF ,ZERO    ,ZERO    ,W(1,6   ))    
      CALL IOVXXX(W(1,2   ),W(1,6   ),W(1,4   ),GAU ,AMP(2   ))            
      CALL FVIXXX(W(1,2   ),W(1,1   ),GWF ,ZERO    ,ZERO    ,W(1,7   ))    
      CALL IOVXXX(W(1,7   ),W(1,3   ),W(1,4   ),GAD ,AMP(3   ))            
      wmatens(   mu) = +AMP(   1)+AMP(   2)+AMP(   3)

      endif

      enddo
      wmatens(4) = dcmplx(q(0),q(3))
      wmatens(5) = dcmplx(q(1),q(2))
c
      return
      END


c----------------------------------------------------------------------

      SUBROUTINE WPTOWA_mg2_had(v,N,h,wpatens,NW)

      IMPLICIT NONE

      DOUBLE PRECISION v(0:3,6)
      DOUBLE PRECISION P(0:3,2:5)
      
      COMPLEX*16 wpatens(0:5)
      INTEGER lsign(2:5,2),ll,mu,h,N
      INTEGER NW ! = 0: all diagrams, = 1: no non resonant diagrams

      ! possible lepton helicities:
      DATA (lsign(ll,1),ll=2,5) / -1, -1, -1, -1/  !h=1
      DATA (lsign(ll,2),ll=2,5) / -1, -1,  1,  1/  !h=2

      do mu = 0,3
         P(mu,2) = v(mu,1)
         P(mu,3) = v(mu,2)
         P(mu,4) = v(mu,5)
         P(mu,5) = v(mu,6)
      enddo

      call WPTOWA1_mg2_had(P,N,lsign(2,h),wpatens,NW)

      ! helicity combi nr.h is selected

      end

c ------------------------------------------------------------

      SUBROUTINE WPTOWA1_mg2_had(P,N,lsign,wpatens,NW)
C  
C Generated by MadGraph II Version 3.0. Updated 02/19/04                
C RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C FOR THE POINT WITH EXTERNAL LINES W(0:6,NEXTERNAL)
C  
C FOR PROCESS : w+ -> ve e+ a  
C  
      IMPLICIT NONE
C  
C CONSTANTS
C  
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=   3)
      INTEGER    NWAVEFUNCS
      PARAMETER (NWAVEFUNCS=   7)
      DOUBLE PRECISION     ZERO
      PARAMETER (ZERO=0D0)
C  
C ARGUMENTS 
C  
      DOUBLE PRECISION P(0:3,2:5), Q(0:3)
      INTEGER N
      COMPLEX*16 wpatens(0:5)
      INTEGER lsign(2:5)
      integer NW ! = 0: all diagrams, = 1: no non resonant diagrams
C  
C LOCAL VARIABLES 
C  
      INTEGER I,J, mu
      COMPLEX*16 AMP(NGRAPHS)
      COMPLEX*16 W(6,NWAVEFUNCS)

c  lepton spinors and W+-, Z/A polarization vectors
#include "tensor.inc"

  
C GLOBAL VARIABLES
  
#include "VBFNLO/utilities/coupl.inc"       
#include "VBFNLO/utilities/global.inc"
#include "VBFNLO/utilities/process.inc"

      logical lswitch
      parameter (lswitch=.true.)
                       
C                                                                          
C ----------
C BEGIN CODE
C ----------
      if (lswitch) then      ! read in lepton an W states from common block
         do i=1,6
            w(i,2)  = wve(i,N)
            w(i,3)  = wep(i,N)
            w(i,4)  = atau(i,N)
         enddo
      endif

      do mu = 0,3
         q(mu) = p(mu,2)+p(mu,3)+p(mu,4)+p(mu,5)
      enddo

      if (.not.lswitch) then     
         CALL OXXXXX(P(0,2   ),ZERO ,  lsign(2),+1,W(1,2   )) ! ve       
         CALL IXXXXX(P(0,3   ),ZERO , -lsign(3),-1,W(1,3   )) ! e+       
         CALL VXXXXX(P(0,4)+P(0,5),ZERO ,  +1,  +1, W(1,4   )) ! A
         print*,' ve  ',(wve(i,N)/w(i,2),i=1,6)
         print*,' e+  ',(wep(i,N)/w(i,3),i=1,6)
         print*,' A  ',(atau(i,N)/w(i,4),i=1,6)
      endif
      do mu = 0,3
      CALL TRIBOSVCARTX(Q(0),WMASS ,WWIDTH, MU,-1,W(1,1   ))

      if (procid .eq. WPhadWMA) then

      CALL JIOXXX(W(1,3   ),W(1,2   ),GWF ,WMASS   ,WWIDTH  ,W(1,5   ))    
      CALL VVVXXX(W(1,1   ),W(1,5   ),W(1,4   ),GWWA ,AMP(1   ))           
      CALL FVIXXX(W(1,3   ),W(1,1   ),GWF ,ZERO    ,ZERO    ,W(1,6   ))    
      CALL IOVXXX(W(1,6   ),W(1,2   ),W(1,4   ),GAU ,AMP(2   ))            
      CALL FVOXXX(W(1,2   ),W(1,1   ),GWF ,ZERO    ,ZERO    ,W(1,7   ))    
      CALL IOVXXX(W(1,3   ),W(1,7   ),W(1,4   ),GAD ,AMP(3   ))            
      wpatens(mu) = +AMP(   1)+AMP(   2)+AMP(   3)

      elseif (procid .eq. WPWMhadA) then
      
      CALL JIOXXX(W(1,3   ),W(1,2   ),GWF ,WMASS   ,WWIDTH  ,W(1,5   ))    
      CALL VVVXXX(W(1,1   ),W(1,5   ),W(1,4   ),GWWA ,AMP(1   ))           
      CALL FVOXXX(W(1,2   ),W(1,1   ),GWF ,ZERO    ,ZERO    ,W(1,6   ))    
      CALL IOVXXX(W(1,3   ),W(1,6   ),W(1,4   ),GAL ,AMP(2   ))            
      wpatens(mu) = +AMP(   1)+AMP(   2)

      endif

      enddo
      wpatens(4) = dcmplx(q(0),q(3))
      wpatens(5) = dcmplx(q(1),q(2))
c
      return
      END


