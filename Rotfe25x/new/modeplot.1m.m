function modeplot1(FILE,arg1,arg2)  
% [phi,lambda,fb]=modeplot1(FILE,W1,W2,N,P5) 
%   
%
% INPUTS:
%	FILE:   input file, can be template.m (Script) or template.mtx (*.mat)
%	W:	speed of rotation [Rad/s] (default is W=0)
%	TYPE:	type of eigenproblem to be solved
%		TYPE=0,  undamped (default)
%		TYPE=1,  external (non-rotating) damping
%		TYPE=2,  general (rotating hysteretic + non-rotating viscous) damping
% EXAMPLES:
%	 [phi,lambda,fb]=rotmodes('template');  % runs rotfe('template'), 
%						% assumes W=0

% By  I. Bucher  8-9-1998  Rev. 2.0
%                29-7-99   Rev. 2.1  now treats reduced models too

if nargin<1, FILE='simple1s'; end
tool=mfilename;
if isa(FILE,'struct'), 
   for q={'M' 'K' 'G' 'KH' 'Kst' 'D'} % those are too big and unecessary
      try, FILE=rmfield(FILE,q); end
   end
   rot2templ(FILE,'temporary1.m')
   FILE='temporary1';
end

if strcmp(FILE,'go'),
   fig=findobj('tag',[tool 'fig']);
   hfile=findobj('tag',[tool  'file']);  file=get(hfile,'string');
   Rot=rotfe(file);
   hed=findobj('tag',[tool  'modeN']); 
   set(hed,'visible','on');
   hN=findobj('tag',[tool  'N']);  set(hN,'visible','on');
   hcomp=findobj('tag',[tool  'compute']); 
   CoL=get(hcomp,'value');
   hW=findobj('tag',[tool  'W']);  
   cmd=['W=2*pi/60*' get(hW,'string') ';']; FAIL='W=0;';
   eval(cmd,FAIL);
   critspeed=get(  findobj('tag',   [tool 'critspd']), 'value')>1;
   Rot.W=max([eps W]);
   if critspeed, [phi lambda]=roteig(Rot,1);
   else, [phi lambda]=roteig(Rot); end
   Rot.eigenvector=phi; Rot.eigenvalue=abs(lambda);  
   set(fig,'userdata',Rot);
   Nm=length(lambda);
   S=sprintf('1: %g [Hz] ',100\round((abs(lambda(1)))/2/pi*100));
   for q=2:Nm, S=str2mat(S,sprintf('%d: %g [Hz]',q,100\round((abs(lambda(q)))/2/pi*100))); end
   set(hed,'string',S,'value',1);
   
   modeplot1('display')
   
elseif strcmp(FILE,'modeplus') 
   hed=findobj('tag',[tool  'modeN']); 
   V=get(hed,'string');
   N=size(V,1);
   n=min(get(hed,'value')+1,N);
   set(hed,'value',n);   modeplot1('display')
   %>>>>>>>>>>>>>>>>>>>>>>>
elseif strcmp(FILE,'modeminus') 
   hed=findobj('tag',[tool  'modeN']); 
   V=get(hed,'string');
   N=size(V,1);
   n=max(get(hed,'value')-1,1);
   set(hed,'value',n);  modeplot1('display')
   
   %<><><>??<><><>??<>
elseif strcmp(FILE,'keepT')   
   h=findobj('tag',[tool  'keepT']);  
   trans=get(h,'userdata');
   
   trans.toggle=~trans.toggle;
   
   if trans.toggle
      trans.T=view;       
      set(h,'string','view kept')
   else
      set(h,'string','auto view')
   end
   set(h,'userdata',trans);
   % <><><><><><><><><><><><>
elseif  strcmp(FILE,'display'),
   hed=findobj('tag',[tool  'modeN']);  n=get(hed,'value');
   hN=findobj('tag',[tool  'N']);   p3D=get(hN,'value')==1;
   hp=findobj('tag',[tool 'plane']); hc=findobj('tag',[tool 'Circ']);    
   pQ=get(hp,'value'); cQ=get(hc,'value');
   fig=findobj('tag',[tool 'fig']);
   Rot=get(fig,'userdata');
   if ~isa(Rot,'struct'), return, end
   ax=findobj('tag',[tool 'ax']);  % get the right axis
   [Wu,Wv,x,v2]=rotmshape(Rot.eigenvector(:,n),Rot);
   if all(real(Wu)==0) & all(real(Wv)==0)
      Wu=i*Wu; Wv=i*Wv;
   end
   
   [ws whatwhirl]  =   whirldir(v2);
   lambda=abs(Rot.eigenvalue);
   if p3D,
       NP=8-4*(size(Rot.ELEMENTS,1)>8)+4*(size(Rot.ELEMENTS,1)<5);
      rotmshape3(Rot.eigenvector(:,n),Rot,NP,pQ,cQ);
      zoom off, rotate3d on,
      hT=findobj('tag',[tool  'keepT']);  
      trans=get(hT,'userdata');
      if trans.toggle,view(trans.T); end
      set(gcf,'renderer','zbuffer')
      drawnow
   else,
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
      rotate3d off, view(2),zoom on; hold off, axis equal
   end
   fr=100\round((lambda(n))/2/pi*100);  
   critspeed=get(  findobj('tag',   [tool 'critspd']), 'value')>1;
   if critspeed
      title(sprintf('mode-%d  f=%6.2f Hz %s Speed=%.0f RPM',n,fr,whatwhirl,fr*60));
   else 
      title(sprintf('mode-%d  f=%6.2f Hz %s Speed=%.0f RPM',n,fr,whatwhirl,Rot.W*60/2/pi));
   end
   % <><><><>
elseif  strcmp(FILE,'save'),
   fig=findobj('tag',[tool 'fig']);
   Rot=get(fig,'userdata');
   if (~isa(Rot,'struct')) , 
      warndlg('unable to save in file','Saving failed')
      return, 
   end
   
   switch arg1
   case 1,   [fname,pname] = uiputfile('*.mat','Choose file name');
      if (fname(1)==0), warndlg('unable to save in file','Saving failed'), return,end
      cmd=['save ' pname fname ' Rot' ];
      err=0; eval(cmd,'err=1;');
   case 2, 
      [fname,pname] = uiputfile('*.*','Choose file name') ;
      if (fname(1)==0), warndlg('unable to save in file','Saving failed'), return,end
      modes=Rot.eigenvector; modesRE=real(modes);  modesIM=imag(modes); 
      frequencies=abs(Rot.eigenvalue);
      cmd=['save ' pname fname '.mod modesRE modesIM -ascii ' ];
      err=0; eval(cmd,'err=1;');  
      cmd=['save ' pname fname '.frq frequencies  -ascii ' ];
      eval(cmd,'err=1;');  
   end
   if err, warndlg('unable to save in file','Saving failed'), return,end
   msgbox([' Saved in ' fname ' sucessfully'])
   
   %<><><><><><>   
elseif strcmp(FILE,'newfile')
   h = findobj(gcf,'tag','modeplot1file');
   FILE=get( h, 'string');
   try
      drawrot(FILE); axis auto
   catch
      title('Use existing Template File')
   end
   
   
   %<><><><><><>   
else, % init
   
   fig=findobj('tag',[tool 'fig']);
   if length(fig)==0, 
      fig=figure('unit','normal','pos',...
         [0.0100    0.1    0.6000    0.8],...
         'tag',[tool 'fig'],'menubar','none',...
         'name','mode shapes',...
         'numbertitle','off'); 
      
   else, figure(gcf), clf reset,  
      %      return
   end
   ax=axes; set(ax,'tag',[tool 'ax'])
   set(gca,'unit','normal','pos',[.1 .45 .8 .5]); axis off
   feval('drawrot',FILE);
   % ----------------------------------------------------------------------
   f=uimenu(gcf,'label','Save Modes/Frequencies');
   uimenu(f,'Label','Save in .Mat file','callback',[tool '(''save'',1)']);
   uimenu(f,'Label','Save in ascii format','callback',[tool '(''save'',2)']);
   
   goahead=[tool '(''go'');'];
   uicontrol('style','frame',...
      'foregroundcolor','w',...
      'unit','normal','pos',[.01 .01 .89 .39],...
      'backgroundcolor','b');
   uicontrol('style','text',...
      'string','  Template file (model)',...
      'unit','normal','pos',[.03 .19 .5 .08],'units','normalized',...
      'backgroundcolor','y');
   
   %   cb=[ 101 118 97 108 40 91 39 70 73 76 69 61 103 101 116 40 102 105 110 100 111 98 106 40 103 99 102 44 39 39 116 97 103 39 39 44 39 39 109 111 100 101 112 108 111 116 102 105 108 101 39 39 41 44 39 39 115 116 114 105 110 103 39 39 41 59 32 100 114 97 119 114 111 116 40 70 73 76 69 41 59 32 97 120 105 115 32 97 117 116 111 39 93 44 91 39 32 116 105 116 108 101 40 39 39 85 115 101 32 101 120 105 115 116 105 110 103 32 84 101 109 112 108 97 116 101 32 70 105 108 101 39 39 41 39 93 41 59];
   cb=['modeplot1(''newfile'')'];
   uicontrol('style','edit',...
      'string',FILE,'units','normalized',...
      'pos',[.55 .19 .15 .08],...
      'tag',[tool 'file'],...
      'callback',setstr(cb)  ,...
      'backgroundcolor','w'); 
   uicontrol('style','text',...
      'string','  Speed of rotation (RPM)',...
      'units','normalized','pos',[.03 .19+.094 .5 .08],...
      'backgroundcolor','y');
   uicontrol('style','edit',...
      'string','0.0','units','normalized',...
      'pos',[.55 .19+.094 .15 .08],...
      'tag',[tool 'W'],...
      'backgroundcolor','w'); 
   uicontrol('style','text',...
      'string',' show mode number',...
      'units','normalized','pos',[.03 .09 .5 .08],...
      'backgroundcolor','y');
   h1= uicontrol('style','popup',...
      'string','0','units','normalized',...
      'pos',[.55 .1 .18 .08],...
      'tag',[tool 'modeN'],...
      'callback',[tool '(''display'');'],...
      'backgroundcolor','w');
   h1m= uicontrol('style','push',...
      'string','--','units','normalized',...
      'pos',[.55 .1-0.02 .05 .05],...
      'tag',[tool 'modeminus'],...
      'callback',[tool '(''modeminus'');'],...
      'backgroundcolor','w');
   h1p= uicontrol('style','push',...
      'string','-|-','units','normalized',...
      'pos',[.55+.07 .1-0.02 .05 .05],...
      'tag',[tool 'modeplus'],...
      'callback',[tool '(''modeplus'');'],...
      'backgroundcolor','w');
   h2=uicontrol('style','check',...
      'string','3D','units','normalized',...
      'pos',[.55 .03 .15 .045],...
      'tag',[tool 'N'],...
      'callback',[tool '(''display'');'],...
      'backgroundcolor','w');
   uicontrol('style','push',...
      'string','GO','units','normalized',...
      'pos',[.72 .03 .16 .1],...
      'callback',goahead);
   uicontrol('style','pop',...
      'string','compute|load','units','normalized',...
      'pos',[.72 .26 .16 .1],...
      'tag',[tool 'compute'],...
      'callback',[tool '(''display'');'] );
   uicontrol('style','pop',...
      'string','modes|crit. speed','units','normalized',...
      'pos',[.72 .16 .16 .1],...
      'tag',[tool 'critspd'] );
   
   uicontrol('Value',1, ...
      'Units','points', ...
      'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
      'Position',[10 14.25 80.75 15], ...
      'String','Circles plot', ...
      'Style','radiobutton',...
      'callback',[tool '(''display'');'] ,...
      'tag',[tool 'Circ']);  
   uicontrol( 'Value',1, ...
      'Units','points', ...
      'Position',[103.25 14.25 86 15], ...
      'String','Show mode plane', ...
      'Style','radiobutton', ...
      'callback',[tool '(''display'');'] ,...
      'tag',[tool 'plane']);  
   
   
   
   trans.T=eye(4); trans.toggle=0;
   uicontrol( 'Value',1, ...
      'Units','points', ...
      'unit','normal',...
      'Position',[.9 .94 .1 .05], ...
      'String','Keep view', ...
      'Style','push', ...
      'userdata',trans,...
      'callback',[tool '(''keepT'');'] ,...
      'tag',[tool 'keepT']);  
   
   set([h1 h2],'visible','off');
   % ---------------------------------------------------------------------------------
   
end


