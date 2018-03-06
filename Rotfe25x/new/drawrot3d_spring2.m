function drawrot3d(File,CallBack,no_clf )
%drawrot template
% or
%drawrot template any_third_argument
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

if nargin<3, clf, end
set(gcf,'rend','zbuffer')

cQ=0; nQ=0;
if isa(File,'struct'),
   Rot=File;
else
   [name ext]=nameext(File);
   title(File);
   Rot=rotfe(name);  				% run model
   %    eval(name);    
end
if nargin<2, CallBack='    ';end 
if  0,
   cQ=1;  
   if isstr(CallBack),
      if strcmp(lower(CallBack(1:3)),'nod'),
         nQ=1;
      end
   end
   
end
if cQ,    set(gcf,'userdata',Rot,'tag','RotModel'), end
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
   
   h2=draw_cyl([x1;x2],[do/2;do/2],24,c,di/2);
    h1=draw_cyl([x1;x2],[di/2;di/2],24,c,di/2);
  
   %   h1=patch(x,y1,c);
 %  h2=patch(x,-y1,c);
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
%   h1=patch(x,y,c);
 %  h2=patch(x,-y,c);
   h=draw_cyl([x1-W/2;x1+W/2 ],[Do/2 Do/2],32,c,Di/2);
    setCback(cQ,'Disc' ,[h  ],q)

   Do_max=max(Do_max,Do);
end

% >>>>> Draw Springs
[ns tmp]=size(Rot.SPRINGS);
th=linspace(0,2*pi,1000); 
z=linspace(0,1,length(th));
ncoils=7; D3=Dt*2;
for q=1:ns,
    x1=Rot.NODES(Rot.SPRINGS(q,1));	% center coords
   v=Rot.SPRINGS(q,2:5); v=[v(1) v(3);v(4) v(2)];
   [T dd]=eig(v); dd=sqrt(diag(dd)); dd=dd/max(dd);
   h1=line([x1 x1],[-Do_max Do_max]/2 ,[0 0]);
   h2=line([x1 x1],[0 0],[-Do_max Do_max] /2);
    
  draw_spring(x1+D3*cos(ncoils*th),z*Lt,D3*sin(ncoils*th),T);
  draw_spring(x1+D3*cos(ncoils*th),-z*Lt,D3*sin(ncoils*th),T);
   draw_spring(x1+D3*sin(ncoils*th),D3*cos(ncoils*th),z*Lt,T);
   draw_spring(x1+D3*sin(ncoils*th),D3*cos(ncoils*th),-z*Lt,T);
 
   set([h1 h2],'linewidth',3,'linestyle','-.');
   setCback(cQ,'Spring' ,[h1 h2 ],q)
end
% >>>>> Draw BC
[nb tmp]=size(Rot.BCNodeDir(:));

d_shaft_max=max(max(Rot.ELEMENTS(:,3:4)));
for q=1:nb,
   x1=Rot.NODES(fix(Rot.BCNodeDir(q)));	% center coords
   c=[1 1 1];
   z=[x1 x1-Dt*2 x1+Dt*2  x1];
   y=[0  Dt*4 Dt*4 0];
   x=[0 0 0 0];
   h1=plot3(z,x,y);
   h2=plot3(z,x,-y);
   h3=plot3(z,y,x);
   h4=plot3(z,-y,x);

%   set([h1 h2],'facecolor','w');
   setCback(cQ,'BC' ,[h1 h2 h3 h4 ],fix(Rot.BCNodeDir(q)))
end

% >>>>> Draw Point mass
[np tmp]=size(Rot.POINT_MASS);
%d1=max(d_shaft_max/2,Dt/2);
for q=1:np,
   x1=Rot.NODES(Rot.POINT_MASS(q,1));	% center coords
   jj=union(find(Rot.ELEMENTS(:,1)==q),...
             find(Rot.ELEMENTS(:,2)==q));
    d1=max(Rot.ELEMENTS(jj,3))/1.7;
   c=[1 0 0];
   theta=[0:11]'*2*pi/12;
   x=[Dt*2*cos(theta) ];
   y=[+Dt*2*sin(theta)];
   %   h1=patch(x,y,3*x1*ones(size(x)));
   [x y z]=sphere(12);
   h1=surf(x1+z*d1,x*d1,y*d1);
   set(h1,'facecolor','r'); 
   setCback(cQ,'Pmass' ,[h1   ],Rot.POINT_MASS(q,1))
end

if nQ
   do_max=max( Rot.ELEMENTS(:,3) );
   if Do_max>do_max, do_max=mean([Do_max do_max]); end
   p=0;
   for q=1:length( Rot.NODES ),
      x1=Rot.NODES(q);
      h=text(x1,do_max/1.4+p*do_max/10,do_max/1.4+p*do_max/10,int2str(q));
      p=1-p;
      set(h,'fontname','arial','fontsize',11,'HorizontalAlignment','center');
   end   
end

axis equal
axis off
figure(gcf)
hold off
set(findobj('type','surface'),'FaceLighting','phong','FaceColor','interp','AmbientStrength',0.5,'EdgeColor','interp')
            light('Position',[0.9 1 1],'Style','infinite');





function setCback(cQ,Part,h,q)
%set callback properties for part (element, disc, etc.)

if cQ
   name=[Part int2str(q)];
   set(h,'tag',name)
   cBACK=['DispRotInfo3d(' '''' Part '''' ',' int2str(q) ')'] ;
   set(h,'ButtonDownFcn',cBACK);
end

function draw_spring(x,y,z,T)
%
 yz=[y(:) z(:)]; yz=yz*T.';
 h=plot3(x,yz(:,1),yz(:,2));
 set(h,'linewidth',2)


function h=draw_cyl(z,r,n,c,rmin)
%
n=14;
m = length(r); 
n1=fix(n*.5);
n1=0;
theta = (0:n)/n*2*pi;
sintheta = sin(theta); sintheta(n1+1) = 0;

x = r(:) * cos(theta);
y = r(:) * sintheta;
z = z(:) * ones(1,n+1);

    h1=surf(z,x,y,c*ones(size(z)));
      hold on
    
    if nargin<5
       rmin=0;
    end
    rmax=max(r);
    for q=1:n
       x1=[rmin rmax rmax rmin].'*cos(theta(q:q+1));
       y1=[rmin rmax rmax rmin].'*sintheta(q:q+1);
           h2=surf(z(1)*ones(size(x1)),x1,y1,c*ones(size(x1)));
           h3=surf(z(2)*ones(size(x1)),x1,y1,c*ones(size(x1)));
           h1=[h1(:) ; h2(:); h3(:)];
        end
   h=h1;        

          