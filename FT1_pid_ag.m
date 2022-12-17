function Am = FT1_pid_ag(erro,rate,L,param,Itype)
        
        % Retorna o valor de Am para o controlador  fuzzy  pid de tipo 1; 

        if (Itype == 'L')
        
            param_erro_N = param(1:2);
            param_erro_Z = param(3:5);
            param_erro_P = param(6:7);

            param_rate_N = param(8:9);
            param_rate_Z = param(10:12);
            param_rate_P = param(13:14);

            %Funções de pertinencia para o erro:
            erro_N = Rshoulder_mf_t1(erro,param_erro_N);
            erro_Z = tri_mf_t1(erro,param_erro_Z); 
            erro_P = Lshoulder_mf_t1(erro,param_erro_P);

            % Funções de pertinencia para o rate:
            rate_N = Rshoulder_mf_t1(erro,param_rate_N);
            rate_Z = tri_mf_t1(erro,param_rate_Z);
            rate_P = Lshoulder_mf_t1(erro,param_rate_P);
        
        elseif (Itype == 'N')
            
            param_erro_N = param(1:2);
            param_erro_Z = param(3:4);
            param_erro_P = param(5:6);

            param_rate_N = param(7:8);
            param_rate_Z = param(9:10);
            param_rate_P = param(11:12);

            %Funções de pertinencia para o erro:
            erro_N = 1-sigmoid_mf_t1(erro,param_erro_N);
            erro_Z = gauss_mf_t1(erro,param_erro_Z); 
            erro_P = sigmoid_mf_t1(erro,param_erro_P);

            % Funções de pertinencia para o rate:
            rate_N = 1-sigmoid_mf_t1(erro,param_rate_N);
            rate_Z = gauss_mf_t1(erro,param_rate_Z);
            rate_P = sigmoid_mf_t1(erro,param_rate_P);
            
            
        end;
        
        
        
        
        Am = inferencia_t1_3X3([erro_N,erro_Z,erro_P],[rate_N,rate_Z,rate_P]);
        

end



