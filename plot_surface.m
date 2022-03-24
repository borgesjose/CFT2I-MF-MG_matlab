L = 2;

x1=-2*L:0.1:2*L;
x2=-2*L:0.1:2*L;

Am_min = 1; 
Am_max = 5;

A = zeros(length(x1),length(x2));
%%

%%

%%

for i=1:length(x2), % De 1 até o No. total de medidas da variavel linguistica...
 for j=1:length(x1),
      Am(j)=Inferencia(x1(j),x2(i),L,'LI');
      %Am(j) = Inferencia_T2(x1(j),x2(i),L,Param,'NLI');  % pertinencia aos conjuntos fuzzy (curvatura)
      %Ami = Inferencia_T2_SB(x1(i),x2(j),L,Param,'NLI');
      %Am(j) = Ami*Am_max + Am_min*(1 - Ami);
 end
 A(i,:) = Am;
end
%%
figure;
surf(x1,x2,A)
