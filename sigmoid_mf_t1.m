function y = sigmoid_mf_t1(x,param)

%Retorna os valores de uma MF sigmoid com os paramentros, 
% [a,c], em um dado ponto x
    a = param(1);
    c = param(2);
    
    y = 1/(1 + exp(-a*(x-c)));

end