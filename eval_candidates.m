function param = eval_candidates(param,FuzzyType,FT1type,FT2Itype),


    if (FuzzyType == 'T1'),

            if (FT1type == 'L'),
                param_erro_N = param(1:2);
                param_erro_Z = param(3:5);
                param_erro_P = param(6:7);

                if(param_erro_N(2)<= param_erro_N(1)) param_erro_N = sort(param_erro_N); end 
                if(~(param_erro_Z(1)<= param_erro_Z(2)<=param_erro_Z(3)))  param_erro_Z = sort(param_erro_Z);end
                if(param_erro_P(2)<= param_erro_P(1)) param_erro_P = sort(param_erro_P); end 

                param_rate_N = param(8:9);
                param_rate_Z = param(10:12);
                param_rate_P = param(13:14); 

                if(param_rate_N(2)<= param_rate_N(1)) param_rate_N = sort(param_rate_N); end 
                if(~(param_rate_Z(1)<= param_rate_Z(2)<=param_rate_Z(3)))  param_rate_Z = sort(param_rate_Z);end
                if(param_rate_P(2)<= param_rate_P(1)) param_rate_P = sort(param_rate_P); end 
            
            
            elseif (FT1type == 'N'),
                param_erro_N = param(1:2);
                param_erro_Z = param(3:4);
                param_erro_P = param(5:6);

                param_rate_N = param(7:8);
                param_rate_Z = param(9:10);
                param_rate_P = param(11:12);

            end;

        param = [param_erro_N,param_erro_Z,param_erro_P,param_rate_N,param_rate_Z,param_rate_P];
    end
    
    
    
    if (FuzzyType == 'T2'),
             
        if (FT2Itype == 'L')
            

        elseif (FT2Itype == 'N')
            
        end;
        
    end
    


end



