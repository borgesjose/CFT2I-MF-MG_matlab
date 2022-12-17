function param = opt_PSO(FuzzyType,FT1type,FT2Itype,L,pso)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Universidade Federal do Piauí                       %
% Campus Ministro Petronio Portela                    %
% Copyright 2022 -José Borges do Carmo Neto-          %
% @author José Borges do Carmo Neto                   %
% @email jose.borges90@hotmail.com                    %
%  -- Otimização de funções de pertinenecia de um     %
% Cont. Fuzzy Tipo 2 com Particle Swarm Optimization  %
%  -- Version: 1.0  - 03/07/2022                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Particle Swarm Optimization:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
folderName = pso.folder
noP = pso.noP; 
maxIter = pso.maxIter; 
dataVis = pso.visFlag;


% ub = pso.ub;
% lb = pso.lb;
fobj = pso.fobj;

wMax = pso.wMax;
wMin = pso.wMin; 
c1 = pso.c1; 
c2 = pso.c2; 


        if (FuzzyType == 'T1'),
            
            if (FT1type == 'L')
                nVar = 14;
                ub = [0,0, L,L,L, L,L, 0,0, L,L,L, L,L];
                lb = [-L,-L, -L,L,-L, 0,0, -L,-L, -L,-L,-L, 0,0];
                
            elseif (FT1type == 'N')
                
                nVar =  12;
                ub = [1,0, L,L, 1,2*L,  1,0, L,L, 1,2*L];
                lb = [0,-2*L, -L,-L, 0,0, 0,-2*L, -L,-L, 0,0];
    
            end;
            
            
         elseif (FuzzyType == 'T2'),
            
            if (FT2Itype == 'L')
                
                nVar =  16;
                ub = (2*L) * ones(1, nVar);
                lb = -(2*L) * ones(1, nVar);
                
            elseif (FT2Itype == 'N')
                
                nVar =  12;
                ub = (L) * ones(1, nVar);
                lb = -(L) * ones(1, nVar);
                
            end;
        end

         %ub = (2*L) * ones(1, nVar);
         %lb = -(2*L) * ones(1, nVar);
         
         vMax =  (ub - lb).*0.2;
         vMin =  -vMax;

         
% Extra variables for data visualization
average_objective = zeros(1, maxIter);
cgCurve = zeros(1, maxIter);
FirstP_D1 = zeros(1 , maxIter);
position_history = zeros(noP , maxIter , nVar );        


%% Step1: Randomly initialize Swarm population of N particles

for k = 1 : noP
    Swarm.Particles(k).X = sort((ub-lb) .* rand(1,nVar) + lb);%eval_candidates((ub-lb) .* rand(1,nVar) + lb, FuzzyType, FT1type,FT2Itype);
    Swarm.Particles(k).V = zeros(1, nVar);
    Swarm.Particles(k).PBEST.X = zeros(1,nVar);
    Swarm.Particles(k).PBEST.O = inf;
    
    Swarm.GBEST.X = zeros(1,nVar);
    Swarm.GBEST.O = inf;
end

for t = 1 : maxIter
    
    % Calcualte the objective value
    for k = 1 : noP
        
        currentX = Swarm.Particles(k).X;
        position_history(k , t , : ) = currentX;
        
        script_PID_FXX_FG_PSO;
        Mp = max(h);
        Swarm.Particles(k).O = 2*Mp + fobj(erro,tempo,'ITAE');%fobj(erro,tempo,'ITAE');%fobj(currentX);
        average_objective(t) =  average_objective(t)  + Swarm.Particles(k).O;
        
        % Update the PBEST
        if Swarm.Particles(k).O < Swarm.Particles(k).PBEST.O
            Swarm.Particles(k).PBEST.X = currentX;
            Swarm.Particles(k).PBEST.O = Swarm.Particles(k).O;
        end
        
        % Update the GBEST
        if Swarm.Particles(k).O < Swarm.GBEST.O
            Swarm.GBEST.X = currentX;
            Swarm.GBEST.O = Swarm.Particles(k).O;
        end
    end
    
    % Update the X and V vectors
    w = wMax - t .* ((wMax - wMin) / maxIter);
    
    FirstP_D1(t) = Swarm.Particles(1).X(1);
    
    for k = 1 : noP
        Swarm.Particles(k).V = w .* Swarm.Particles(k).V + c1 .* rand(1,nVar) .* (Swarm.Particles(k).PBEST.X - Swarm.Particles(k).X) ...
            + c2 .* rand(1,nVar) .* (Swarm.GBEST.X - Swarm.Particles(k).X);
        
        
        % Check velocities
        index1 = find(Swarm.Particles(k).V > vMax);
        index2 = find(Swarm.Particles(k).V < vMin);
        
        Swarm.Particles(k).V(index1) = vMax(index1);
        Swarm.Particles(k).V(index2) = vMin(index2);
        
        Swarm.Particles(k).X = Swarm.Particles(k).X + Swarm.Particles(k).V;
        
        % Check positions
        index1 = find(Swarm.Particles(k).X > ub);
        index2 = find(Swarm.Particles(k).X < lb);
        
        Swarm.Particles(k).X(index1) = ub(index1);
        Swarm.Particles(k).X(index2) = lb(index2);
        
        %Check construction:
        Swarm.Particles(k).X = sort(Swarm.Particles(k).X);
        %Swarm.Particles(k).X = eval_candidates(Swarm.Particles(k).X,FuzzyType,FT1type,FT2Itype);
        
    end
    
    if dataVis == 1
        outmsg = ['Iteration# ', num2str(t) , ' Swarm.GBEST.O = ' , num2str(Swarm.GBEST.O)];
        disp(outmsg);
    end
    
    cgCurve(t) = Swarm.GBEST.O;
    average_objective(t) = average_objective(t) / noP;
    
    fileName = ['Resluts after iteration # ' , num2str(t)];
    trail = ['./results/PS/',folderName];
    if (~exist(trail)) mkdir(trail);end   
    save( [trail,'/',fileName])
    
end
%%
GBEST = Swarm.GBEST;
param = GBEST.X
figure;
plot(cgCurve);
xlabel('Iteração');
ylabel('J1');
title(['Convergence Performance'])

                if (FuzzyType == 'T1'),
                    
                    plot_pertinencia_T1(param,FT1type,L)
                    
                end
                
                if (FuzzyType == 'T2'),
                    
                    plot_pertinencias_T2(param,FT2Itype,L)
                    
                end
 %%       
end