      subroutine wwtoza_anomal(q1,q2,P,h,ww)
	
      IMPLICIT NONE

      REAL*8 Q1(0:3), Q2(0:3), P(0:3,3:6)
      complex*16 ww(0:3,0:3)
      integer lsign(3:6,4),ll,h

	! possible lepton helicities:
	data (lsign(ll,1),ll=3,6) / -1, -1, -1, -1/  !h=1
	data (lsign(ll,2),ll=3,6) / -1, -1,  1,  1/  !h=2
	data (lsign(ll,3),ll=3,6) /  1,  1, -1, -1/  !h=3
	data (lsign(ll,4),ll=3,6) /  1,  1,  1,  1/  !h=4
	
	call WWtoZA1_anomal(q1,q2,P,lsign(3,h),ww(0,0))
	
	! helicity combi nr.h is selected
	
	end
		
c ------------------------------------------------------------

      subroutine WWtoZA1_anomal(q1,q2,P,lsign,ww)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.1.2, 2014-07-03
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     
C     Process: w+ w- > e+ e- a QCD=0 
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=16)
      INTEGER    NWAVEFUNCS,     NCOLOR
      PARAMETER (NWAVEFUNCS=11, NCOLOR=1)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,3:6)
      REAL*8 Q1(0:3),Q2(0:3)
      INTEGER lsign(3:6)
      COMPLEX*16 ww(0:3,0:3)
C     
C     LOCAL VARIABLES 
C     
      INTEGER I,MU,NU
      COMPLEX*16 AMP(NGRAPHS)
      COMPLEX*16 W(6,NWAVEFUNCS)
C  
C GLOBAL VARIABLES
C  
#include "tensorz.inc" 
#include "VBFNLO/utilities/coupl.inc"

      logical lswitch
      parameter (lswitch=.true.)   

C     ----------
C     BEGIN CODE
C     ----------

      DO MU = 0,3
        DO NU = 0,3

      if (lswitch) then
      	do i = 1,6
	 w(i,3) = lep(i)
	 w(i,4) = lem(i)
	 w(i,5) = ea(i)
	 w(i,10) = ae(i)
         w(i,11)= ze(i)
      	enddo
      else 
c incoming
c        CALL VXXXXX(Q1(0),WMASS,NHEL(1),-1*IC(1),W(1,1))
c        CALL VXXXXX(Q2(02),WMASS,NHEL(2),-1*IC(2),W(1,2))
c outgoing
c        CALL IXXXXX(P(0,3),ZERO,NHEL(3),-1*IC(3),W(1,3))
c        CALL OXXXXX(P(0,4),ZERO,NHEL(4),+1*IC(4),W(1,4))
c        CALL VXXXXX(P(0,5),ZERO,NHEL(5),+1*IC(5),W(1,5))
c diagrams
c        CALL JIOXXX(W(1,3),W(1,4),GAL,ZERO,AWIDTH,W(1,10)) !d 7
c        CALL JIOXXX(W(1,3),W(1,4),GZL,ZMASS,ZWIDTH,W(1,11)) !d 8

      endif
      CALL VCARTX(Q1(0),WMASS ,wwidth, MU,-1,W(1,1   ))      
      CALL VCARTX(Q2(0),WMASS ,wwidth, NU,-1,W(1,2   )) 

      CALL FVIXXX(W(1,3),W(1,5),GAL,ZERO,ZERO,W(1,7))
c      CALL JVVXXX(W(1,1),W(1,2),GWWA,ZERO,AWIDTH,W(1,6))
      CALL jaww_anomal3(W(1,1),W(1,2),W(1,6))

C     Amplitude(s) for diagram number 1
      CALL IOVXXX(W(1,7),W(1,4),W(1,6),GAL,AMP(1))
c      CALL JVVXXX(W(1,1),W(1,2),GWWZ,ZMASS,ZWIDTH,W(1,8))
      CALL jzww_anomal3(W(1,1),W(1,2),W(1,8))
      
C     Amplitude(s) for diagram number 2
      CALL IOVXXX(W(1,7),W(1,4),W(1,8),GZL,AMP(2))
      CALL FVOXXX(W(1,4),W(1,5),GAL,ZERO,ZERO,W(1,9))
C     Amplitude(s) for diagram number 3
      CALL IOVXXX(W(1,3),W(1,9),W(1,6),GAL,AMP(3))
C     Amplitude(s) for diagram number 4
      CALL IOVXXX(W(1,3),W(1,9),W(1,8),GZL,AMP(4))
      
c??? additional diagrams with AAA, AAZ, AZZ vertices ???      

      CALL FVIXXX(W(1,3),W(1,1),GWF,ZERO,ZERO,W(1,8))
c      CALL JVVXXX(W(1,2),W(1,5),GWWA,WMASS,WWIDTH,W(1,6))
      CALL jwmwpa_anomal3(W(1,2),W(1,5),W(1,6))      
      
C     Amplitude(s) for diagram number 5
      CALL IOVXXX(W(1,8),W(1,4),W(1,6),GWF,AMP(5))
C     Amplitude(s) for diagram number 6
      CALL IOVXXX(W(1,8),W(1,9),W(1,2),GWF,AMP(6))
c      CALL JVVXXX(W(1,5),W(1,1),GWWA,WMASS,WWIDTH,W(1,8))
      CALL jwpawm_anomal3(W(1,5),W(1,1),W(1,8))
      
      CALL FVOXXX(W(1,4),W(1,2),GWF,ZERO,ZERO,W(1,9))
C     Amplitude(s) for diagram number 7
      CALL IOVXXX(W(1,3),W(1,9),W(1,8),GWF,AMP(7))
C     Amplitude(s) for diagram number 8
c      CALL VVVXXX(W(1,8),W(1,2),W(1,10),GWWA,AMP(8))
      call wwa_anomal3(W(1,8),W(1,2),W(1,10),AMP(8))
      
C     Amplitude(s) for diagram number 9
c      CALL VVVXXX(W(1,8),W(1,2),W(1,11),GWWZ,AMP(9))
      call wwz_anomal3(W(1,8),W(1,2),W(1,11),AMP(9))
      
C     Amplitude(s) for diagram number 10
      CALL IOVXXX(W(1,7),W(1,9),W(1,1),GWF,AMP(10))
C     Amplitude(s) for diagram number 11
c      CALL VVVXXX(W(1,1),W(1,6),W(1,10),GWWA,AMP(11))
      call wwa_anomal3(W(1,1),W(1,6),W(1,10),AMP(11))
      
C     Amplitude(s) for diagram number 12
c      CALL VVVXXX(W(1,1),W(1,6),W(1,11),GWWZ,AMP(12))
      call wwz_anomal3(W(1,1),W(1,6),W(1,11),AMP(12))
      
c      CALL JW3WXX(W(1,2),W(1,5),W(1,1),GWWA*GWWA,1D0,ZERO,AWIDTH,W(1
c     $ ,11))
cC     Amplitude(s) for diagram number 13
c      CALL IOVXXX(W(1,3),W(1,4),W(1,11),GAL,AMP(13))
c      CALL JW3WXX(W(1,2),W(1,5),W(1,1),GWWZ*GWWA,1D0,ZMASS,ZWIDTH,W(1
c     $ ,11))
cC     Amplitude(s) for diagram number 14
c      CALL IOVXXX(W(1,3),W(1,4),W(1,11),GZL,AMP(14))
      call wwaa_anomal4(W(1,1),W(1,5),W(1,2),W(1,10),amp(13))
      call wwza_anomal4(W(1,1),W(1,11),W(1,2),W(1,5),amp(14))
      
c     new Higgs contributions
      call jhww_anomal3(W(1,1),W(1,2),W(1,6))
      call aah_anomal3(W(1,5),W(1,10),W(1,6),amp(15))
      call azh_anomal3(W(1,5),W(1,11),W(1,6),amp(16))
      

      WW(MU,NU)=+AMP(1)+AMP(2)+AMP(3)+AMP(4)+AMP(5)+AMP(6)+AMP(7)+AMP(8)
     $ +AMP(9)+AMP(10)+AMP(11)+AMP(12)+AMP(13)+AMP(14)+amp(15)+amp(16)

        ENDDO
      ENDDO

      END

c ------------------------------------------------------------

      subroutine wwtozan_anomal(q1,q2,P,h,ww)
	
      IMPLICIT NONE

      REAL*8 Q1(0:3), Q2(0:3), P(0:3,3:6)
      complex*16 ww(0:3,0:3)
      integer lsign(3:6,4),ll,h
      

	! possible lepton helicities:
        data (lsign(ll,1),ll=3,6) / -1, -1, -1, -1/  !h=1 -> zero
	data (lsign(ll,2),ll=3,6) / -1, -1,  1,  1/  !h=2
	data (lsign(ll,3),ll=3,6) /  1,  1, -1, -1/  !h=3 -> zero
	data (lsign(ll,4),ll=3,6) /  1,  1,  1,  1/  !h=4
	
	call WWtoZAN1_anomal(q1,q2,P,lsign(3,h),ww)
	
	end
		
c ------------------------------------------------------------

      subroutine WWtoZAN1_anomal(Q1,Q2,P,lsign,ww)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.1.2, 2014-07-03
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     
C     Process: w+ w- > ve ve~ a QCD=0
c   fc Order matters?
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=7)
      INTEGER    NWAVEFUNCS,     NCOLOR
      PARAMETER (NWAVEFUNCS=9, NCOLOR=1)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,3:6)
      REAL*8 Q1(0:3),Q2(0:3)
      INTEGER lsign(3:6)
      COMPLEX*16 ww(0:3,0:3)
C     
C     LOCAL VARIABLES 
C     
      INTEGER I,MU,NU
      COMPLEX*16 AMP(NGRAPHS)
      COMPLEX*16 W(6,NWAVEFUNCS)
C     
C     GLOBAL VARIABLES
C    
#include "tensorz.inc"
#include "VBFNLO/utilities/coupl.inc"

      logical lswitch
      parameter (lswitch=.true.)   

C     ----------
C     BEGIN CODE
C     ----------

      DO MU = 0,3
        DO NU = 0,3

      if (lswitch) then
      	do i = 1,6
	 w(i,3) = lum(i) 
	 w(i,4) = lup(i)
	 w(i,5) = ea(i) 
! !          w(i,7)= -ze(i)  ! fc what about the sign here
      	enddo
      else
c incoming            
c        CALL VXXXXX(P(0,1),WMASS,NHEL(1),-1*IC(1),W(1,1))
c        CALL VXXXXX(P(0,2),WMASS,NHEL(2),-1*IC(2),W(1,2))
c outgoing
c        CALL OXXXXX(P(0,3),ZERO,NHEL(3),+1*IC(3),W(1,3))
c        CALL IXXXXX(P(0,4),ZERO,NHEL(4),-1*IC(4),W(1,4))
c        CALL VXXXXX(P(0,5),ZERO,NHEL(5),+1*IC(5),W(1,5))         
      endif

      CALL VCARTX(Q1(0),WMASS ,wwidth, MU,-1,W(1,1))        
      CALL VCARTX(Q2(0),WMASS ,wwidth, NU,-1,W(1,2))
      
      CALL FVOXXX(W(1,3),W(1,1),GWF,ZERO,ZERO,W(1,6))
      CALL FVIXXX(W(1,4),W(1,2),GWF,ZERO,ZERO,W(1,7))
C     Amplitude(s) for diagram number 1
      CALL IOVXXX(W(1,7),W(1,6),W(1,5),GAL,AMP(1))
c      CALL JVVXXX(W(1,2),W(1,5),GWWA,WMASS,WWIDTH,W(1,8))
      CALL jwmwpa_anomal3(W(1,2),W(1,5),W(1,8))
      
C     Amplitude(s) for diagram number 2
      CALL IOVXXX(W(1,4),W(1,6),W(1,8),GWF,AMP(2))
c      CALL JVVXXX(W(1,5),W(1,1),GWWA,WMASS,WWIDTH,W(1,6))
      call jwpawm_anomal3(W(1,5),W(1,1),W(1,6))
C     Amplitude(s) for diagram number 3
      CALL IOVXXX(W(1,7),W(1,3),W(1,6),GWF,AMP(3))
      CALL JIOXXX(W(1,4),W(1,3),GZN,ZMASS,ZWIDTH,W(1,7))
C     Amplitude(s) for diagram number 4
c      CALL VVVXXX(W(1,6),W(1,2),W(1,7),GWWZ,AMP(4))
      call wwz_anomal3(W(1,6),W(1,2),W(1,7),AMP(4))
C     Amplitude(s) for diagram number 5
c      CALL VVVXXX(W(1,1),W(1,8),W(1,7),GWWZ,AMP(5))
      call wwz_anomal3(W(1,1),W(1,8),W(1,7),AMP(5))
c      CALL JW3WXX(W(1,2),W(1,5),W(1,1),GWWZ*GWWA,1D0,ZMASS,ZWIDTH,W(1
c     $ ,7))
cC     Amplitude(s) for diagram number 6
c      CALL IOVXXX(W(1,4),W(1,3),W(1,7),GZN,AMP(6))
      call wwza_anomal4(W(1,1),W(1,7),W(1,2),W(1,5),AMP(6))
      
c     new Higgs contributions
      call jhww_anomal3(W(1,1),W(1,2),W(1,6))
      call azh_anomal3(W(1,5),W(1,7),W(1,6),amp(7))

      WW(MU,NU)=-AMP(1)-AMP(2)-AMP(3)-AMP(4)-AMP(5)-AMP(6)-amp(7)

        ENDDO
      ENDDO

      END
      
      
c ------------------------------------------------------------
c ------------------------------------------------------------

      subroutine vvtoza_anomal(q1,q2,P,h,aa,az,za,zz)
	
      IMPLICIT NONE

      REAL*8 Q1(0:3), Q2(0:3), P(0:3,3:6)
      complex*16 aa(0:3,0:3)
      complex*16 az(0:3,0:3)
      complex*16 za(0:3,0:3)

      complex*16 zz(0:3,0:3)
      integer lsign(3:6,4),h,ll

	! possible lepton helicities:
	data (lsign(ll,1),ll=3,6) / -1, -1, -1, -1/
	data (lsign(ll,2),ll=3,6) / -1, -1,  1,  1/
	data (lsign(ll,3),ll=3,6) /  1,  1, -1, -1/
	data (lsign(ll,4),ll=3,6) /  1,  1,  1,  1/
	
	call AAtoZA1_anomal(q1,q2,P,lsign(3,h),aa(0,0))
	call AZtoZA1_anomal(q1,q2,P,lsign(3,h),az(0,0))
	call AZtoZA1_anomal(q2,q1,P,lsign(3,h),za(0,0))
	call ZZtoZA1_anomal(q1,q2,P,lsign(3,h),zz(0,0))
		
	end
		
c ------------------------------------------------------------

      subroutine AAtoZA1_anomal(q1,q2,P,lsign,aa)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.1.2, 2014-07-03
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     
C     Process: a a > e+ e- a QCD=0 
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=14)
      INTEGER    NWAVEFUNCS
      PARAMETER (NWAVEFUNCS=9)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,3:6)
      REAL*8 Q1(0:3),Q2(0:3)
      INTEGER lsign(3:6)
      COMPLEX*16 aa(0:3,0:3)
C     
C     LOCAL VARIABLES 
C    
      INTEGER I,MU,NU
      COMPLEX*16 AMP(NGRAPHS)
      COMPLEX*16 W(6,NWAVEFUNCS)
C     
C     GLOBAL VARIABLES
C     
#include "tensorz.inc"
#include "VBFNLO/utilities/coupl.inc"

      logical lswitch
      parameter (lswitch=.true.)  

C     ----------
C     BEGIN CODE
C     ----------
      
      DO MU = 0,3
        DO NU = 0,3

       if (lswitch) then
         do i = 1,6
	   w(i,3) = lep(i) 
	   w(i,4) = lem(i)
	   w(i,5) = ea(i)  
      	 enddo
       else
c incoming
c        CALL VXXXXX(P(0,1),ZERO,NHEL(1),-1*IC(1),W(1,1))
c        CALL VXXXXX(P(0,2),ZERO,NHEL(2),-1*IC(2),W(1,2))
c outgoing
c        CALL IXXXXX(P(0,3),ZERO,NHEL(3),-1*IC(3),W(1,3))
c        CALL OXXXXX(P(0,4),ZERO,NHEL(4),+1*IC(4),W(1,4))
c        CALL VXXXXX(P(0,5),ZERO,NHEL(5),+1*IC(5),W(1,5))
      endif

      CALL VCARTX(Q1(0),ZERO,AWIDTH, MU,-1,W(1,1))        
      CALL VCARTX(Q2(0),ZERO,AWIDTH, NU,-1,W(1,2))

      CALL FVIXXX(W(1,3),W(1,1),GAL,ZERO,ZERO,W(1,6))
      CALL FVOXXX(W(1,4),W(1,2),GAL,ZERO,ZERO,W(1,7))
      
C     Amplitude(s) for diagram number 1
      CALL IOVXXX(W(1,6),W(1,7),W(1,5),GAL,AMP(1))
      CALL FVOXXX(W(1,4),W(1,5),GAL,ZERO,ZERO,W(1,8))
C     Amplitude(s) for diagram number 2
      CALL IOVXXX(W(1,6),W(1,8),W(1,2),GAL,AMP(2))
      CALL FVOXXX(W(1,4),W(1,1),GAL,ZERO,ZERO,W(1,6))
      CALL FVIXXX(W(1,3),W(1,2),GAL,ZERO,ZERO,W(1,4))
C     Amplitude(s) for diagram number 3
      CALL IOVXXX(W(1,4),W(1,6),W(1,5),GAL,AMP(3))
      CALL FVIXXX(W(1,3),W(1,5),GAL,ZERO,ZERO,W(1,9))
C     Amplitude(s) for diagram number 4
      CALL IOVXXX(W(1,9),W(1,6),W(1,2),GAL,AMP(4))
C     Amplitude(s) for diagram number 5
      CALL IOVXXX(W(1,4),W(1,8),W(1,1),GAL,AMP(5))
C     Amplitude(s) for diagram number 6
      CALL IOVXXX(W(1,9),W(1,7),W(1,1),GAL,AMP(6))
      
      CALL JIOXXX(lep(1),lem(1),GAL,0d0,0d0,W(1,7))
      call aaaa_anomal4(W(1,1),W(1,2),W(1,5),W(1,7),amp(7))
      
      CALL JIOXXX(lep(1),lem(1),GZL,ZMASS,ZWIDTH,W(1,8))
      call aaaz_anomal4(W(1,1),W(1,2),W(1,5),W(1,8),amp(8))
      
c     new Higgs contributions
      call jhaa_anomal3(W(1,1),W(1,2),W(1,9))
      call aah_anomal3(W(1,5),W(1,7),W(1,9),amp(9))
      call azh_anomal3(W(1,5),W(1,8),W(1,9),amp(10))
      
      call jhaa_anomal3(W(1,1),W(1,5),W(1,9))
      call aah_anomal3(W(1,2),W(1,7),W(1,9),amp(11))
      call azh_anomal3(W(1,2),W(1,8),W(1,9),amp(12))
      
      call jhaa_anomal3(W(1,2),W(1,5),W(1,9))
      call aah_anomal3(W(1,1),W(1,7),W(1,9),amp(13))
      call azh_anomal3(W(1,1),W(1,8),W(1,9),amp(14))
      
      aa(MU,NU)=+AMP(1)+AMP(2)+AMP(3)+AMP(4)+AMP(5)+AMP(6)+amp(7)+amp(8)
     $          +amp(9)+amp(10)+amp(11)+amp(12)+amp(13)+amp(14)

        ENDDO
      ENDDO

      END


      subroutine AZtoZA1_anomal(q1,q2,P,lsign,az)
C   
C     Generated by MadGraph5_aMC@NLO v. 2.1.2, 2014-07-03
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C
C     Process: a z > e+ e- a QCD=0    
C
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=14)
      INTEGER    NWAVEFUNCS
      PARAMETER (NWAVEFUNCS=9)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,3:6)
      REAL*8 Q1(0:3),Q2(0:3)
      INTEGER lsign(3:6)
      COMPLEX*16 az(0:3,0:3)
C     
C     LOCAL VARIABLES 
C     
      INTEGER I,MU,NU
      COMPLEX*16 AMP(NGRAPHS)
      COMPLEX*16 W(6,NWAVEFUNCS)
C     
C     GLOBAL VARIABLES
C     
#include "tensorz.inc" 
#include "VBFNLO/utilities/coupl.inc"

      logical lswitch
      parameter (lswitch=.true.)  

C     ----------
C     BEGIN CODE
C     ----------

      DO MU = 0,3
        DO NU = 0,3

C     ----------
C     BEGIN CODE
C     ----------
c      CALL VXXXXX(P(0,1),ZERO,NHEL(1),-1*IC(1),W(1,1))
c      CALL VXXXXX(P(0,2),ZMASS,NHEL(2),-1*IC(2),W(1,2))
c      CALL IXXXXX(P(0,3),ZERO,NHEL(3),-1*IC(3),W(1,3))
c      CALL OXXXXX(P(0,4),ZERO,NHEL(4),+1*IC(4),W(1,4))
c      CALL VXXXXX(P(0,5),ZERO,NHEL(5),+1*IC(5),W(1,5))

      if (lswitch) then
        do i = 1,6
	 w(i,3) = lep(i) 
	 w(i,4) = lem(i)
	 w(i,5) = ea(i)
      	enddo
      else
      endif

      CALL VCARTX(Q1(0),zero  ,zero, MU,-1,W(1,1   ))        
      CALL VCARTX(Q2(0),zMASS ,zwidth, NU,-1,W(1,2   )) 
 

      CALL FVIXXX(W(1,3),W(1,1),GAL,ZERO,ZERO,W(1,6))
      CALL FVOXXX(W(1,4),W(1,2),GZL,ZERO,ZERO,W(1,7))

C     Amplitude(s) for diagram number 1
      CALL IOVXXX(W(1,6),W(1,7),W(1,5),GAL,AMP(1))
      CALL FVOXXX(W(1,4),W(1,5),GAL,ZERO,ZERO,W(1,8))
C     Amplitude(s) for diagram number 2
      CALL IOVXXX(W(1,6),W(1,8),W(1,2),GZL,AMP(2))
      CALL FVOXXX(W(1,4),W(1,1),GAL,ZERO,ZERO,W(1,6))
      CALL FVIXXX(W(1,3),W(1,2),GZL,ZERO,ZERO,W(1,4))
C     Amplitude(s) for diagram number 3
      CALL IOVXXX(W(1,4),W(1,6),W(1,5),GAL,AMP(3))
      CALL FVIXXX(W(1,3),W(1,5),GAL,ZERO,ZERO,W(1,9))
C     Amplitude(s) for diagram number 4
      CALL IOVXXX(W(1,9),W(1,6),W(1,2),GZL,AMP(4))
C     Amplitude(s) for diagram number 5
      CALL IOVXXX(W(1,4),W(1,8),W(1,1),GAL,AMP(5))
C     Amplitude(s) for diagram number 6
      CALL IOVXXX(W(1,9),W(1,7),W(1,1),GAL,AMP(6))
      
      CALL JIOXXX(lep(1),lem(1),GAL,0d0,0d0,W(1,7))
      call aaaz_anomal4(W(1,1),W(1,5),W(1,7),W(1,2),amp(7))
      
      CALL JIOXXX(lep(1),lem(1),GZL,ZMASS,ZWIDTH,W(1,8))
      call aazz_anomal4(W(1,1),W(1,5),W(1,8),W(1,2),amp(8))
      
c     new Higgs contributions
      call jhaz_anomal3(W(1,1),W(1,2),W(1,9))
      call aah_anomal3(W(1,5),W(1,7),W(1,9),amp(9))
      call azh_anomal3(W(1,5),W(1,8),W(1,9),amp(10))
      
      call jhaa_anomal3(W(1,1),W(1,5),W(1,9))
      call azh_anomal3(W(1,7),W(1,2),W(1,9),amp(11))
      call zzh_anomal3(W(1,2),W(1,8),W(1,9),amp(12))
      
      call jhaz_anomal3(W(1,5),W(1,2),W(1,9))
      call aah_anomal3(W(1,1),W(1,7),W(1,9),amp(13))
      call azh_anomal3(W(1,1),W(1,8),W(1,9),amp(14))
      
      az(MU,NU)=+AMP(1)+AMP(2)+AMP(3)+AMP(4)+AMP(5)+AMP(6)+amp(7)+amp(8)
     $          +amp(9)+amp(10)+amp(11)+amp(12)+amp(13)+amp(14)
      

       enddo
       enddo
       end


c ------------------------------------------------------------

      subroutine ZZtoZA1_anomal(q1,q2,P,lsign,zz)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.1.2, 2014-07-03
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     
C     Process: z z > e+ e- a QCD=0
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=14)
      INTEGER    NWAVEFUNCS
      PARAMETER (NWAVEFUNCS=9)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,3:6)
      REAL*8 Q1(0:3),Q2(0:3)
      INTEGER lsign(3:6)
      COMPLEX*16 zz(0:3,0:3)
C     
C     LOCAL VARIABLES 
C     
      INTEGER I,MU,NU
      COMPLEX*16 AMP(NGRAPHS)
      COMPLEX*16 W(6,NWAVEFUNCS)
C     
C     GLOBAL VARIABLES
C     
#include "tensorz.inc"
#include "VBFNLO/utilities/coupl.inc"

      logical lswitch
      parameter (lswitch=.true.)  

C     ----------
C     BEGIN CODE
C     ----------

      DO MU = 0,3
        DO NU = 0,3

      if (lswitch) then
        do i = 1,6
	 w(i,3) = lep(i) 
	 w(i,4) = lem(i)
	 w(i,5) = ea(i)
      	enddo
      else
c incoming
c        CALL VXXXXX(P(0,1),ZMASS,NHEL(1),-1*IC(1),W(1,1))
c        CALL VXXXXX(P(0,2),ZMASS,NHEL(2),-1*IC(2),W(1,2))
c outgoing
c        CALL IXXXXX(P(0,3),ZERO,NHEL(3),-1*IC(3),W(1,3))
c        CALL OXXXXX(P(0,4),ZERO,NHEL(4),+1*IC(4),W(1,4))
c        CALL VXXXXX(P(0,5),ZERO,NHEL(5),+1*IC(5),W(1,5))
      endif

      CALL VCARTX(Q1(0),ZMASS,ZWIDTH, MU,-1,W(1,1))        
      CALL VCARTX(Q2(0),ZMASS,ZWIDTH, NU,-1,W(1,2))

      CALL FVIXXX(W(1,3),W(1,1),GZL,ZERO,ZERO,W(1,6))
      CALL FVOXXX(W(1,4),W(1,2),GZL,ZERO,ZERO,W(1,7))
C     Amplitude(s) for diagram number 1
      CALL IOVXXX(W(1,6),W(1,7),W(1,5),GAL,AMP(1))
      CALL FVOXXX(W(1,4),W(1,5),GAL,ZERO,ZERO,W(1,8))
C     Amplitude(s) for diagram number 2
      CALL IOVXXX(W(1,6),W(1,8),W(1,2),GZL,AMP(2))
      CALL FVOXXX(W(1,4),W(1,1),GZL,ZERO,ZERO,W(1,6))
      CALL FVIXXX(W(1,3),W(1,2),GZL,ZERO,ZERO,W(1,4))
C     Amplitude(s) for diagram number 3
      CALL IOVXXX(W(1,4),W(1,6),W(1,5),GAL,AMP(3))
      CALL FVIXXX(W(1,3),W(1,5),GAL,ZERO,ZERO,W(1,9))
C     Amplitude(s) for diagram number 4
      CALL IOVXXX(W(1,9),W(1,6),W(1,2),GZL,AMP(4))
C     Amplitude(s) for diagram number 5
      CALL IOVXXX(W(1,4),W(1,8),W(1,1),GZL,AMP(5))
C     Amplitude(s) for diagram number 6
      CALL IOVXXX(W(1,9),W(1,7),W(1,1),GZL,AMP(6))

      CALL JIOXXX(lep(1),lem(1),GAL,0d0,0d0,W(1,7))
      call aazz_anomal4(W(1,7),W(1,5),W(1,1),W(1,2),amp(7))
      
      CALL JIOXXX(lep(1),lem(1),GZL,ZMASS,ZWIDTH,W(1,8))
      call azzz_anomal4(W(1,5),W(1,1),W(1,8),W(1,2),amp(8))
      
c     new Higgs contributions
      call jhzz_anomal3(W(1,1),W(1,2),W(1,9))
      call aah_anomal3(W(1,5),W(1,7),W(1,9),amp(9))
      call azh_anomal3(W(1,5),W(1,8),W(1,9),amp(10))
      
      call jhaz_anomal3(W(1,5),W(1,1),W(1,9))
      call azh_anomal3(W(1,7),W(1,2),W(1,9),amp(11))
      call zzh_anomal3(W(1,2),W(1,8),W(1,9),amp(12))
      
      call jhaz_anomal3(W(1,5),W(1,2),W(1,9))
      call azh_anomal3(W(1,7),W(1,1),W(1,9),amp(13))
      call zzh_anomal3(W(1,1),W(1,8),W(1,9),amp(14))
      
      zz(MU,NU)=+AMP(1)+AMP(2)+AMP(3)+AMP(4)+AMP(5)+AMP(6)+amp(7)+amp(8)
     $          +amp(9)+amp(10)+amp(11)+amp(12)+amp(13)+amp(14)


        ENDDO
      ENDDO

      END


c ------------------------------------------------------------
c ------------------------------------------------------------

      subroutine vvtozaN_anomal(q1,q2,P,h,aa,az,za,zz)
	
      IMPLICIT NONE

      REAL*8 Q1(0:3), Q2(0:3), P(0:3,3:6)
      complex*16 aa(0:3,0:3)
      complex*16 az(0:3,0:3)
      complex*16 za(0:3,0:3)

      complex*16 zz(0:3,0:3)
      integer lsign(3:6,4),h,ll

	! possible lepton helicities:
	data (lsign(ll,1),ll=3,6) / -1, -1, -1, -1/
	data (lsign(ll,2),ll=3,6) / -1, -1,  1,  1/
	data (lsign(ll,3),ll=3,6) /  1,  1, -1, -1/
	data (lsign(ll,4),ll=3,6) /  1,  1,  1,  1/
	
	call AAtoZAn_anomal(q1,q2,P,lsign(3,h),aa(0,0))
	call AZtoZAn_anomal(q1,q2,P,lsign(3,h),az(0,0))
	call AZtoZAn_anomal(q2,q1,P,lsign(3,h),za(0,0))
	call ZZtoZAn_anomal(q1,q2,P,lsign(3,h),zz(0,0))
		
	end
		
c ------------------------------------------------------------

      subroutine AAtoZAn_anomal(q1,q2,P,lsign,aa)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.1.2, 2014-07-03
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     
C     Process: a a > e+ e- a QCD=0 
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=4)
      INTEGER    NWAVEFUNCS
      PARAMETER (NWAVEFUNCS=7)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,3:6)
      REAL*8 Q1(0:3),Q2(0:3)
      INTEGER lsign(3:6)
      COMPLEX*16 aa(0:3,0:3)
C     
C     LOCAL VARIABLES 
C    
      INTEGER I,MU,NU
      COMPLEX*16 AMP(NGRAPHS)
      COMPLEX*16 W(6,NWAVEFUNCS)
C     
C     GLOBAL VARIABLES
C     
#include "tensorz.inc"
#include "VBFNLO/utilities/coupl.inc"

      logical lswitch
      parameter (lswitch=.true.)  

C     ----------
C     BEGIN CODE
C     ----------
      
       if (lswitch) then
         do i = 1,6
	   w(i,3) = lum(i) 
	   w(i,4) = lup(i)
	   w(i,5) = ea(i)  
      	 enddo
       else
       
      endif
      
      DO MU = 0,3
        DO NU = 0,3


      CALL VCARTX(Q1(0),ZERO,AWIDTH, MU,-1,W(1,1))        
      CALL VCARTX(Q2(0),ZERO,AWIDTH, NU,-1,W(1,2))
            
      CALL JIOXXX(W(1,4),W(1,3),GZN,ZMASS,ZWIDTH,W(1,6))
      call aaaz_anomal4(W(1,1),W(1,2),W(1,5),W(1,6),amp(1))
      
c     Higgs contributions
      call jhaa_anomal3(W(1,1),W(1,2),W(1,7))
      call azh_anomal3(W(1,5),W(1,6),W(1,7),amp(2))
      
      call jhaa_anomal3(W(1,1),W(1,5),W(1,7))
      call azh_anomal3(W(1,2),W(1,6),W(1,7),amp(3))
      
      call jhaa_anomal3(W(1,2),W(1,5),W(1,7))
      call azh_anomal3(W(1,1),W(1,6),W(1,7),amp(4))
      
      aa(MU,NU)=-amp(1)-amp(2)-amp(3)-amp(4)

        ENDDO
      ENDDO

      END


      subroutine AZtoZAn_anomal(q1,q2,P,lsign,az)
C   
C     Generated by MadGraph5_aMC@NLO v. 2.1.2, 2014-07-03
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C
C     Process: a z > e+ e- a QCD=0    
C
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=4)
      INTEGER    NWAVEFUNCS
      PARAMETER (NWAVEFUNCS=7)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,3:6)
      REAL*8 Q1(0:3),Q2(0:3)
      INTEGER lsign(3:6)
      COMPLEX*16 az(0:3,0:3)
C     
C     LOCAL VARIABLES 
C     
      INTEGER I,MU,NU
      COMPLEX*16 AMP(NGRAPHS)
      COMPLEX*16 W(6,NWAVEFUNCS)
C     
C     GLOBAL VARIABLES
C     
#include "tensorz.inc" 
#include "VBFNLO/utilities/coupl.inc"

      logical lswitch
      parameter (lswitch=.true.)  

C     ----------
C     BEGIN CODE
C     ----------

      if (lswitch) then
        do i = 1,6
	   w(i,3) = lum(i) 
	   w(i,4) = lup(i)
	   w(i,5) = ea(i)  
      	enddo
      else
      endif

      DO MU = 0,3
        DO NU = 0,3

      CALL VCARTX(Q1(0),zero  ,zero, MU,-1,W(1,1   ))        
      CALL VCARTX(Q2(0),zMASS ,zwidth, NU,-1,W(1,2   )) 
       
      CALL JIOXXX(W(1,4),W(1,3),GZN,ZMASS,ZWIDTH,W(1,6))
      call aazz_anomal4(W(1,1),W(1,5),W(1,6),W(1,2),amp(1))
      
c     Higgs contributions
      call jhaz_anomal3(W(1,1),W(1,2),W(1,7))
      call azh_anomal3(W(1,5),W(1,6),W(1,7),amp(2))
      
      call jhaa_anomal3(W(1,1),W(1,5),W(1,7))
      call zzh_anomal3(W(1,2),W(1,6),W(1,7),amp(3))
      
      call jhaz_anomal3(W(1,5),W(1,2),W(1,7))
      call azh_anomal3(W(1,1),W(1,6),W(1,7),amp(4))
      
      az(MU,NU)=-AMP(1)-amp(2)-amp(3)-amp(4)

       enddo
       enddo
       end


c ------------------------------------------------------------

      subroutine ZZtoZAn_anomal(q1,q2,P,lsign,zz)
C     
C     Generated by MadGraph5_aMC@NLO v. 2.1.2, 2014-07-03
C     By the MadGraph5_aMC@NLO Development Team
C     Visit launchpad.net/madgraph5 and amcatnlo.web.cern.ch
C     
C     Process: z z > e+ e- a QCD=0
C     
      IMPLICIT NONE
C     
C     CONSTANTS
C     
      INTEGER    NGRAPHS
      PARAMETER (NGRAPHS=4)
      INTEGER    NWAVEFUNCS
      PARAMETER (NWAVEFUNCS=7)
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
C     
C     ARGUMENTS 
C     
      REAL*8 P(0:3,3:6)
      REAL*8 Q1(0:3),Q2(0:3)
      INTEGER lsign(3:6)
      COMPLEX*16 zz(0:3,0:3)
C     
C     LOCAL VARIABLES 
C     
      INTEGER I,MU,NU
      COMPLEX*16 AMP(NGRAPHS)
      COMPLEX*16 W(6,NWAVEFUNCS)
C     
C     GLOBAL VARIABLES
C     
#include "tensorz.inc"
#include "VBFNLO/utilities/coupl.inc"

      logical lswitch
      parameter (lswitch=.true.)  

C     ----------
C     BEGIN CODE
C     ----------

      if (lswitch) then
        do i = 1,6
	   w(i,3) = lum(i) 
	   w(i,4) = lup(i)
	   w(i,5) = ea(i)  
      	enddo
      else
      endif
      
      DO MU = 0,3
        DO NU = 0,3

      CALL VCARTX(Q1(0),ZMASS,ZWIDTH, MU,-1,W(1,1))        
      CALL VCARTX(Q2(0),ZMASS,ZWIDTH, NU,-1,W(1,2))

      CALL JIOXXX(W(1,4),W(1,3),GZN,ZMASS,ZWIDTH,W(1,6))
      call azzz_anomal4(W(1,5),W(1,1),W(1,6),W(1,2),amp(1))
      
c     Higgs contributions
      call jhzz_anomal3(W(1,1),W(1,2),W(1,7))
      call azh_anomal3(W(1,5),W(1,6),W(1,7),amp(2))
      
      call jhaz_anomal3(W(1,5),W(1,1),W(1,7))
      call zzh_anomal3(W(1,2),W(1,6),W(1,7),amp(3))
      
      call jhaz_anomal3(W(1,5),W(1,2),W(1,7))
      call zzh_anomal3(W(1,1),W(1,6),W(1,7),amp(4))
      
      
      zz(MU,NU)=-AMP(1)-amp(2)-amp(3)-amp(4)

        ENDDO
      ENDDO

      END

