function [Kc,Ti,Td] = PID(Ctype),

      if (Ctype == 'ZN')
            L =  0.158;
            T1 = 2.83;
            Kc = 1.2*(3.8000e-04/0.2056)*((T1)/(L))*10^-3;
            Ti = 2*L;
            Td = 0.5*L;       
        end;
        
        if (Ctype == 'CC')
            Kc = .0001;
            Ti = 0.2;
            Td = 0.079;            
        end;
        
        if (Ctype == 'AT')
            Kc = .0001;
            Ti = 0.2;
            Td = 0.079;            
            
        end;   
        
        if (Ctype == 'FG')
             
            K = AT_PID_FG(Am,L,a,b,c);
            
            Kc = K(1);
            Ti = Kc/K(2);
            Td = K(3)/Kc;
            
        end; 
        
        if(Ctype == 'PR')
            disp("Selecione um controlador: ZN , CC, AT ") 
            %SINTONIA PROFESSOR:
            Kc = .00005;
            Ti = 0.2;
            Td = 0.079;
            %Td = 0.0;
        end; 
   

            