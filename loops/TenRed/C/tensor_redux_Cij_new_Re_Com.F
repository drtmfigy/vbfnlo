      subroutine tens_red3_new_Re_Com(p1sq,p2sq,s12,B0_23,B0_13,B0_12, 
     &                     C0,C0r,C0I,Cijr,CijI)
C                tens_red3 = 3-point tensors
C     Francisco Campanario
C    Email: Francam@particle.uni-karlsruhe.de
C Date: 25/02/2010
c
c  determine the Passarino-Veltman tensor decomposition for the three-point
c  tensor integrals
c
c                       d^4k           1;  k_mu;   k_mu k_nu
c C0;C_mu;C_munu =Int -------  -----------------------------------------
c                     (2pi)^4    [k^2-m^2][(k+p1)^2-m^2][(k+p1+p2)^2-m^2] 
c
c with
c
c    C_mu = p1_mu C11  +  p_2_mu C12
c
c  C_munu = p1_mu p1_nu C21 + p2_mu p2_nu C22 + 
c           (p1_mu p2_nu + p1_nu p2_mu) C23  -  g_munu C24
c
c  for notation see Passarino&Veltman, NP B160 (1979) 151 and my notes
c
C INPUT:  p1sq, p2sq, s12          external invariants: p1^2, p2^2, s12=(p1+p2)^2
C         B0, C0                   4 scalar integrals; the 3 B0 are, 
c                                  in PV notation:
c         B0(1) = B0(1,2) = B0(p1)  B_0 function with subtraction of 
c         B0(2) = B0(2,3) = B0(p2)  divergent term
c         B0(3) = B0(1,3) = B0(s12)
c
c OUTPUT: Cij(n,m) = C_nm          form factors in the tensor integrals
c          n=1,2,3,4; n=1,2        a la PV
c

      implicit none
      real * 8  p1sq, p2sq, s12
      complex*16 B0_23, B0_13, B0_12, C0
      real*8 r1, r2r1, det,p1p2
      real*8 B1r_12,B1r_13,B1r_23,Cijr(4,2)
      real*8 B1I_12,B1I_13,B1I_23,CijI(4,2)
      real*8 B0r_23, B0r_13, B0r_12, C0r
      real*8 B0I_23, B0I_13, B0I_12, C0I 
      real*8 z11,z12,z21,z22,iz11,iz22
      real*8 Rr(2),RI(2),PRr(2),PRI(2)


      Integer jjinit

      real*8 tempjj,tempkl,IX,Zmax
      Common/Decide/tempjj,tempkl,IX,ZMax,jjinit
      Save/Decide/
CCCCCCCCC
!       para=1.3d-3
CCCCCCC


      p1p2 = (s12 - p1sq - p2sq)*0.5d0

      r1 = p1sq
      r2r1 = s12 - r1
      
      B0r_12=Dble(B0_12)
      B0r_13=Dble(B0_13)
      B0r_23=Dble(B0_23)
      C0r=Dble(C0)

      B0I_12=DImag(B0_12)
      B0I_13=DImag(B0_13)
      B0I_23=DImag(B0_23)
      C0I=DImag(C0)

      B1r_12 = -B0r_12*0.5d0
      B1r_13 = -B0r_13*0.5d0
      B1r_23 = -B0r_23*0.5d0
      
      B1I_12 = -B0I_12*0.5d0
      B1I_13 = -B0I_13*0.5d0
      B1I_23 = -B0I_23*0.5d0
  
      If(abs(p1sq).gt.abs(p1p2)) then
          z11=2d0*p1sq
          iz11=1d0/z11
          z12=2d0*p1p2 
          z21=z12*iz11
          z22=2d0*p2sq-z12*z21
          iz22=1d0/z22
c          iorder(1)=1
c          iorder(2)=2
          det=z11*z22 

c$$$cc FOR SMALL GRAM DETERMINANT
c$$$         
c$$$	dettemp= 4d0*p1sq*p2sq -z12*z12
c$$$	detabs=abs(4d0*p1sq*p2sq)+abs(z12*z12) 
c$$$	if(abs(dettemp)/detabs.lt.para) then
c$$$c d-3
c$$$!        Print*, "Active"
c$$$        call ten_red3_Gram(p1sq,p2sq,s12,B0_23,B0_13,B0_12,C0123,Cij)
c$$$	
c$$$	
c$$$       if(tempkl.ge.2.9d-3) then
c$$$       Print*, "1kl100"
c$$$       goto 100
c$$$       endif
c$$$       
c$$$
c$$$       if(tempjj.ge.1d-2) then
c$$$       Print*, "1jj100"
c$$$       goto 100
c$$$       endif
c$$$       
c$$$       
c$$$        C0r=Dble(C0123)
c$$$        C0I=DImag(C0123)
c$$$
c$$$
c$$$       Cijr(1,1)=Dble(Cij(1,1))
c$$$       Cijr(2,1)=Dble(Cij(2,1))
c$$$       Cijr(1,2)=Dble(Cij(1,2))
c$$$       Cijr(2,2)=Dble(Cij(2,2))
c$$$       Cijr(3,2)=Dble(Cij(3,2))
c$$$       Cijr(4,2)=Dble(Cij(4,2))
c$$$
c$$$       CijI(1,1)=DImag(Cij(1,1))
c$$$       CijI(2,1)=DImag(Cij(2,1))
c$$$       CijI(1,2)=DImag(Cij(1,2))
c$$$       CijI(2,2)=DImag(Cij(2,2))
c$$$       CijI(3,2)=DImag(Cij(3,2))
c$$$       CijI(4,2)=DImag(Cij(4,2))
c$$$
c$$$	return
c$$$	endif
c$$$cc FINISH FOR SMALL GRAM DETERMINANT
	  
c 1-2
       PRr(1) = (B0r_13 - B0r_23 - C0r*r1)
       PRr(2) = (B0r_12 - B0r_13 - C0r*r2r1)
   
       Rr(2)=(PRr(2)-z21*PRr(1))*iz22 
       Rr(1)=(PRr(1)-z12*Rr(2))*iz11 

       Cijr(1,1) = Rr(1)
       Cijr(2,1) = Rr(2)

       PRI(1) = (B0I_13 - B0I_23 - C0I*r1)
       PRI(2) = (B0I_12 - B0I_13 - C0I*r2r1)
      
       RI(2)=(PRI(2)-z21*PRI(1))*iz22 
       RI(1)=(PRI(1)-z12*RI(2))*iz11 

       CijI(1,1) = RI(1)
       CijI(2,1) = RI(2)
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
c C00
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
       Cijr(4,2) = ( B0r_23 + Cijr(1,1)*r1 +Cijr(2,1)*r2r1 +1.d0)*0.25d0
       CijI(4,2) = ( B0I_23 + CijI(1,1)*r1 +CijI(2,1)*r2r1)*0.25d0
      
c 3-5
       PRr(1) = (B1r_13 + B0r_23 - Cijr(1,1)*r1 - Cijr(4,2)*2.d0)
       PRr(2) = (B1r_12 - B1r_13 - Cijr(1,1)*r2r1)

       Rr(2)=(PRr(2)-z21*PRr(1))*iz22 
       Rr(1)=(PRr(1)-z12*Rr(2))*iz11 

       Cijr(1,2) =Rr(1)
       Cijr(3,2) =Rr(2)

       PRI(1) = (B1I_13 + B0I_23 - CijI(1,1)*r1 - CijI(4,2)*2.d0)
       PRI(2) = (B1I_12 - B1I_13 - CijI(1,1)*r2r1)

       RI(2)=(PRI(2)-z21*PRI(1))*iz22 
       RI(1)=(PRI(1)-z12*RI(2))*iz11 

       CijI(1,2) =RI(1)
       CijI(3,2) =RI(2)

c 4-6
       PRr(1) = (  B1r_13 - B1r_23 - Cijr(2,1)*r1)
       PRr(2) = (- B1r_13          -Cijr(2,1)*r2r1 -Cijr(4,2)*2.d0)
      
       Rr(2)=(PRr(2)-z21*PRr(1))*iz22 
c      Rr(1)=(PRr(1)-z12*Rr(2))*iz11 

       Cijr(2,2) = Rr(2)
c      Cijr(3,2) = Rr(1)


       PRI(1) = (  B1I_13 - B1I_23 - CijI(2,1)*r1)
       PRI(2) = (- B1I_13          - CijI(2,1)*r2r1 -CijI(4,2)*2.d0)

       RI(2)=(PRI(2)-z21*PRI(1))*iz22 
c      RI(1)=(PRI(1)-z12*RI(2))*iz11 

       CijI(2,2) = RI(2)
c      CijI(3,2) = RI(1)

       return
ccccccccccccccccc
cccccccccccccccc
ccccccccccccccccc
       else
		  z11=2d0*p1p2
		  iz11=1d0/z11
		  z21=2d0*p1sq*iz11
		  z12=2d0*p2sq
		  z22=z11-z12*z21
		  iz22=1d0/z22
c          iorder(1)=2
c          iorder(2)=1
          det=-z11*z22

c$$$cc FOR SMALL GRAM DETERMINANT 
c$$$	dettemp= 4d0*p1sq*p2sq - z11*z11
c$$$	detabs=abs(4d0*p1sq*p2sq)+abs(z11*z11) 
c$$$	if(abs(dettemp)/detabs.lt.para) then
c$$$
c$$$c d-3
c$$$       !Print*, "Active2"
c$$$       call ten_red3_Gram(p1sq,p2sq,s12,B0_23,B0_13,B0_12,C0123,Cij)
c$$$       
c$$$       if(tempkl.ge.2.9d-3) then
c$$$       goto 200
c$$$       Print*, "2kl200"
c$$$       endif
c$$$       if(tempjj.ge.1d-2) then
c$$$       goto 200
c$$$       Print*, "2jj200"
c$$$       endif
c$$$       
c$$$       C0r=Dble(C0123)
c$$$       C0I=DImag(C0123)
c$$$
c$$$       Cijr(1,1)=Dble(Cij(1,1))
c$$$       Cijr(2,1)=Dble(Cij(2,1))
c$$$       Cijr(1,2)=Dble(Cij(1,2))
c$$$       Cijr(2,2)=Dble(Cij(2,2))
c$$$       Cijr(3,2)=Dble(Cij(3,2))
c$$$       Cijr(4,2)=Dble(Cij(4,2))
c$$$
c$$$       CijI(1,1)=DImag(Cij(1,1))
c$$$       CijI(2,1)=DImag(Cij(2,1))
c$$$       CijI(1,2)=DImag(Cij(1,2))
c$$$       CijI(2,2)=DImag(Cij(2,2))
c$$$       CijI(3,2)=DImag(Cij(3,2))
c$$$       CijI(4,2)=DImag(Cij(4,2))
c$$$
c$$$	return
c$$$	endif
c$$$cc FINISH FOR SMALL GRAM DETERMINANT 

c 1-2
       PRr(1) = (B0r_13 - B0r_23 - C0r*r1)
       PRr(2) = (B0r_12 - B0r_13 - C0r*r2r1)
   
       Rr(2)=(PRr(1)-z21*PRr(2))*iz22 
       Rr(1)=(PRr(2)-z12*Rr(2))*iz11 
 
       Cijr(1,1) = Rr(1)
       Cijr(2,1) = Rr(2)
 
       PRI(1) = (B0I_13 - B0I_23 - C0I*r1)
       PRI(2) = (B0I_12 - B0I_13 - C0I*r2r1)
      
       RI(2)=(PRI(1)-z21*PRI(2))*iz22 
       RI(1)=(PRI(2)-z12*RI(2))*iz11 
 
       CijI(1,1) = RI(1)
       CijI(2,1) = RI(2)
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
c C00
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
       Cijr(4,2) = ( B0r_23 + Cijr(1,1)*r1 +Cijr(2,1)*r2r1 +1.d0)*0.25d0
       CijI(4,2) = ( B0I_23 + CijI(1,1)*r1 +CijI(2,1)*r2r1)*0.25d0
      
c 3-5
       PRr(1) = (B1r_13 + B0r_23 - Cijr(1,1)*r1 - Cijr(4,2)*2.d0)
       PRr(2) = (B1r_12 - B1r_13 - Cijr(1,1)*r2r1)
       
       Rr(2)=(PRr(1)-z21*PRr(2))*iz22 
       Rr(1)=(PRr(2)-z12*Rr(2))*iz11 
       
       Cijr(1,2) =Rr(1)
       Cijr(3,2) =Rr(2)
       
       PRI(1) = (B1I_13 + B0I_23 - CijI(1,1)*r1 - CijI(4,2)*2.d0)
       PRI(2) = (B1I_12 - B1I_13 - CijI(1,1)*r2r1)
       
       RI(2)=(PRI(1)-z21*PRI(2))*iz22 
       RI(1)=(PRI(2)-z12*RI(2))*iz11 
       
       CijI(1,2) =RI(1)
       CijI(3,2) =RI(2)

c 4-6
       PRr(1) = (  B1r_13 - B1r_23 - Cijr(2,1)*r1)
       PRr(2) = (- B1r_13          -Cijr(2,1)*r2r1 -Cijr(4,2)*2.d0)
       
       Rr(2)=(PRr(1)-z21*PRr(2))*iz22 
c      Rr(1)=(PRr(2)-z12*Rr(2))*iz11 

       Cijr(2,2) = Rr(2)
c      Cijr(3,2) = Rr(1)


       PRI(1) = (  B1I_13 - B1I_23 - CijI(2,1)*r1)
       PRI(2) = (- B1I_13          - CijI(2,1)*r2r1 -CijI(4,2)*2.d0)
       
       RI(2)=(PRI(1)-z21*PRI(2))*iz22 
c      RI(1)=(PRI(2)-z12*RI(2))*iz11 


       CijI(2,2) = RI(2)
c      CijI(3,2) = RI(1)


       endif
	return
	end

cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
