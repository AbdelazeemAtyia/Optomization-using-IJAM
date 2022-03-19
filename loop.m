 function [Hsim,Msim,Bsim]=loop(Hm,Bm);
global     nr    
mu0=4*pi*10^-7;
nr=4;% the number of repeated loops of Hm,and Bm
  Mm=Bm/mu0-Hm;
Msim=zeros(length(Bm),1) ;
Hsim=zeros(length(Bm),1);
  for(j=1:size(Bm,2));
    H=Hm(1,j); 
    M=Mm(1,j); 
    lastHe=0;
      for(i=2:size(Bm,1));
        [H,M]=IJAM(Bm(i,j),Bm(i-1,j),H,M);
         Hsim(i,j)=H;
        Msim(i,j)=M; 
      end
  end
  sf1=max(Hm)/max(Hsim);
  Hsim=sf1.*(Hsim(1:end,1));Bsim=Bm(1:end,1);Msim=Msim(1:end,1);
  end
 
 