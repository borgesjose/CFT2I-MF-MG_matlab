function [mi1 ,mi2]=pertinencias(erro,rate,L,T,Itype)

% Retorna as pertinÃªncias da medida x aos conjuntos fuzzy
% definidos para as variaveis ERRO e RATE.
%
% Funcoes de pertinencia TRIANGULARES/TRAPEZOIDAS
%
% Data: 04/03/2019
% Autor: Jose Borges do Carmo Neto

%  L é o valor de abertura da MF zero;
%  T é um vetor com os valores dos parametros para IT2 

x= erro;
z= rate;

theta = T(1:8);
gama = T(9:16);


%INPUT SET LINEAR

% Conjunto de ERROS NEGATIVOS T2:

a= -L-theta(3);
b = -theta(3);
c = -L + theta(4);
d = theta(4);

%Conjunto tipo 1 de base:
if x<= -L,
   mi1(1)=1;
elseif ((x> -L) & (x<0)),
   mi1(1)= -(1/L)*(x);
else
   mi1(1)=0;
end

% Superior:
if ((x<=c)),
   mi1(6)=1;
elseif ((x>c) & (x<=d)),
   mi1(6)= (d-x)/(d-c);
elseif ((x>d)),
   mi1(6)=0; 
end

% Inferior:
if ((x<=a) ),
   mi1(7)= 1;
elseif ((x>a) & (x<=b)),
   mi1(7)= (b-x)/(b-a);
else
   mi1(7)=0;
end



% Conjunto de ERROS ZEROS T2
a= -L-theta(1);
b = -theta(1);
c = theta(8);
d = L+theta(8);
e = -L+theta(2);
f = 0;
g = L-theta(7);
mif = T(17);

%Conjunto tipo 1 de base:
if ((x>-L) & (x<=0)),
   mi1(2)=(x/L)+1;
elseif ((x>0) & (x<=L)),
   mi1(2)= -(x/L)+1;
else
   mi1(2)=0;
end

% Superior:
if ((x>a) & (x<=b)),
   mi1(4)= (x-a)/(b-a);
elseif ((x>b) & (x<=c)),
   mi1(4)= 1;
elseif ((x>c) & (x<=d)),
   mi1(4)=(d-x)/(d-c); 
else
   mi1(4)=0;
end

% Inferior:
if ( (x>e) & (x<=f) ),
   mi1(5)= mif*(x-e)/(f-e);
elseif ((x>f) & (x<=g)),
   mi1(5)= mif*(g-x)/(g-f);
else
   mi1(5)=0;
end


% Conjunto de ERROS POSITIVOS

e= -theta(5);
f = L-theta(5);
g = theta(6);
h = L + theta(6);

%Conjunto tipo 1 de base:
if x>=L,
   mi1(3)=1;
elseif ((x>=0) & (x<=L)),
   mi1(3)=(x/L);
else
   mi1(3)=0;
end

% Superior:
if ((x<=e)),
   mi1(8)=0;
elseif ((x>e) & (x<=f)),
   mi1(8)= (x-e)/(f-e);
elseif ((x>f)),
   mi1(8)=1; 
end

% Inferior:
if ((x<=g)),
   mi1(9)= 0;
elseif ((x>g) & (x<=h)),
   mi1(9)= (x-g)/(h-g);
else
   mi1(9)=1;
end


%%%%%%%%%
%%%%%%%%%
% Conjunto de RATE NEGATIVOS T2:
a= -L-gama(3);
b = -gama(3);
c = -L + gama(4);
d = gama(4);

%Conjunto tipo 1 de base:
if z<= -L,
   mi2(1)=1;
elseif ((z> -L) & (z<0)),
   mi2(1)= -(1/L)*(z);
else
   mi2(1)=0;
end

% Superior:
if ((z<=c)),
   mi2(6)=1;
elseif ((z>c) & (z<=d)),
   mi2(6)= (d-z)/(d-c);
elseif ((z>d)),
   mi2(6)=0; 
end

% Inferior:
if ((z<=a) ),
   mi2(7)= 1;
elseif ((z>a) & (z<=b)),
   mi2(7)= (b-z)/(b-a);
else
   mi2(7)=0;
end



% Conjunto de RATE ZEROS T2
a= -L-gama(1);
b = -gama(1);
c = gama(8);
d = L+gama(8);
e = -L+gama(2);
f = 0;
g = L-gama(7);
mif = T(18);

%Conjunto tipo 1 de base:
if ((z>-L) & (z<=0)),
   mi2(2)=(z/L)+1;
elseif ((z>0) & (z<=L)),
   mi2(2)= -(z/L)+1;
else
   mi2(2)=0;
end

% Superior:
if ((z>a) & (z<=b)),
   mi2(4)= (z-a)/(b-a);
elseif ((z>b) & (z<=c)),
   mi2(4)= 1;
elseif ((z>c) & (z<=d)),
   mi2(4)=(d-z)/(d-c); 
else
   mi2(4)=0;
end

% Inferior:
if ( (z>e) & (z<=f) ),
   mi2(5)= mif*(z-e)/(f-e);
elseif ((z>f) & (z<=g)),
   mi2(5)= mif*(g-z)/(g-f);
else
   mi2(5)=0;
end


% Conjunto de RATE POSITIVOS

e= -gama(5);
f = L-gama(5);
g = gama(6);
h = L + gama(6);

%Conjunto tipo 1 de base:
if z>=L,
   mi2(3)=1;
elseif ((z>=0) & (z<=L)),
   mi2(3)=(z/L);
else
   mi2(3)=0;
end

% Superior:
if ((z<=e)),
   mi2(8)=0;
elseif ((z>e) & (z<=f)),
   mi2(8)= (z-e)/(f-e);
elseif ((z>f)),
   mi2(8)=1; 
end

% Inferior:
if ((z<=g)),
   mi2(9)= 0;
elseif ((z>g) & (z<=h)),
   mi2(9)= (z-g)/(h-g);
else
   mi2(9)=1;
end
   
end

