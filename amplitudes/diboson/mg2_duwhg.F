      SUBROUTINE SDU_WMHGL(PBAR,fsign,ANS)
C  
C Generated by MadGraph II                                              
C RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C AND HELICITIES
C FOR THE POINT IN PHASE SPACE P(0:3,NEXTERNAL)
C  
C FOR PROCESS : u~ d -> ve~ e- h g  
C  
C Crossing   1 is u~ d -> ve~ e- h g  
      IMPLICIT NONE
C  
C CONSTANTS
C  
#include "VBFNLO/utilities/global.inc"
#include "tensor.inc"
!      Include "genps.inc"
      integer    max_particles  , max_branch
      parameter (max_particles=10, max_branch=max_particles-2)
!      Include "nexternal.inc"
      integer    nexternal
      parameter (nexternal=  6)
      integer    nincoming
      parameter (nincoming=  2)
!      Include "maxamps.inc"
      integer    maxamps, maxflow
      parameter (maxamps=    2,maxflow=   1)
      INTEGER                 NCOMB,     NCROSS         
      PARAMETER (             NCOMB=  32, NCROSS=  1)
      INTEGER    THEL
      PARAMETER (THEL=NCOMB*NCROSS)
C  
C ARGUMENTS 
C  
      REAL*8 PBAR(0:3,NEXTERNAL),ANS(NCROSS)
      integer fsign(6)
C  
C LOCAL VARIABLES 
C  
      INTEGER NHEL(NEXTERNAL,NCOMB),NTRY
      REAL*8 T !, P(0:3,NEXTERNAL)
      REAL*8 DUWMHgL
      INTEGER IHEL,IDEN(NCROSS)!,IC(NEXTERNAL,NCROSS)
      INTEGER IPROC, I !,JC(NEXTERNAL), I
      LOGICAL GOODHEL(NCOMB,NCROSS)
      INTEGER NGRAPHS
      REAL*8 hwgt, xtot, xtry, xrej, xr, yfrac(0:ncomb)
      INTEGER idum, ngood, igood(ncomb), jhel, j, jj
      LOGICAL warned
      REAL     xran1
      EXTERNAL xran1
C  
C GLOBAL VARIABLES
C  
      Double Precision amp2(maxamps), jamp2(0:maxflow)
      common/to_amps170j/  amp2,       jamp2

      character*79         hel_buff
      common/to_helicity/  hel_buff

      REAL*8 POL(2)
      common/to_polarization/ POL

      integer          isum_hel
      logical                    multi_channel
      common/to_matrix170j/isum_hel, multi_channel
      INTEGER MAPCONFIG(0:100), ICONFIG
      common/to_mconfigs/mapconfig, iconfig
      DATA NTRY,IDUM /0,-1/
      DATA xtry, xrej, ngood /0,0,0/
!       DATA warned, isum_hel/.false.,0/
      DATA warned /.false./
!       DATA multi_channel/.true./
      SAVE yfrac, igood, jhel
      DATA NGRAPHS /    2/          
      DATA jamp2(0) /   1/          
      DATA GOODHEL/THEL*.FALSE./
      DATA (NHEL(IHEL,   1),IHEL=1, 6) /-1,-1,-1,-1,-1,-1/
      DATA (NHEL(IHEL,   2),IHEL=1, 6) /-1,-1,-1,-1,-1, 1/
      DATA (NHEL(IHEL,   3),IHEL=1, 6) /-1,-1,-1, 1,-1,-1/
      DATA (NHEL(IHEL,   4),IHEL=1, 6) /-1,-1,-1, 1,-1, 1/
      DATA (NHEL(IHEL,   5),IHEL=1, 6) /-1,-1, 1,-1,-1,-1/
      DATA (NHEL(IHEL,   6),IHEL=1, 6) /-1,-1, 1,-1,-1, 1/
      DATA (NHEL(IHEL,   7),IHEL=1, 6) /-1,-1, 1, 1,-1,-1/
      DATA (NHEL(IHEL,   8),IHEL=1, 6) /-1,-1, 1, 1,-1, 1/
      DATA (NHEL(IHEL,   9),IHEL=1, 6) /-1, 1,-1,-1,-1,-1/
      DATA (NHEL(IHEL,  10),IHEL=1, 6) /-1, 1,-1,-1,-1, 1/
      DATA (NHEL(IHEL,  11),IHEL=1, 6) /-1, 1,-1, 1,-1,-1/
      DATA (NHEL(IHEL,  12),IHEL=1, 6) /-1, 1,-1, 1,-1, 1/
      DATA (NHEL(IHEL,  13),IHEL=1, 6) /-1, 1, 1,-1,-1,-1/
      DATA (NHEL(IHEL,  14),IHEL=1, 6) /-1, 1, 1,-1,-1, 1/
      DATA (NHEL(IHEL,  15),IHEL=1, 6) /-1, 1, 1, 1,-1,-1/
      DATA (NHEL(IHEL,  16),IHEL=1, 6) /-1, 1, 1, 1,-1, 1/
      DATA (NHEL(IHEL,  17),IHEL=1, 6) / 1,-1,-1,-1,-1,-1/
      DATA (NHEL(IHEL,  18),IHEL=1, 6) / 1,-1,-1,-1,-1, 1/
      DATA (NHEL(IHEL,  19),IHEL=1, 6) / 1,-1,-1, 1,-1,-1/
      DATA (NHEL(IHEL,  20),IHEL=1, 6) / 1,-1,-1, 1,-1, 1/
      DATA (NHEL(IHEL,  21),IHEL=1, 6) / 1,-1, 1,-1,-1,-1/
      DATA (NHEL(IHEL,  22),IHEL=1, 6) / 1,-1, 1,-1,-1, 1/
      DATA (NHEL(IHEL,  23),IHEL=1, 6) / 1,-1, 1, 1,-1,-1/
      DATA (NHEL(IHEL,  24),IHEL=1, 6) / 1,-1, 1, 1,-1, 1/
      DATA (NHEL(IHEL,  25),IHEL=1, 6) / 1, 1,-1,-1,-1,-1/
      DATA (NHEL(IHEL,  26),IHEL=1, 6) / 1, 1,-1,-1,-1, 1/
      DATA (NHEL(IHEL,  27),IHEL=1, 6) / 1, 1,-1, 1,-1,-1/
      DATA (NHEL(IHEL,  28),IHEL=1, 6) / 1, 1,-1, 1,-1, 1/
      DATA (NHEL(IHEL,  29),IHEL=1, 6) / 1, 1, 1,-1,-1,-1/
      DATA (NHEL(IHEL,  30),IHEL=1, 6) / 1, 1, 1,-1,-1, 1/
      DATA (NHEL(IHEL,  31),IHEL=1, 6) / 1, 1, 1, 1,-1,-1/
      DATA (NHEL(IHEL,  32),IHEL=1, 6) / 1, 1, 1, 1,-1, 1/
c      DATA (  IC(IHEL,  1),IHEL=1, 6) / 1, 2, 3, 4, 5, 6/
c original      DATA (IDEN(IHEL),IHEL=  1,  1) /  36/
      DATA (IDEN(IHEL),IHEL=  1,  1) /  1/
C ----------
C BEGIN CODE
C ----------
      iproc = 1
      NTRY=NTRY+1
!     DO IPROC=1,NCROSS
!     CALL SWITCHMOM(P1,P,IC(1,IPROC),JC,NEXTERNAL)
!     DO IHEL=1,NEXTERNAL
!        JC(IHEL) = +1
!     ENDDO
!      
!     IF (multi_channel) THEN
!         DO IHEL=1,NGRAPHS
!             amp2(ihel)=0d0
!         ENDDO
!         DO IHEL=1,int(jamp2(0))
!             jamp2(ihel)=0d0
!         ENDDO
!     ENDIF
      ANS(IPROC) = 0D0
      write(hel_buff,'(16i5)') (0,i=1,nexternal)
      IF (ISUM_HEL .EQ. 0 .OR. NTRY .LT. 10) THEN
          DO IHEL=1,NCOMB
             IF (GOODHEL(IHEL,IPROC) .OR. NTRY .LT. 2) THEN
                 T=DUWMHgL(PBAR ,NHEL(1,IHEL),FSIGN(1))            
!              DO JJ=1,nincoming
!                IF(POL(JJ).NE.1d0.AND.
!    &              NHEL(JJ,IHEL).EQ.INT(SIGN(1d0,POL(JJ)))) THEN
!                  T=T*ABS(POL(JJ))
!                ELSE IF(POL(JJ).NE.1d0)THEN
!                  T=T*(2d0-ABS(POL(JJ)))
!                ENDIF
!              ENDDO
               ANS(IPROC)=ANS(IPROC)+T
               IF (T .NE. 0D0 .AND. .NOT.    GOODHEL(IHEL,IPROC)) THEN
                   GOODHEL(IHEL,IPROC)=.TRUE.
                   NGOOD = NGOOD +1
                   IGOOD(NGOOD) = IHEL
               ENDIF
             ENDIF
          ENDDO
          JHEL = 1
          ISUM_HEL=MIN(ISUM_HEL,NGOOD)
      ELSE              !RANDOM HELICITY
          DO J=1,ISUM_HEL
              JHEL=JHEL+1
              IF (JHEL .GT. NGOOD) JHEL=1
              HWGT = REAL(NGOOD)/REAL(ISUM_HEL)
              IHEL = IGOOD(JHEL)
              T=DUWMHgL(PBAR ,NHEL(1,IHEL),fsign(1))            


!             DO JJ=1,nincoming
!               IF(POL(JJ).NE.1d0.AND.
!    &             NHEL(JJ,IHEL).EQ.INT(SIGN(1d0,POL(JJ)))) THEN
!                 T=T*ABS(POL(JJ))
!               ELSE IF(POL(JJ).NE.1d0)THEN
!                 T=T*(2d0-ABS(POL(JJ)))
!               ENDIF
!             ENDDO
              ANS(IPROC)=ANS(IPROC)+T*HWGT
          ENDDO
          IF (ISUM_HEL .EQ. 1) THEN
              WRITE(HEL_BUFF,'(16i5)')(NHEL(i,IHEL),i=1,nexternal)
          ENDIF
      ENDIF
      IF (MULTI_CHANNEL) THEN
          XTOT=0D0
          DO IHEL=1,MAPCONFIG(0)
              XTOT=XTOT+AMP2(MAPCONFIG(IHEL))
          ENDDO
c          IF (XTOT.NE.0D0) THEN
c              ANS(IPROC)=ANS(IPROC)*AMP2(MAPCONFIG(ICONFIG))/XTOT
c          ELSE
              ANS(IPROC)=0D0
c          ENDIF
      ENDIF
      ANS(IPROC)=ANS(IPROC)/DBLE(IDEN(IPROC))
!       ENDDO
      END
       
       
      REAL*8 FUNCTION DUWMHgL(PBAR,NHEL,FSIGN)
C  
C Generated by MadGraph II                                              
C RETURNS AMPLITUDE SQUARED SUMMED/AVG OVER COLORS
C FOR THE POINT WITH EXTERNAL LINES W(0:6,NEXTERNAL)
C  
C FOR PROCESS : u~ d -> ve~ e- h g  
C  
      IMPLICIT NONE
C  
C CONSTANTS
C  
      INTEGER    NGRAPHS,    NEIGEN 
      PARAMETER (NGRAPHS=   2,NEIGEN=  1) 
#include "VBFNLO/utilities/global.inc"
#include "tensor.inc"
!       include "genps.inc"
      integer    max_particles  , max_branch
      parameter (max_particles=10, max_branch=max_particles-2)
!      Include "nexternal.inc"
      integer    nexternal
      parameter (nexternal=  6)
      integer    nincoming
      parameter (nincoming=  2)
!      Include "maxamps.inc"
      integer    maxamps, maxflow
      parameter (maxamps=    2,maxflow=   1)
      INTEGER    NWAVEFUNCS     , NCOLOR
      PARAMETER (NWAVEFUNCS=  10, NCOLOR=   1) 
      REAL*8     ZERO
      PARAMETER (ZERO=0D0)
C  
C ARGUMENTS 
C  
      REAL*8 PBAR(0:3,NEXTERNAL)
      INTEGER NHEL(NEXTERNAL), fsign(NEXTERNAL)
C  
C LOCAL VARIABLES 
C  
      INTEGER I,J
      COMPLEX*16 ZTEMP
      REAL*8 DENOM(NCOLOR), CF(NCOLOR,NCOLOR)
      COMPLEX*16 AMP(NGRAPHS), JAMP(NCOLOR)
      COMPLEX*16 W(18,NWAVEFUNCS)
C  
C GLOBAL VARIABLES
C  
      Double Precision amp2(maxamps), jamp2(0:maxflow)
      common/to_amps170j/  amp2,       jamp2
!       include "coupl.inc"
#include "VBFNLO/utilities/coupl.inc"

      integer h
      common /hcount / h
C  
C COLOR DATA
C  
      DATA Denom(1  )/            1/                                       
      DATA (CF(i,1  ),i=1  ,1  ) /     4/                                  
C               T[ 2, 1, 6]                                                

c for debugging purposes
      real*8 momsum(0:3)
      double precision dotrr
      external dotrr

C ----------
C BEGIN CODE
C ----------
      ! pbar: 1,2 quarks, 3 ve, 4 e, 5 h, 6 g
      CALL IXXXXX(PBAR(0,1   ),ZERO ,NHEL(1   )*Fsign(1),FSIGN(1   ),W(1,1   ))        
      CALL OXXXXX(PBAR(0,2   ),ZERO ,NHEL(2   )*Fsign(2),FSIGN(2   ),W(1,2   ))        
      CALL OXXXXX(PBAR(0,3   ),ZERO ,NHEL(3   )*Fsign(3),FSIGN(3   ),W(1,3   ))        
      CALL IXXXXX(PBAR(0,4   ),ZERO ,NHEL(4   )*Fsign(4),FSIGN(4   ),W(1,4   ))        
      CALL SXXXXX(PBAR(0,5   ),+1*FSIGN(5   ),W(1,5   ))                         
      CALL VXXXXX(PBAR(0,6   ),ZERO ,NHEL(6   )*Fsign(6),FSIGN(6   ),W(1,6   ))        
      CALL JIOXXX(W(1,4   ),W(1,3   ),GWF ,WMASS   ,WWIDTH  ,W(1,7   ))    
      CALL JVSXXX(W(1,7   ),W(1,5   ),GWWH ,WMASS   ,WWIDTH  ,W(1,         
     &     8   ))                                                          
      CALL FVOXXX(W(1,2   ),W(1,8   ),GWF ,ZERO    ,ZERO    ,W(1,9   ))    
      CALL IOVXXX(W(1,1   ),W(1,9   ),W(1,6   ),GG ,AMP(1   ))             
      CALL FVIXXX(W(1,1   ),W(1,8   ),GWF ,ZERO    ,ZERO    ,W(1,10  ))    
      CALL IOVXXX(W(1,10  ),W(1,2   ),W(1,6   ),GG ,AMP(2   ))             
      JAMP(   1) = -AMP(   1)-AMP(   2)


!     CALL OXXXXX(PBAR(0,1   ),ZERO ,NHEL(1   )*FSIGN(1),FSIGN(1   ),W(1,1   ))        
!     CALL IXXXXX(PBAR(0,2   ),ZERO ,NHEL(2   )*FSIGN(2),FSIGN(2   ),W(1,2   ))        
!     CALL IXXXXX(PBAR(0,3   ),ZERO ,NHEL(3   )*FSIGN(3),FSIGN(3   ),W(1,3   ))        
!     CALL OXXXXX(PBAR(0,4   ),ZERO ,NHEL(4   )*FSIGN(4),FSIGN(4   ),W(1,4   ))        
!     CALL SXXXXX(PBAR(0,5   ),FSIGN(5   ),W(1,5   ))                         
!     CALL VXXXXX(PBAR(0,6   ),ZERO ,NHEL(6   )*FSIGN(6),FSIGN(6   ),W(1,6   ))        

!     CALL JIOXXX(W(1,3   ),W(1,4   ),GWF ,WMASS   ,WWIDTH  ,W(1,7   ))    
!     CALL JVSXXX(W(1,7   ),W(1,5   ),GWWH ,WMASS   ,WWIDTH  ,W(1,         
!    &     8   ))                                                          
!     CALL FVIXXX(W(1,2   ),W(1,8   ),GWF ,ZERO    ,ZERO    ,W(1,9   ))    
!     CALL IOVXXX(W(1,9   ),W(1,1   ),W(1,6   ),GG ,AMP(1   ))             
!     CALL FVOXXX(W(1,1   ),W(1,8   ),GWF ,ZERO    ,ZERO    ,W(1,10  ))    
!     CALL IOVXXX(W(1,2   ),W(1,10  ),W(1,6   ),GG ,AMP(2   ))             
!     JAMP(   1) = -AMP(   1)-AMP(   2)

      DUWMHgL = 0.D0 
!     print*, "in mg2_udwhg"
!     print *,"W ", W(1:6,8)
!     print*, "amps ", JAMP(1) !, AMP(1), AMP(2)
!        
!     print*, "sign ", fsign
!     print*, "nhel ", nhel
!     print*, "hel*sign ", NHEL*FSIGN
      
!     do j = 0,3
!        momsum(j) = 0
!     enddo

!     do j = 0,3
!        do i = 1,2
!            pbar(j,i) = pbar(j,i)*fsign(i)
!           momsum(j) = momsum(j) + pbar(j,i)
!        enddo
!        do i = 3,6
!            pbar(j,i) = pbar(j,i)*fsign(i)
!           momsum(j) = momsum(j) - pbar(j,i)
!        enddo
!     enddo
!     if (dotrr(momsum,momsum) > 1e-10) print*, "momsum nonzero", momsum

c     print*, "----------------- comparing wavefunctions, ep, ve, h"
c     print*, w(1:6,3)
c     print*, wve(1:6,1)
c     print*, w(1:6,4)
c     print*, wep(1:6,1)
c     print*, w(1:6,5)
c     print*, hig(1:6,1), fsign(5)

c     do i=1,2
c         print*, i
c         print*, PBAR(0:3,i)
c         print*, NHEL(i)
c        print*, i, W(1:6,i)
c     enddo

c------------------------------------------------------------------
c comparison with hand made code
c in waj: i=1 t-channel, i=2 s-channel
c      do i = 1,2 
c      print*, "hels for amp ", nhel
      if ((nhel(1).eq.nhel(2)).and.
     2    (nhel(3).eq.-1).and.(nhel(4).eq.-1)) then
c           if((h.eq.1.and.nhel(5).eq.+1).or.
c     1        (h.eq.2.and.nhel(5).eq.-1)) then
c              print*, "hels ", nhel(1), nhel(2), nhel(6)
      ! i = 2, only s-channel
c               print*, "save tampr"
      tampr(2,nhel(1),nhel(6),1) 
     &            = Jamp(1)/g ! gluon pol. in helicity basis
      ! divide out strong coupling

c           endif
      endif
      DO I = 1, NCOLOR
          ZTEMP = (0.D0,0.D0)
          DO J = 1, NCOLOR
              ZTEMP = ZTEMP + CF(J,I)*JAMP(J)
          ENDDO
          DUWMHgL =DUWMHgL+ZTEMP*DCONJG(JAMP(I))/DENOM(I)   
      ENDDO
      Do I = 1, NGRAPHS
          amp2(i)=amp2(i)+amp(i)*dconjg(amp(i))
      Enddo
      Do I = 1, NCOLOR
          Jamp2(i)=Jamp2(i)+Jamp(i)*dconjg(Jamp(i))
      Enddo
C      CALL GAUGECHECK(JAMP,ZTEMP,EIGEN_VEC,EIGEN_VAL,NCOLOR,NEIGEN) 
      END
       
       
