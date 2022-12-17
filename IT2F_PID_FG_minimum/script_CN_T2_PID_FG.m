%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Universidade Federal do Piau�                       %
% Campus Ministro Petronio Portela                    %
% Copyright 2018 -Jos� Borges do Carmo Neto-          %
% @author Jos� Borges do Carmo Neto                   %
% @email jose.borges90@hotmail.com                    %
%  -- Desenvolvimento de um controlador nebuloso de   %
%  tipo 2  aplicado a autosintonia de PID, baseado    % 
%  nas margens de fase e de ganho                     %
%  -- Version: 1.0  - 05/03/2019                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% 1 - Tratando o processo:

% Nesta etapa o processo é discretizado:
% Sendo:

    p1 = (1/2.5);
    p2 = (1/3.75);

    k = 2*p1*p2;
    

    Tc=0.2;
    Tamostra = Tc;
    
    [c0,c1,c2,r0,r1,r2] = discretiza_zoh(p1,p2,k,Tc); %chama a função que discretiza o processo utilizano um ZOH;
    
    nptos = 1600;
%% O PID:

    Kc = 0.1924;
    Ki = 0.0479;
    Kd = 0.5319;

%% Definições do controlador AT-PID-FG: 

    Am = 3;

    Am_min = .001; 
    Am_max = 2;
    Theta_m_min = 45;
    Theta_m_max = 72;
    
        H1 = 0.05;
        H2 = 0.05;
        H3 = 0.95;
        H4 = 0.95;
        
        H = [H1,H1,H3,H4];
       
        
        L = 2;

 turnpoint = floor(rand*nptos);
% for i=1:nptos,
%     if (i<=turnpoint)  ref(i)=2; end;
%     if (i>turnpoint)   ref(i) = 1; end;
% end ;
for i=1:nptos,
    if (i<=nptos/4)  ref(i)=2; end;
    if (i>nptos/4)   ref(i) = 2; end;
    if (i>nptos/2 & i<=3*nptos/4)  ref(i)=1; end;
    if (i>3*nptos/4)   ref(i) = 1; end;
end ;
clear y;
y(4)=0 ; y(3)=0 ; y(2)=0 ; y(1)=0 ; 
u(1)=0 ; u(2)=0 ; u(3)=0; u(4)=0;


erro(1)=1 ; erro(2)=1 ; erro(3)=1; erro(4)=1;

L=2;%Provavelmente o valor de limite das memberships functions

%%
  
 gene = populacao{h,1}(1:8);
 Param = [gene,1,1];
 %H = populacao{h,1}(9:12);
 
    for i=5:nptos,
 
    
        
        y(i)= -r1*y(i-1)-r2*y(i-2)+c0*u(i-2)+c1*u(i-3)+c2*u(i-4); % equação da diferença do processo
     
         erro(i)=ref(i)-y(i); %Erro

         rate(i)=(erro(i)-erro(i-1));%/Tc; %Rate of erro
 
         Am(i) = inferencia_T2_minimum_2(erro(i),rate(i),L,Param,H);
         Ami = Am(i)*Am_max + Am_min*(1 - Am(i));

          %Controlador:

        Kci(i) = Kc/Ami;
        Kdi(i) = Kd/Ami;
        Kii(i) = Ki/Ami;

      % new version
            alpha = Kci(i)+ Kdi(i)/Tamostra + (Kii(i)*Tamostra)/2;
            beta = -Kci(i) - 2*(Kdi(i)/Tamostra)+(Kii(i)*Tamostra)/2;
            gama = Kdi(i)/Tamostra;


            u(i)= u(i-1) + alpha*erro(i) + beta*erro(i-1) + gama*erro(i-2);

           tempo(i)=i*Tamostra;
            
     end ;
       
%%

% figure;
% grid;
% plot(tempo,y,'g-');
% hold on;
% plot(tempo,u);
% plot(tempo,ref);
% title(['FIT2F-PID-FG:',num2str(h),])
%%
     
