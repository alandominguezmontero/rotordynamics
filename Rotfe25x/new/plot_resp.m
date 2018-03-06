function plot_resp(Rot,q,INTERACTIVE);



if isstr(Rot),
    if strcmp(get(gcf,'tag'),'RotModel')  % 
        h=findobj('tag','deflection');
        Wx=get(gcf,'userdata');
        xy=get(gca,'CurrentPoint');
         yu = interp1(Wx(:,1),Wx(:,2),xy(1)); 
         yv = interp1(Wx(:,1),Wx(:,3),xy(1)); 
         
        title(sprintf('u=%g [mm]  v=%g [mm]',abs(yv)*1e3,abs(yu)*1e3))
        drawnow
    end
else,
  [Wu,Wv,x,v2]=rotmshape(q,Rot);
   if all(real(Wu)==0) & all(real(Wv)==0)
      Wu=i*Wu; Wv=i*Wv;
   end

drawrot(Rot.File); hold on, 
      axis normal,
      ax=axis;
      x1=min(min(Rot.NODES(Rot.ELEMENTS(:,[1 2]))));
      x2= max(max(Rot.NODES(Rot.ELEMENTS(:,[1 2]))));
      
      Lt=norm(Rot.NODES)/length(Rot.NODES);			% typical length
      dx=ax(2)-ax(1);  dy=ax(4)-ax(3); 
      set(gca,'xlim',[x1-Lt/15 x2+Lt/15 ]);
      s=20;
      mx=max(ax(3:4)); %axis([ax(1)-dx/s ax(2)+dx/s ax(3)-dy/s ax(4)+dy/s]);      
      scl=mx/max(abs([eps;real(Wu(:)); real(Wv(:))]));
      h=plot(x,real(Wu)*scl*2.5,'r-',x, real(Wv)*scl/1.5,'m-'	,[min(x)-dx/s max(x)+dx/s],[0 0],'k-.');
      set(h , 'linewidth',2 ); set(h(end),'linewidth',.6 );
      ylabel('X and Y deflections'); 
       set(h,'tag','deflection','ButtonDownFcn',....
           'plot_resp(''disp'')');
       axis equal
       set(gcf,'userdata',[x Wu Wv]);
   end