function [mi1 ,mi2]=pertinencias_T2_minimum(erro,rate,L,T)

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

theta = T(1:4);
gama = T(5:8);


%INPUT SET LINEAR

% Conjunto de ERROS NEGATIVOS T2:

a= -L-theta(1);
b = L-theta(1);
c = -L + theta(2);
d = L+theta(2);

%Conjunto tipo 1 de base:
if x<= -L,
   mi1(1)=1;
elseif ((x> -L) & (x<L)),
   mi1(1)= (- x /(2*L)) + 1/2;
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

% Conjunto de ERROS POSITIVOS

e= -L-theta(3);
f = L-theta(3);
g = -L+theta(4);
h = L + theta(4);

%Conjunto tipo 1 de base:
if x>=L,
   mi1(3)=1;
elseif ((x>=-L) & (x<=L)),
   mi1(3)=(x /(2*L)) + 1/2;
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
a= -L-gama(1);
b = L -gama(1);
c = -L + gama(2);
d = L+gama(2);

%Conjunto tipo 1 de base:
if z<= -L,
   mi2(1)=1;
elseif ((z> -L) & (z<L)),
   mi2(1)= (- z /(2*L)) + 1/2;
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


% Conjunto de RATE POSITIVOS

e= -L-gama(3);
f = L-gama(3);
g = -L+gama(4);
h = L + gama(4);

%Conjunto tipo 1 de base:
if z>=L,
   mi2(3)=1;
elseif ((z>=-L) & (z<=L)),
   mi2(3)=(x /(2*L)) + 1/2;
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

