function drawrot(File,CallBack,draw_cg)
%drawrot template [nodes] [draw_Cg]
% or
%drawrot template any_third_argument any_4th
%
%Description
% draw the layout of a rotor template file
% if used with a 3rd input argument the plot becomes
% click-sensitive, i.e. when clicked the properties
% of each element are displayed
%
% Copyright by
% I. Bucher September 1998
% 
% Rev 1.01  03-Sep-2000,  with a 3rd input arg. draws the location of the CG

cla, view(2)
cQ=0; nQ=0;
if isa(File,'struct'),
   Rot=File;
else
   [name ext]=nameext(File);
   title(File);
   Rot=rotfe(name);  				% run model
   %    eval(name);    
end

if nargin>1,
   cQ=1;  
   if isstr(CallBack),
      if strcmp(lower(CallBack(1:3)),'nod'),
         nQ=1;
      end
   end
   
   if nargin<3,
      set(gcf,'userdata',Rot,'tag','RotModel')
   end
   
end

cD=0;  
   if nargin>2,
      if isstr(draw_cg),
      	cD=1;
   end
   end
   
[ne m]=size(Rot.ELEMENTS);
Lt=norm(Rot.NODES)/ne;			% typical length
Dt=norm(Rot.ELEMENTS(:,3))/(ne); %typical diameter

% >>>>> Draw elements
for q=1:ne,
   do=Rot.ELEMENTS(q,3);   di=Rot.ELEMENTS(q,4); 
   x1=Rot.NODES(Rot.ELEMENTS(q,1)); 
   x2=Rot.NODES(Rot.ELEMENTS(q,2)); 
   
   x=[x1 x2 x2 x1];
   y1=[di/2 di/2 do/2 do/2];
   c=Rot.ELEMENTS(q,5);
   h1=patch(x,y1,c);
   h2=patch(x,-y1,c);
   setCback(cQ,'Element' ,[h1 h2  ],q)
end


% >>>>> Draw Discs
[nd tmp]=size(Rot.DISCS);
Do_max=0;
for q=1:nd,
   x1=Rot.NODES(Rot.DISCS(q,1));	% center coords
   Do=Rot.DISCS(q,2);   Di=Rot.DISCS(q,3);
   W=Rot.DISCS(q,4);
   c=Rot.DISCS(q,5);
   x=[x1-W/2 x1+W/2 x1+W/2 x1-W/2];
   y=[Di/2 Di/2 Do/2 Do/2];
   h1=patch(x,y,c);
   h2=patch(x,-y,c);
   setCback(cQ,'Disc' ,[h1 h2  ],q)
   Do_max=max(Do_max,Do);
end

% >>>>> Draw Springs
[ns tmp]=size(Rot.SPRINGS);
for q=1:ns,
   x1=Rot.NODES(Rot.SPRINGS(q,1));	% center coords
   x=[x1-Dt/4 x1+Dt/4 x1+Dt/4 x1-Dt/4];
   c=[1 1 1];
   y=[0 0 Dt*4 Dt*4];
   h1=patch(x,y,c);
   h2=patch(x,-y,c);
   x=[x1-Dt*2 x1+Dt*2 x1+Dt*2 x1-Dt*2];
   y=[Dt*4 Dt*4 Dt*5 Dt*5];
   h3=patch(x,y,c);
   h4=patch(x,-y,c);
   
   setCback(cQ,'Spring' ,[h1 h2 h3 h4],q)
end

% >>>>> Draw BC
[nb tmp]=size(Rot.BCNodeDir(:));
for q=1:nb,
   x1=Rot.NODES(fix(Rot.BCNodeDir(q)));	% center coords
   c=[1 1 1];
   x=[x1 x1-Dt*2 x1+Dt*2  ];
   y=[0  Dt*4 Dt*4 ];
   h1=patch(x,y,c);
   h2=patch(x,-y,c);
   setCback(cQ,'BC' ,[h1 h2  ],fix(Rot.BCNodeDir(q)))
end

% >>>>> Draw Point mass
if isfield(Rot,'POINT_MASS')
[np tmp]=size(Rot.POINT_MASS);
for q=1:np,
   x1=Rot.NODES(Rot.POINT_MASS(q,1));	% center coords
   c=[1 0 0];
   theta=[0:11]'*2*pi/12;
   x=[x1+Dt*2*cos(theta) ];
   y=[+Dt*2*sin(theta)];
   h1=patch(x,y,c);
   setCback(cQ,'Pmass' ,[h1   ],Rot.POINT_MASS(q,1))
end
end
if nQ
   do_max=max( Rot.ELEMENTS(:,3) );
   if Do_max>do_max, do_max=mean([Do_max do_max]); end
   p=0;
   for q=1:length( Rot.NODES ),
      x1=Rot.NODES(q);
      h=text(x1,do_max/1.4+p*do_max/10,int2str(q));
      p=1-p;
      set(h,'fontname','arial','fontsize',11,'HorizontalAlignment','center');
   end   
end

% >>>>> Draw cg
if cD
   [mass zcg]=rotmicg(Rot);
	c=[0 0 0]+1;
   theta=[0:11]'*2*pi/12;
   x=[zcg+Dt*cos(theta) ];
   y=[+Dt*sin(theta)];
   h1=patch(x,y,c);
   h21(1)=line([zcg-Dt zcg+Dt],[0 0]);
   h21(2)=line([zcg zcg],[-Dt Dt]);
   set(h21,'color','k','linewidth',3);
 %     title(sprintf('%s, mass=%g',File,mass));
end

   

axis equal
axis off
figure(gcf)

drawnow

function setCback(cQ,Part,h,q)
%set callback properties for part (element, disc, etc.)

if cQ
   name=[Part int2str(q)];
   set(h,'tag',name)
   cBACK=['DispRotInfo(' '''' Part '''' ',' int2str(q) ')'] ;
   set(h,'ButtonDownFcn',cBACK);
end
