function plot_pertinencia_T1(param,FT1type,L)
%clear; clc; close all;

x=-2*L:0.001:2*L;
y=-2*L:0.001:2*L;

if (FT1type == 'L'),

            param_erro_N = param(1:2);
            param_erro_Z = param(3:5);
            param_erro_P = param(6:7);

            param_rate_N = param(8:9);
            param_rate_Z = param(10:12);
            param_rate_P = param(13:14);
            
      for i=1:length(x), % De 1 até o No. total de medidas da variavel linguistica...
          
           %Funções de pertinencia para o erro:
            erro_N(i) = Rshoulder_mf_t1(x(i),param_erro_N);
            erro_Z(i) = tri_mf_t1(x(i),param_erro_Z); 
            erro_P(i) = Lshoulder_mf_t1(x(i),param_erro_P);

            % Funções de pertinencia para o rate:
            rate_N(i) = Rshoulder_mf_t1(x(i),param_rate_N);
            rate_Z(i) = tri_mf_t1(x(i),param_rate_Z);
            rate_P(i) = Lshoulder_mf_t1(x(i),param_rate_P);
           
      end             

elseif (FT1type == 'N'),
    
            param_erro_N = param(1:2);
            param_erro_Z = param(3:4);
            param_erro_P = param(5:6);

            param_rate_N = param(7:8);
            param_rate_Z = param(9:10);
            param_rate_P = param(11:12);
    
    
      for i=1:length(x), % De 1 até o No. total de medidas da variavel linguistica...
          
           %Funções de pertinencia para o erro:
            erro_N(i) = 1-sigmoid_mf_t1(x(i),param_erro_N);
            erro_Z(i) = gauss_mf_t1(x(i),param_erro_Z); 
            erro_P(i) = sigmoid_mf_t1(x(i),param_erro_P);

            % Funções de pertinencia para o rate:
            rate_N(i) = 1-sigmoid_mf_t1(x(i),param_rate_N);
            rate_Z(i) = gauss_mf_t1(x(i),param_rate_Z);
            rate_P(i) = sigmoid_mf_t1(x(i),param_rate_P);
           
      end 
end


    figure; hold on
    plot(x, erro_N,'Color',[0.4660 0.6740 0.1880],"LineWidth",3); % gráfico conjunto fuzzy erro NEGATIVO
    plot(x,erro_Z,'r-',"LineWidth",3); % gráfico conjunto fuzzy erro ZERO
    plot(x, erro_P,'Color',[0.4940 0.1840 0.5560],"LineWidth",3); % gráfico conjunto fuzzy erro POSITIVO
    hold off
    axis([-2*L 2*L 0 1.2]);
    xlabel('ERRO');
    %legend('NEGATIVO','ZERO','POSITIVO')

    figure; hold on
    plot(y,rate_N,'Color',[0.6350 0.0780 0.1840],"LineWidth",3); % gráfico conjunto fuzzy rate NEGATIVO
    plot(y,rate_Z,'Color',[0 0.4470 0.7410],"LineWidth",3); % gráfico conjunto fuzzy rate ZERO
    plot(y,rate_P,'Color',[0.9290 0.6940 0.1250],"LineWidth",3); % gráfico conjunto fuzzy rate POSITIVO
    hold off
    axis([-2*L 2*L 0 1.2]);
    xlabel('RATE');
    %legend('NEGATIVO','ZERO','POSITIVO')

end