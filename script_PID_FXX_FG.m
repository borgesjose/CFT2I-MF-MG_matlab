        Tsim = 1500; % Total simulation time
        PIDtype = 'ZN'; %'ZN' = Ziegle-Nichols , 'CC' = Choen Coon,'AT' = Astrom, 'PR' = Teacher tunning;
        PIDflag = 0;
        %% Step 2 - Problem definition:
        %Tank definition structure
        tank.h0 = 0.001; % initial point
        
        tank.H = 0.375;          
        tank.R1 = 0.125;
        tank.R2 = 0.01;
        
        tank.Cv = 0.97; %velocity coefficient (water 0.97)
        tank.Cc = 0.97; %contraction coefficient (sharp edge aperture 0.62, well rounded aperture 0.97)

        tank.Cd = tank.Cc*tank.Cv; % discharge coefficient

        tank.r = 0.005;% output ratio in meters

        tank.A = pi*tank.r^2;% output Area
        L=2;
        %% Step 3 - Controller definition: 

        [Kc,Ti,Td] = PID(PIDtype); % Type PID selection 
        

        Ts = 5; %  5~10s( Digital control systems,Landau,2006,p.32)
        nptos = Tsim/Ts; %number point of simulation
        ts = linspace(0,Tsim,nptos); % time vector
        H=nptos; % Horizon
       
        u = zeros(nptos,1); % variavel de entrada
        h = zeros(nptos,1); % variavel de saida
        
        %ref_type = 'st'; % st = step ; us = upper stair ; ls = lower stair;
        patamar = 0.05;
        passo = 0.10;
        Tamostra = Ts;
    
        ref = ref_def(patamar,passo,nptos);
                
        %clear h;
        h(4)=tank.h0 ; h(3)=tank.h0 ; h(2)=tank.h0 ; h(1)=tank.h0 ; 
        u(1)=1e-5 ; u(2)=1e-5 ; u(3)=1e-5; u(4)=1e-5;
        erro(1)=1 ; erro(2)=1 ; erro(3)=1; erro(4)=1;


        Am_min = 2;
        Am_max = 5;
        Theta_m_min = 45;
        Theta_m_max = 72;
        L = 2;        


if (FuzzyType == 'T1'),
            
            if (FT1type == 'L')
                gene = populacao{hh,1}(1:gene_size);
                Param = gene;
                
            elseif (FT1type == 'N')
                
               gene = populacao{hh,1}(1:gene_size);
               Param = gene;
    
            end;
            
            
         elseif (FuzzyType == 'T2'),
            
            if (FT2Itype == 'L')
                
                gene = populacao{hh,1}(1:gene_size);
                Param =[gene,1,1];
                
            elseif (FT2Itype == 'N')
                
                gene = populacao{hh,1}(1:gene_size);
                Param = gene;
                
            end;
 end
         


        %% Step 8, Simulation with ode45;

        for i=4:nptos
            
            
            [~,y] = ode45(@(t,y) tank_conical(t,y,u(i-1),tank),[0,Ts],h(i-1));
            h0 = y(end); % take the last point
            h(i) = h0; % store the height for plotting
            
            
           erro(i)=ref(i) - h(i);

            rate(i)=(erro(i) - erro(i-1));%/Tc; %Rate of erro

            if (PIDflag)
                Ami = 1;
            else
                if (FuzzyType == 'T1'),
                    
                    Am(i) = FT1_pid_ag(erro(i),rate(i),L,Param,FT1type);
                    Ami = Am(i)*Am_max + Am_min*(1 - Am(i));
                end
                
                if (FuzzyType == 'T2'),
                    
                    Am(i) =Inferencia_T2(erro(i),rate(i),L,Param,FT2Itype);
                    Ami = Am(i)*Am_max + Am_min*(1 - Am(i));
                    
                end
                
            end
                        %Controlador:

                        Kp(i)= Kc/Ami;
                        Kd(i)= (Td)*Kc/Ami;
                        Ki(i)= (Kc/Ami)/(Ti);

                        alpha = (Kc/Ami)*(1+((Td)/Tamostra)+(Tamostra/(2*(Ti))));
                        beta = -(Kc/Ami)*(1+2*((Td)/Tamostra)-(Tamostra/(2*(Ti))));
                        gama = (Kc/Ami)*(Td)/Tamostra;

                            u(i)= u(i-1) + alpha*erro(i) + beta*erro(i-1) + gama*erro(i-2);

                        %saturation:
                        if(u(i)<5e-5) u(i)=5e-5;end;
                        if(u(i)>2*3.8000e-04) u(i)=2*3.8000e-04;end;

                        tempo(i)=i*Tamostra;

        end