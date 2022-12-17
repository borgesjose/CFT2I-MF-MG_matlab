function [y,u]=rele_h(n, Tc, d, eps, polos, ganho);
    
    

    p1 = polos(1);
    p2 = polos(2);

    K = ganho;

   %Coeficientes auxiliares:
    x1=-exp(-p1*Tc);
    x2=-exp(-p2*Tc);
    x3=x1+x2;
    x4=exp(-(p1+p2)*Tc);
    
    % Coeficientes expansão por frações parciais
    A = K/(p1*p2);
    B = K/(-p1*(p2-p1));
    C = K/(-p2*(p1-p2));
   
    % Coeficientes ligados a variavel de controle
    alpha = A+B+C;
    beta = A*x3+B*(x2-1)+C*(x1-1);
    gama = A*x4-B*x2-C*x1;

    %Coeficientes ligados a variavel de saida
    eta = 1;
    theta = -exp(-p1*Tc)-exp(-p2*Tc);
    phi = exp(-(p1+p2)*Tc);



    for t=1:n,
        y(t)=0;
    end;

    e(1)=0; e(2)=0; 
    y(1)=0 ; y(2)=0 ; y(3)=0 ; y(4)=0; y(5)=0;

    u(1)=0 ; u(2)=0 ; u(3)=0 ; u(4)=0; u(5)=d;

    for t=5:n,

       y(t)= -theta*y(t-1) - phi*y(t-2) + alpha*u(t-2) + beta*u(t-3) + gama*u(t-4);
       e(t)= -y(t);

       if ((abs(e(t))>eps) & (e(t)>0))  u(t+1)=d; end;
       if ((abs(e(t))>eps) & (e(t)<0))  u(t+1)=-d; end;
       if ((abs(e(t))<eps) & (u(t)==d))  u(t+1)=d; end;
       if ((abs(e(t))<eps) & (u(t)==-d))  u(t+1)=-d; end;
       if (e(t)==eps)  u(t+1)=d; end;
       if (e(t)==-eps)  u(t+1)=-d; end;

    end;

end