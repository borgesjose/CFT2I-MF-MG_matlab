function plot_pertinencias_T2(gene,FT2Itype,L)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Universidade Federal do Piauí                       %
% Campus Ministro Petronio Portela                    %
% Copyright 2022 -José Borges do Carmo Neto-          %
% @author José Borges do Carmo Neto                   %
% @email jose.borges90@hotmail.com                    %
%  -- Level control of a conical tank using Interval  %
%  Type-2 Fuzzy Logic PID controllers for the Phase   %
%  and Gain Margins of the System                     % 
%  nas margens de fase e de ganho                     %
%  -- Version: 1.0  - 20/02/2022                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%clear; clc; close all;


M=[];
M1=[];
x=-2*L:0.001:2*L;
y=-2*L:0.001:2*L;

%Para Linear 
%gene = .3*ones(1,16)

%Para Não-Linear 
 
% for i=1:length(x)
%     Ami(i) = Inferencia_T2(x(i),y(i),L,Param,Itype);
% end

for i=1:length(x), % De 1 até o No. total de medidas da variavel linguistica...
                
                if (FT2Itype == 'L'), 
                    Param = [gene,1,1];
                    [mi, mo] = pertinencias_T2(x(i),y(i),L,Param,FT2Itype);  % pertinencia aos conjuntos fuzzy (curvatura)
                end
                
                if (FT2Itype == 'N'),
                    Param = gene;
                    [mi, mo] = pertinencias_T2_NL(x(i),y(i),L,Param,FT2Itype);  % pertinencia aos conjuntos fuzzy (curvatura)
                    
                end
      
  M=[M; mi];
  M1=[M1; mo];
end

% Forma do vetor M
% M = [Nb,Zb,Pb,Zu,Zl,Nu,Nl,Pu,Pl]
% Forma do vetor M1
% M1 = [Nb,Zb,Pb,Zu,Zl,Nu,Nl,Pu,Pl]

%Plotagem


%PLOTAGEM DAS MF DO ERRO:
figure; hold on

plot(x,M(:,4),'Color',[0.4660 0.6740 0.1880]); % gráfico conjunto fuzzy erro ZERO UPPER
plot(x,M(:,5),'Color',[0.4660 0.6740 0.1880]); % gráfico conjunto fuzzy erro ZERO LOWER
x2 = [x, fliplr(x)];
inBetween = [M(:,5)', fliplr(M(:,4)')];
fill(x2, inBetween, [0.4660 0.6740 0.1880]);
plot(x,M(:,2),'Color',[0.4660 0.6740 0.1880]); % gráfico conjunto fuzzy erro ZERO

plot(x,M(:,6),'r-'); % gráfico conjunto fuzzy erro NEGATIVO UPPER
plot(x,M(:,7),'r-'); % gráfico conjunto fuzzy erro NEGATIVO LOWER
x2 = [x, fliplr(x)];
inBetween = [M(:,7)', fliplr(M(:,6)')];
fill(x2, inBetween, 'r');
plot(x,M(:,1),'r-'); % gráfico conjunto fuzzy erro NEGATIVO


plot(x,M(:,8),'Color',[0.4940 0.1840 0.5560]); % gráfico conjunto fuzzy erro POSITIVO UPPER
plot(x,M(:,9),'Color',[0.4940 0.1840 0.5560]); % gráfico conjunto fuzzy erro POSITIVO LOWER
x2 = [x, fliplr(x)];
inBetween = [M(:,9)', fliplr(M(:,8)')];
fill(x2, inBetween, [0.4940 0.1840 0.5560]);
plot(x,M(:,3),'Color',[0.4940 0.1840 0.5560]); % gráfico conjunto fuzzy erro POSITIVO


hold off
axis([-2*L 2*L 0 1.2]);
xlabel('ERRO');
%legend('','','POSITIVO','NEGATIVO','ZERO','POSITIVO','NEGATIVO','ZERO','POSITIVO')
%saveas(gcf,['./figures/','FT2-PID-FG: Pertinencias ERRO','.png'])
%%

%PLOTAGEM1 DAS MF DO RATE:
figure; hold on

plot(x,M1(:,4),'Color',[0.6350 0.0780 0.1840]); % gráfico conjunto fuzzy RATE ZERO UPPER
plot(x,M1(:,5),'Color',[0.6350 0.0780 0.1840]); % gráfico conjunto fuzzy RATE ZERO LOWER
x2 = [x, fliplr(x)];
inBetween = [M1(:,5)', fliplr(M1(:,4)')];
fill(x2, inBetween, [0.6350 0.0780 0.1840]);
plot(x,M1(:,2),'Color',[0.6350 0.0780 0.1840]); % gráfico conjunto fuzzy RATE ZERO


plot(x,M1(:,6),'Color',[0 0.4470 0.7410]); % gráfico conjunto fuzzy RATE NEGATIVO UPPER
plot(x,M1(:,7),'Color',[0 0.4470 0.7410]); % gráfico conjunto fuzzy RATE NEGATIVO LOWER
x2 = [x, fliplr(x)];
inBetween = [M1(:,7)', fliplr(M1(:,6)')];
fill(x2, inBetween,[0 0.4470 0.7410]);
plot(x,M1(:,1),'Color',[0 0.4470 0.7410]); % gráfico conjunto fuzzy RATE NEGATIVO



plot(x,M1(:,8),'Color',[0.9290 0.6940 0.1250]); % gráfico conjunto fuzzy RATE POSITIVO UPPER
plot(x,M1(:,9),'Color',[0.9290 0.6940 0.1250]); % gráfico conjunto fuzzy RATE POSITIVO LOWER
x2 = [x, fliplr(x)];
inBetween = [M1(:,9)', fliplr(M1(:,8)')];
fill(x2, inBetween, [0.9290 0.6940 0.1250]);
plot(x,M1(:,3),'Color',[0.9290 0.6940 0.1250]); % gráfico conjunto fuzzy RATE POSITIVO

hold off
axis([-2*L 2*L 0 1.2]);
xlabel('RATE');
%legend('NEGATIVO','ZERO','POSITIVO','NEGATIVO','ZERO','POSITIVO','NEGATIVO','ZERO','POSITIVO','NEGATIVO','ZERO','POSITIVO','NEGATIVO','ZERO','POSITIVO','NEGATIVO','ZERO','POSITIVO')

end