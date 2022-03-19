function [y] = opt_cost(x)
%The cost function for the simulation of 35H279
    global Hm Bm PAR n_points 
  PAR = x;
     mu0=4*pi*10^-7;
    [H,M,B]=loop(Hm,Bm);
      
  plot(Hm(end-n_points:end),Bm(end-n_points:end),'r',H(end-n_points:end),B(end-n_points:end),'b','LineWidth',1.5);
  
drawnow;
  y = mse(H(end-n_points:end)-Hm(end-n_points:end));
end