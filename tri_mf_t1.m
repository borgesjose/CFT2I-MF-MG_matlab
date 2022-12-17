function y = tri_mf_t1(x,param)
 %Retorna os valores de uma MF triangular com os paramentros, 
 % [a, b, c], em um dado ponto x
    a = param(1);
    b = param(2);
    c = param(3);   
    
    y = max(min((x-a)/(b-a),(c-x)/(c-b)),0);

end