function pop =  mutacao(populacao,prob_mutation,FuzzyType,FT1type,FT2Itype,lb,ub)

    chromosome_lenght = size(populacao{1,1},2);
    populacao_size = size(populacao,1);
    score = 1./[populacao{:,2}];
    %Mutação:
     for k=1:floor(prob_mutation*size(populacao,1))
         %Selecionar cromossomo para mutação:
            P = score./sum(score);
            index =  Roleta_Russa(P);
            mutante = populacao{index,1};

         %Selecionar pontos de mutação:
            for j=1:8
                ponto = randi([1,chromosome_lenght]);
                u = -0.05 + (0.05+0.05)*rand;
                mutante(ponto) = mutante(ponto)+(u);
                %saturation:
                if(mutante(ponto)<lb) mutante(ponto)=lb;end;
                if(mutante(ponto)>ub) mutante(ponto)=ub;end;
                
            end
            
        mutante =sort(mutante);
       %mutante = eval_candidates(mutante,FuzzyType,FT1type,FT2Itype);
       populacao{index,1}= mutante; 
     end
     pop = populacao;
end