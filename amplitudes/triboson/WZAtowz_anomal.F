c
c in this file leptonic tensors needed for qq -> WZA, WZA -> 4lA 
c are computed for specific helicities (h)
c
c ------------------------------------------------------------
c ------------------------------------------------------------

      SUBROUTINE tribosWPTOWZ_anomal(v,N,h,wpz,NW)

      IMPLICIT NONE

      DOUBLE PRECISION v(0:3,6)
      DOUBLE PRECISION P(0:3,2:5)
      
      complex*16 wpz(0:5)
      integer lsign(2:5,5),ll,mu,h,N
      integer NW ! = 0: all diagrams, = 1: no non resonant diagrams

      ! possible lepton helicities:
      data (lsign(ll,1),ll=2,5) / -1, -1, -1, -1/  !h=1
      data (lsign(ll,2),ll=2,5) / -1, -1, +1, +1/  !h=2
      data (lsign(ll,3),ll=2,5) / -1, -1, -1, -1/  !h=3
      data (lsign(ll,4),ll=2,5) / -1, -1, +1, +1/  !h=4

      do mu = 0,3
         P(mu,2) = v(mu,1)
         P(mu,3) = v(mu,2)
         P(mu,4) = v(mu,3)
         P(mu,5) = v(mu,4)
      enddo

      call tribosWPTOWZ1_anomal(P,N,lsign(2,h),wpz,NW)

      ! helicity combi nr.h is selected

      end

c ------------------------------------------------------------

      SUBROUTINE tribosWPTOWZ1_anomal(P,N,lsign,wpz,NW)
C  
C Generated by MadGraph II Version 3.0. Updated 02/19/04                
C RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C FOR THE POINT WITH EXTERNAL LINES W(0:6,NEXTERNAL)
C  
C FOR PROCESS : w+ ->  ve e+ mu- mu+   
C  
      IMPLICIT NONE
C  
C CONSTANTS
C  
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=   7) 
      INTEGER    NWAVEFUNCS
      PARAMETER (NWAVEFUNCS=  15) 
      DOUBLE PRECISION     ZERO
      PARAMETER (ZERO=0D0)
C  
C ARGUMENTS 
C  
      DOUBLE PRECISION P(0:3,2:5), Q(0:3)
      INTEGER N
      COMPLEX*16 wpz(0:5)
      INTEGER lsign(2:5)
      integer NW ! = 0: all diagrams, = 1: no non resonant diagrams
C  
C LOCAL VARIABLES 
C  
      INTEGER I, mu
      COMPLEX*16 AMP(NGRAPHS)
      COMPLEX*16 W(6,NWAVEFUNCS)

c  lepton spinors and W+-, Z/A polarization vectors
#include "tensor.inc"

  
C GLOBAL VARIABLES
  
#include "VBFNLO/utilities/coupl.inc"   

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
            w(i,4)  = wmu(i,N)
            w(i,5)  = wmp(i,N)
            w(i,6)  = wp(i,N)
         enddo
      endif

      do mu = 0,3
         q(mu) = p(mu,2)+p(mu,3)+p(mu,4)+p(mu,5)
      enddo

      if (.not.lswitch) then     
         CALL OXXXXX(P(0,2   ),ZERO ,  lsign(2),+1,W(1,2   )) ! ve       
         CALL IXXXXX(P(0,3   ),ZERO , -lsign(3),-1,W(1,3   )) ! e+       
         CALL OXXXXX(P(0,4   ),ZERO ,  lsign(4),+1,W(1,4   )) ! mu-      
         CALL IXXXXX(P(0,5   ),ZERO , -lsign(5),-1,W(1,5   )) ! mu+       
         CALL JIOXXX(W(1,3),W(1,2),GWF,WMASS,WWIDTH,W(1,6  )) ! wp
         print*," ve  ",(wve(i,N)/w(i,2),i=1,6)
         print*," e+  ",(wep(i,N)/w(i,3),i=1,6)
         print*," mu- ",(wmu(i,N)/w(i,4),i=1,6)
         print*," mu+ ",(wmp(i,N)/w(i,5),i=1,6)
         print*," wp  ",(wp(i,N)/w(i,6),i=1,6)
      endif
      do mu = 0,3
      CALL TRIBOSVCARTX(Q(0),WMASS ,WWIDTH, MU,-1,W(1,1   ))
      CALL FVOXXX(W(1,4   ),W(1,6   ),GWF ,ZERO    ,ZERO    ,W(1,7   ))    
      CALL IOVXXX(W(1,5   ),W(1,7   ),W(1,1   ),GWF ,AMP(1   ))
            
c      CALL JVVXXX(W(1,1   ),W(1,6   ),GWWA ,ZERO    ,ZERO    ,W(1,8  ))
      CALL jaww_anomal3(W(1,1   ),W(1,6   ),W(1,8  ))
  
      CALL IOVXXX(W(1,5   ),W(1,4   ),W(1,8   ),GAL ,AMP(2   )) 
           
c      CALL JVVXXX(W(1,1   ),W(1,6   ),GWWZ ,ZMASS   ,ZWIDTH  ,W(1,9  )) 
      CALL jzww_anomal3(W(1,1   ),W(1,6   ),W(1,9  ))
   
      CALL IOVXXX(W(1,5   ),W(1,4   ),W(1,9   ),GZL ,AMP(3   ))            
      CALL FVIXXX(W(1,3   ),W(1,1   ),GWF ,ZERO    ,ZERO    ,W(1,11  ))    
      CALL JIOXXX(W(1,11  ),W(1,2   ),GZN ,ZMASS   ,ZWIDTH  ,W(1,12  ))    
      CALL IOVXXX(W(1,5   ),W(1,4   ),W(1,12  ),GZL ,AMP(5   ))            
      CALL FVOXXX(W(1,2   ),W(1,1   ),GWF ,ZERO    ,ZERO    ,W(1,13  ))    
      CALL JIOXXX(W(1,3   ),W(1,13  ),GAL ,ZERO    ,ZERO    ,W(1,14  ))    
      CALL IOVXXX(W(1,5   ),W(1,4   ),W(1,14  ),GAL ,AMP(6   ))            
      CALL JIOXXX(W(1,3   ),W(1,13  ),GZL ,ZMASS   ,ZWIDTH  ,W(1,15  ))    
      CALL IOVXXX(W(1,5   ),W(1,4   ),W(1,15  ),GZL ,AMP(7   ))    
      if (NW.eq.0) then        
      wpz(mu) = +AMP(   1)+AMP(   5)+AMP(   6)+AMP(   7) !non-resonant diagrams
     &          +AMP(   2)+AMP(   3)
      else if (NW.eq.1) then
      wpz(mu) = +AMP(   2)+AMP(   3)
      endif
      enddo
      wpz(4) = dcmplx(q(0),q(3))
      wpz(5) = dcmplx(q(1),q(2))
c
      return
      END

c ------------------------------------------------------------

      SUBROUTINE tribosWMTOWZ_anomal(v,N,h,wmz,NW)

      IMPLICIT NONE

      DOUBLE PRECISION v(0:3,6)
      DOUBLE PRECISION P(0:3,2:5)
      
      complex*16 wmz(0:5)
      integer lsign(2:5,5),ll,mu,h,N
      integer NW ! = 0: all diagrams, = 1: no non resonant diagrams

      ! possible lepton helicities:
      data (lsign(ll,1),ll=2,5) / -1, -1, -1, -1/  !h=1
      data (lsign(ll,2),ll=2,5) / -1, -1, +1, +1/  !h=2
      data (lsign(ll,3),ll=2,5) / -1, -1, -1, -1/  !h=3
      data (lsign(ll,4),ll=2,5) / -1, -1, +1, +1/  !h=4

      do mu = 0,3
         P(mu,2) = v(mu,1)
         P(mu,3) = v(mu,2)
         P(mu,4) = v(mu,3)
         P(mu,5) = v(mu,4)
      enddo

      call tribosWMTOWZ1_anomal(P,N,lsign(2,h),wmz,NW)

      ! helicity combi nr.h is selected

      end

c ------------------------------------------------------------

      SUBROUTINE tribosWMTOWZ1_anomal(P,N,lsign,wmz,NW)
C  
C Generated by MadGraph II Version 3.0. Updated 02/19/04                
C RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C FOR THE POINT WITH EXTERNAL LINES W(0:6,NEXTERNAL)
C  
C FOR PROCESS : w- ->  ve~ e- mu- mu+   
C  
      IMPLICIT NONE
C  
C CONSTANTS
C  
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=   6) 
      INTEGER    NWAVEFUNCS
      PARAMETER (NWAVEFUNCS=  14) 
      DOUBLE PRECISION     ZERO
      PARAMETER (ZERO=0D0)
C  
C ARGUMENTS 
C  
      DOUBLE PRECISION P(0:3,2:5), Q(0:3)
      INTEGER N
      COMPLEX*16 wmz(0:5)
      INTEGER lsign(2:5)
      integer NW ! = 0: all diagrams, = 1: no non resonant diagrams
C  
C LOCAL VARIABLES 
C  
      INTEGER I, mu
      COMPLEX*16 AMP(NGRAPHS)
      COMPLEX*16 W(6,NWAVEFUNCS)

c  lepton spinors and W+-, Z/A polarization vectors
#include "tensor.inc"

  
C GLOBAL VARIABLES
  
#include "VBFNLO/utilities/coupl.inc"   

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
            w(i,4)  = wmu(i,N)
            w(i,5)  = wmp(i,N)
            w(i,6)  = wp(i,N)
         enddo
      endif

      do mu = 0,3
         q(mu) = p(mu,2)+p(mu,3)+p(mu,4)+p(mu,5)
      enddo

      if (.not.lswitch) then     
         CALL OXXXXX(P(0,2   ),ZERO ,  lsign(2),+1,W(1,2   )) ! e-       
         CALL IXXXXX(P(0,3   ),ZERO , -lsign(3),-1,W(1,3   )) ! ve~       
         CALL OXXXXX(P(0,4   ),ZERO ,  lsign(4),+1,W(1,4   )) ! mu-      
         CALL IXXXXX(P(0,5   ),ZERO , -lsign(5),-1,W(1,5   )) ! mu+       
         CALL JIOXXX(W(1,3),W(1,2),GWF,WMASS,WWIDTH,W(1,6  )) ! wm
         print*," ve  ",(wve(i,N)/w(i,2),i=1,6)
         print*," e+  ",(wep(i,N)/w(i,3),i=1,6)
         print*," mu- ",(wmu(i,N)/w(i,4),i=1,6)
         print*," mu+ ",(wmp(i,N)/w(i,5),i=1,6)
         print*," wp  ",(wp(i,N)/w(i,6),i=1,6)
      endif
      do mu = 0,3
      CALL TRIBOSVCARTX(Q(0),WMASS ,WWIDTH, MU,-1,W(1,1   ))

c      CALL JVVXXX(W(1,6   ),W(1,1   ),GWWA ,ZERO    ,AWIDTH  ,W(1,7   ))
      CALL jaww_anomal3(W(1,6   ),W(1,1   ),W(1,7   ))

      CALL IOVXXX(W(1,5   ),W(1,4   ),W(1,7   ),GAL ,AMP(1   ))

c      CALL JVVXXX(W(1,6   ),W(1,1   ),GWWZ ,ZMASS   ,ZWIDTH  ,W(1,8   ))
      CALL jzww_anomal3(W(1,6   ),W(1,1   ),W(1,8   ))

      CALL IOVXXX(W(1,5   ),W(1,4   ),W(1,8   ),GZL ,AMP(2   ))
      CALL FVOXXX(W(1,4   ),W(1,1   ),GWF ,ZERO    ,ZERO    ,W(1,9   ))
      CALL IOVXXX(W(1,5   ),W(1,9   ),W(1,6   ),GWF ,AMP(3   ))        
      CALL FVIXXX(W(1,3   ),W(1,1   ),GWF ,ZERO    ,ZERO    ,W(1,10  ))
      CALL JIOXXX(W(1,10  ),W(1,2   ),GAL ,ZERO    ,AWIDTH  ,W(1,11  ))
      CALL IOVXXX(W(1,5   ),W(1,4   ),W(1,11  ),GAL ,AMP(4   ))
      CALL JIOXXX(W(1,10  ),W(1,2   ),GZL ,ZMASS   ,ZWIDTH  ,W(1,12  ))
      CALL IOVXXX(W(1,5   ),W(1,4   ),W(1,12  ),GZL ,AMP(5   ))
      CALL FVOXXX(W(1,2   ),W(1,1   ),GWF ,ZERO    ,ZERO    ,W(1,13  ))
      CALL JIOXXX(W(1,3   ),W(1,13  ),GZN ,ZMASS   ,ZWIDTH  ,W(1,14  ))
      CALL IOVXXX(W(1,5   ),W(1,4   ),W(1,14  ),GZL ,AMP(6   ))
      if (NW.eq.0) then        
      wmz(mu) = +AMP(   3)+AMP(   4)+AMP(   5)+AMP(   6) !non-resonant diagrams
     &          +AMP(   1)+AMP(   2)
      else if (NW.eq.1) then
      wmz(mu) = +AMP(   1)+AMP(   2)
      endif
      enddo
      wmz(4) = dcmplx(q(0),q(3))
      wmz(5) = dcmplx(q(1),q(2))
c
      return
      END
