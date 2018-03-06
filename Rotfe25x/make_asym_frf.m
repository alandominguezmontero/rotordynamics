%make_asym_frf.m
%
% File for the asym paper 2002
% IB

R=rotfe('asym51');

%---------------> take only linear DOFs

R.RNodeDir=[[1:21]+.1 [1:21]+.3]';

R.FNodeDir=8.1;

R.SPRINGS(2,3)=1000000/2;

 R.DASHPOTS=[1 1000 500;11 500 500 ; 21 500 500];
 
 
R=rotfe(R);

 

  [a b c d]=rot2ss(R,1000/60*2*pi);
  
   sys=ss(a,b,c,d);
   sysf=frd(sys,linspace(1,1000,2000)*2*pi');
   
   [i1 d1]=min(abs(sysf.Frequency-210.4))
   
   
   figure(1)
   semilogy(sysf.Frequency,abs(squeeze(sysf.ResponseData)))
   
   
   figure(2)
   clf
     H=squeeze(sysf.ResponseData);
    %ix=roteqn1([1:21]'+.1,[],R.dim,1);
    %iy=roteqn1([1:21]'+.3,[],R.dim,1)
      ix =1:21; iy=22:42;
    H=H(ix,:)+i*H(iy,:);
 %   q=1; h=plot3(R.NODES,real(H(:,q))*0,imag(H(:,q))*0,'-.');
  %  hold on
   %     axis auto
    q=1000; h=plot3(R.NODES,real(H(:,q)),imag(H(:,q)));
        mx=max(abs((H(:))));
        axis([-inf inf [-1 1 -1 1]*mx])
    set(h,'linewidth',3)
    set(h,'erasemode','xor','color','w')
     set(gca,'drawmode','fast')
     
   for q=1:size(H,2)
%       set(h,'ydata',real(H(:,q)),'zdata',imag(H(:,q)),'color','b')
       subplot(2,2,1)
     %  plot3(R.NODES,real(H(:,q)),imag(H(:,q)),'linewidth',5)
     draw_plane
       subplot(2,2,2)
             plot(real(H(:,q)),imag(H(:,q)),'linewidth',5)
 subplot(2,2,3)
             plot(real(H(:,q)),'linewidth',5)
 subplot(2,2,4)
             plot( imag(H(:,q)),'linewidth',5)
 
       drawnow
   end
   