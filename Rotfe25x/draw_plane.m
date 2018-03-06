

%q=1000
 z=R.NODES';
 Wu=real(H(:,q));
 Wv=i*imag(H(:,q));
 
[wx wy]=animate2(Wu,Wv,12);
wx=0.9*wx;  wy=0.9*wy;
 
   plot3(z,wx(:,1),wy(:,1),'-b','linewidth',4); hold on
   dx=max(z)-min(z);
   plot3(z,0*wx(:,1),0*wy(:,1),'-.r','linewidth',1); hold on, 
   hpQ=plot3([z z]',[1;0]*wx(:,1)',[1;0]*wy(:,1)','-m','linewidth',.7); hold on
   hpQ1=surf([z z]',[1;0]*wx(:,1)',[1;0]*wy(:,1)');
   set(hpQ1,'FaceLighting','phong','FaceColor','interp',...
      'AmbientStrength',0.5,'EdgeColor','interp')
   
             light('Position',[12 1/2 1/2],'Style','infinite');
             
             
N=length(z); p=fix(N/10); p=1; 
[mm nn]=size(wx);
hold on
hcQ=plot3( ones(nn,1)*z(1:p:N)' , wx(1:p:N,:)', wy(1:p:N,:)','color',[0 .5 0],'linewidth',0.4);
 
hold off, 
ax=axis;
 MAX=max(ax(3:6));  MIN=min(ax(3:6));  
 
   axis([ax(1:2) MIN MAX MIN MAX])