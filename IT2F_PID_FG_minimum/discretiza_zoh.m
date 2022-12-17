function [c0,c1,c2,r0,r1,r2] = discretiza_zoh(p1,p2,k,Tc);


a0=k/(p1*p2);
a1=k/(-p1*(p2-p1));
a2=k/(-p2*(p1-p2));
x1=-exp(-p1*Tc);
x2=-exp(-p2*Tc);
x3=x1+x2;
x4=exp(-(p1+p2)*Tc);

c0=a0+a1+a2;
c1=a0*x3+a1*(x2-1)+a2*(x1-1);
c2=a0*x4-a1*x2-a2*x1;

r0=1;
r1=x3;
r2=x4;

