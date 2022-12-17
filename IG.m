function ig = IG(H,a1,a2,a3,u,r,y),


e1 = sum(abs(u(1:H)))/H

var_u = u'-e1;

e2 = (var_u(1:H)*var_u(1:H)')/H

desvio_total = r-y';
e3 = sum(abs(desvio_total(1:H)))/H



ig = a1*e1+a2*e2+a3*e3;


end 