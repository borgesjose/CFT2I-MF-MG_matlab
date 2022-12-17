function [gene] = opt_AG(FuzzyType,FT1type,FT2Itype,L,ag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Universidade Federal do Piauí                       %
% Campus Ministro Petronio Portela                    %
% Copyright 2018 -José Borges do Carmo Neto-          %
% @author José Borges do Carmo Neto                   %
% @email jose.borges90@hotmail.com                    %
%  -- Otimização de funções de pertinenecia de um     %
%  controlador fuzzy tipo 2 com algoritmos geneticos  %
%  -- Version: 1.0  - 07/03/2019                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Algoritmo genetico:
dataVis = ag.visFlag;
folderName = ag.folder;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Definições do AG
%Parametro de reprodução:

   prob_mutation = ag.prob_mutation;%rand(1);
   prob_crossover = ag.prob_crossover;%rand(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CODIFICAÇÃO:Real
geracoes = ag.geracoes;
fobj = ag.objfunction
%%
%PASSO 1: 
    %INICIAR A POPULAÇÃO:
        populacao_size = ag.populacao_size; %defino o tamanho da população
        populacao = {};% crio a cell que sera a minha população
        N_mais_aptos = ag.N_mais_aptos; %Numero dos individuos mais aptos que serão salvos para a proxima geração.

        
        if (FuzzyType == 'T1'),
            
            if (FT1type == 'L')
                gene_size = 14;
                
                ub = [0,0, 2*L,2*L,2*L, 2*L,2*L, 0,0, 2*L,2*L,2*L, 2*L,2*L];
                lb = [-2*L,-2*L, -2*L,-2*L,-2*L, 0,0, -2*L,-2*L, -2*L,-2*L,-2*L, 0,0];
                
            elseif (FT1type == 'N')
                
                gene_size = 12;
                ub = [1,0, L,L, 1,2*L,  1,0, L,L, 1,2*L];
                lb = [0,-2*L, -L,-L, 0,0, 0,-2*L, -L,-L, 0,0];
    
            end;
            
            
         elseif (FuzzyType == 'T2'),
            
            if (FT2Itype == 'L')
                
                gene_size = 16;
                ub = (L) * ones(1, gene_size);
                lb = -(L) * ones(1, gene_size);
                
            elseif (FT2Itype == 'N')
                
                gene_size = 12;
                
            end;
        end
        
        %ub = (L);%limite superior
        %lb = -(L);%limite inferior
        
        for j=1:populacao_size %A criação da população 
           
           genetic_code = [];
           score = 0;
           if (FuzzyType == 'T1')
               xx = [-L,0,-L,0,L,0,L,-L,0,-L,0,L,0,L];

               for i=1:gene_size
                    new_gene = xx(i)+rand;%abs(xx(i)+rand)

                    genetic_code = [genetic_code , new_gene;];

                populacao{j,1} = genetic_code;
                populacao{j,2} = score;
               end
               
           else
               for i=1:gene_size
                   
                    new_gene = abs(rand);
                    genetic_code = [genetic_code , new_gene;];

                populacao{j,1} = genetic_code;
                populacao{j,2} = score;
               end
           
           end;
          
            %if(new_gene<lb) new_gene=lb;end;
            %if(new_gene>ub) new_gene=ub;end;
             %saturation:
            index1 = find(populacao{j,1} > ub);
            index2 = find(populacao{j,1} < lb);

            populacao{j,1}(index1) = ub(index1);
            populacao{j,1}(index2) = lb(index2);
            populacao{j,1} = sort(populacao{j,1});
            %populacao{j,1} = eval_candidates(populacao{j,1},FuzzyType,FT1type,FT2Itype);
            
        end
        
thebest = populacao(j,:);
memoria_thebest(1,:)= thebest;



%% PASSO 2:%Criar o loop de evolução:
convergencia = 0;
geracao = 1;
while convergencia == 0,
    
     % Avaliação dos individuos da população:
    
    for hh=1:populacao_size %Etapa de avaliação da população para o AG   
        script_PID_FXX_FG; %Chama o script com o controlador implementado
        Mp = max(h);
        J= 2*Mp + fobj(erro,tempo,'ITAE');
        populacao{hh,2} = (1/J)*10^4;
    end
    
  % Retorna um vetor com os valores dos cromossomos do melhores e outro com a cell contendo os melhores e seu score
    [mais_aptos teste] =  selecao_natural(populacao,N_mais_aptos);
    
  %Testar e salvar do melhor individuo já encotrado:
                v =  teste(1,:);
                if thebest{1,2} < v{1,2}
                    thebest = teste(1,:);
                end
                memoria_thebest(geracao,:) = thebest;
 %% PASSO 3:
    %Seleção, Reprodução e Mutação:
              
                filhos = reproducao(populacao,mais_aptos,populacao_size,prob_crossover,FuzzyType,FT1type,FT2Itype,lb,ub);%Reprodução dos individuos mais aptos
                populacao = mutacao(populacao,prob_mutation,FuzzyType,FT1type,FT2Itype,lb,ub);% Realiza a mutação sobre individuos da população
                resto = escolher_resto(populacao,N_mais_aptos,populacao_size); %escolhe os outros valores para a proxima população
                clear populacao; %Limpa populacao
                populacao = [teste;filhos;resto];%cria a proxima população que tera todos os elementos filhos criados com score = 0,
                %portanto a população salva no final da execução do
                %algoritmo possui os primeiros valores como os melhores,
                %seguido de valores com score 0 e seguidos de valores
                %aleatoriso escolhidos da população anterior.
                 
 
 %% PASSO 4: 
 %Teste de parada do algoritmo:
                    if  (isequal(populacao{:,2})| geracao == geracoes), 
                            convergencia = 1;
                            break;
                    end
                    
   if dataVis == 1
        outmsg = ['Generation# ', num2str(geracao) , ' thebest = ' , num2str(thebest{2})];
        disp(outmsg);
   end
    
  fileName = ['Resluts after iteration # ' , num2str(geracao)];
  save( ['./results/AG/',fileName])
    
  %fileName = ['Resluts for AG / ',FuzzyType, ' after generation # ' , num2str(geracao)];
  %save( ['./results/AG/',fileName])
  
  geracao = geracao +1 
end

gene = thebest{1,1}
figure;
plot((1./[memoria_thebest{:,2}])*10^4);
xlabel('Iteração');
ylabel('J1');
title(['Convergence Performance'])


                if (FuzzyType == 'T1'),
                    
                    plot_pertinencia_T1(gene,FT1type,L)
                    
                end
                
                if (FuzzyType == 'T2'),
                    
                    plot_pertinencias_T2(gene,FT2Itype,L)
                    
                end

    fileName = ['Resluts for AG - ', FuzzyType];
    trail = ['./results/AG/',folderName];
    if (~exist(trail)) mkdir(trail);end   
    save( [trail,'/',fileName])

end







