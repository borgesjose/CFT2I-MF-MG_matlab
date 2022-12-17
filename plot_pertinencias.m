
clear; clc; close all;

L = 2;

x=-2*L:0.001:2*L;
y=-2*L:0.001:2*L;

param = [-L,0,-L,0,L,0,L,-L,0,-L,0,L,0,L];        
%%
M=[];
M1=[];
for i=1:length(x), % De 1 até o No. total de medidas da variavel linguistica...
  [mi, mo] = pertinencias_T1(x(i),y(i),param);  % pertinencia aos conjuntos fuzzy (curvatura)
  M=[M; mi];
  M1=[M1; mo];
end

figure; hold on
plot(x,M(:,1),'Color',[0.4660 0.6740 0.1880],"LineWidth",3); % gráfico conjunto fuzzy erro NEGATIVO
plot(x,M(:,2),'r-',"LineWidth",3); % gráfico conjunto fuzzy erro ZERO
plot(x,M(:,3),'Color',[0.4940 0.1840 0.5560],"LineWidth",3); % gráfico conjunto fuzzy erro POSITIVO
hold off
axis([-2*L 2*L 0 1.2]);
xlabel('ERRO');
%legend('NEGATIVO','ZERO','POSITIVO')

figure; hold on
plot(y,M1(:,1),'Color',[0.6350 0.0780 0.1840],"LineWidth",3); % gráfico conjunto fuzzy rate NEGATIVO
plot(y,M1(:,2),'Color',[0 0.4470 0.7410],"LineWidth",3); % gráfico conjunto fuzzy rate ZERO
plot(y,M1(:,3),'Color',[0.9290 0.6940 0.1250],"LineWidth",3); % gráfico conjunto fuzzy rate POSITIVO
hold off
axis([-2*L 2*L 0 1.2]);
xlabel('RATE');
%legend('NEGATIVO','ZERO','POSITIVO')
