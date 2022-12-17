function y = Rshoulder_mf_t1(x,param)

%Retorna os valores de uma MF R-Shoulder com os paramentros, 
% [c, d], em um dado ponto x

    c = param(1);   
    d = param(2);
    
    y = max(min([1,(d-x)/(d-c)]),0);

end