function y = Lshoulder_mf_t1(x,param)

%Retorna os valores de uma MF L-Shoulder com os paramentros, 
% [a, b], em um dado ponto x
    
    a = param(1);
    b = param(2);
    
    
    y = max(min([(x-a)/(b-a),1]),0);

end