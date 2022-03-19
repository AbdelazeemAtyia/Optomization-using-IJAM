%**********************
% this code was wrritten by Abdelazeem H. Atyia to find the parameters of
% the IJAM
%***********************
clc
clear 
close all

global Hm Bm n_points  
 
load Hm_65f;load Bm_65A;% the measured data of the material
 load pp; %the initial parameters 
    P35_OJ=pp;
  Hm= Hm_65f(:,8);Bm=Bm_65A(:,8);
   
      %% this condition to make -Hmax=Hmax 
    % to make max of H in +ve and -ve side equal
    [val1, idx1] = max(Hm(:,end));%+ve part of H
    [val2, idx2] = max(abs(Hm(:,end)));%-ve part of H
   %  Hm(idx2,end)=-val1;
    if val2>val1
    Hm(idx1,end)=val2;
    else
    Hm(idx2,end)=-val1;
    end
   %%
   x = [P35_OJ(1:5)];% the initial parameters to start simulation
 Ms=x(1); 
k=x(2);
c=x(3);
alpha=x(4);
a=x(5); 
   
    
n_points = length(Hm);
mu0=4*pi*10^-7;

 
nr=10;% the number of repeated loops of Hm,and Bm
  Hm=repmat(Hm,[nr,1]);Bm=repmat(Bm,[nr,1]);
 


perc_Ms = 0.9;
 perc_k = 1.2;
 perc_c = 0.3;
perc_alpha = 1.5;
perc_a = 1.5;

Lbx=[Ms-Ms*perc_Ms k-k*perc_k c-c*perc_c alpha-alpha*perc_alpha a-a*perc_a];
Ubx=[Ms+Ms*perc_Ms k+k*perc_k c+c*perc_c alpha+alpha*perc_alpha a+a*perc_a];

 %%%%%%%%%%%%%%%%
PARA=[Ms, k, c, alpha, a];

options=psoptimset('MaxIter',25,'Display','iter','CompletePoll','On', ...
    'PollingOrder','Success','InitialMeshSize',1,'ScaleMesh','On','TolX',0,'TolFun',0);
[PARA,fval,exit_flag] = fmincon(@opt_cost,PARA,[],[],[],[],Lbx,Ubx,[],options);
 





