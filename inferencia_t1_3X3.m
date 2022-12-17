function output = inferencia_t1_3X3(pert_erro,pert_rate),
%
% Implementacao de um controlador Fuzzy baseado em margem de fase e de ganho 
% do tipo Gain Scheduling
%
% Autor: jose borges
% Data: 04/03/2022 


% REGRA 1:  

R1 = pert_erro(1)*pert_rate(1);

% REGRA 2: 

R2 =pert_erro(1)*pert_rate(2)  ;

% REGRA 3: 

R3= pert_erro(1)*pert_rate(3);

% REGRA 4: 

R4 = pert_erro(2)*pert_rate(1);

% REGRA 5:

R5 = pert_erro(2)*pert_rate(2);

% REGRA 6: 

R6= pert_erro(2)*pert_rate(3);

% REGRA 7: 

R7 = pert_erro(3)*pert_rate(1);

% REGRA 8: 

R8 = pert_erro(3)*pert_rate(2);

% REGRA 9: 

R9= pert_erro(3)*pert_rate(3);


output = R1*(exp(-R1*4)) + R2*(exp(-R2*4)) + R3*(exp(-R3*4))+ R4*(1 - exp(-R4*4)) + R5*(1 - exp(-R5*4)) + R6*(1 - exp(-R6*4))+ R7*(exp(-R7*4)) + R8*(exp(-R8*4)) + R9*(exp(-R9*4));
end