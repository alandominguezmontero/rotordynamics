function campbell(FILE,P2,P3,P4,P5)  
% campbell(FILE) 
%   
%
%  campbell('template_File_Name'); 
%						 
% By  I. Bucher,  
% Rev. 2.02  Aug-98, adapted to rotfe2
% Rev. 2.1   Aug-99, accepts Rot (structure) too  

toolname=mfilename;

if nargin<1, FILE='init'; end
 if isa(FILE,'struct'),    
    tFILE=rot2templ(FILE,'temporary1.m');
    FILE='temporary1';
    campbell('init',FILE)
     if length(tFILE)>0,    set(gcf,'DeleteFCN',['delete temp*']), end
 else
          if ~ismember(FILE,{'go'  'init'}), 
                campbell('init')
               hfile=findobj('tag',[toolname 'file']);  	set(hfile,'string',FILE);
                
              end 
 end
 
if strcmp(FILE, 'go' ),
   fig=findobj('tag',[toolname 'fig']);   
   hed=findobj('tag',[toolname 'rpm']); 	RPM=get(hed,'string');
   hN=findobj('tag',[toolname 'N']);  		N=get(hN,'string');
   hfile=findobj('tag',[toolname 'file']);  	file=get(hfile,'string');
   RPM=myeval([ '[' RPM ']' ]); if RPM<0, return, end
   N=myeval([ '[' N ']' ]); if N<0, return, end
   halpha=findobj('tag',[toolname 'alpha']); 	S=get( halpha,'string'); 		
   alpha=myeval([ '[' S ']' ]); if alpha<0, return, end
   
    Rot=rotfe(file); 			% run FE code
   if length(RPM)>1, W1=RPM(1)*2*pi/60; W2=RPM(2)*2*pi/60;
   else, W1=0; W2=RPM(1)*2*pi/60; end
   dW=(W2-W1)/N;
   
   
   p=1; S=[]; range=1:size(Rot.M,1);
   h = waitbar(0,'Computing campbel diagram...');
   M=sparse(Rot.M); K=sparse(Rot.K); G=sparse(Rot.G); D=sparse(Rot.D);
   if alpha~=0, K=K+alpha*sparse(Rot.Kst); end
   
   for W=W1:dW:W2,
      p=p+1;
       waitbar(p/N)
      aa=[ zeros(size(M))  eye(size(M)); -M\[K,G*W+D]];	% form state-space
  %    aa=[ zeros(size(M))  eye(size(M)); -M\[K,G*W]];	% form state-space
  %    d=eigs((aa),'SM',20); 						% compute eigevalues
      d=eig(full(aa)); [d jj]=sort(abs(d));
      %[s jj]=sort(abs ( imag(d)));  			% sort by frequency
      s=abs(sort((d)));
      S=[S s(:)];					% add to the list
   end
   S=S.';							% transpose
   
   delete(h) 						% close waitbar
   
   W=W1:dW:W2;
   %set(gcf,'nextplot','new')
   mW=max(W*(60/2/pi));  mS=max(max(S/(2*pi)));		% correct units
   mx=min([mW/60 mS]);				        % axes scaling
   figure(fig)
   plot(W*(60/2/pi), S*(1/(2*pi)), '-' ,[0 mx*60*1],[0 1*mx],'--'), 
   axis([-inf inf 0 13000])
   % GvG changed lenngth of first EO to be same as frequency lines
   hfile=findobj('tag',[toolname 'file']);  file=get(hfile,'string'); title(file);
   set(gcf,'name','Campbell Diagram')
   xlabel('rotational speed [rev/min]')
   ylabel('natural frequencies [Hz] ')
   % set(gca,'pos',[.1 .3 .8 .6])
   zoom on
   figure(gcf);
   
   % <><><><>
   
   
elseif strcmp(FILE,'init') , % init
   
   if (nargin<1) | strcmp(FILE,'init'), FILE='simple2s'; end
   if nargin>1, FILE=P2; end
   tool=toolname;
   
   fig=findobj('tag',[tool 'fig']);
   if length(fig)==0, 
      fig=figure('unit','normal','pos',[0.01 0.1 0.8  .6],...
         'tag',[tool 'fig'],'menubar','none',...
         'name','Campbell Diagram',...
         'numbertitle','off'); 
        %  hidegui on
   else, figure(fig), return
   end
   set(gca,'pos',[.1 .45 .8 .5]); axis off
   feval('drawrot',FILE);
   % ----------------------------------------------------------------------
   dy=0.1;
   goahead=['campbell(''go'');'];
   uicontrol('style','frame',...
      'foregroundcolor','w',...
      'units','normalized','pos',[.01 .01 .97 .39],...
      'backgroundcolor','b');
   uicontrol('style','text',...
      'string','  Template file (model)',...
      'units','normalized','pos',[.03 .19+dy .5 .08],...
      'backgroundcolor','y');
   uicontrol('style','edit',...
      'string',FILE,'units','normalized',...
      'pos',[.55 .19+dy .15 .08],...
      'tag',[toolname 'file'],...
      'callback','FILE=get(findobj(gcf,''tag'',''campbellfile''),''string'');drawrot(FILE);axis auto',...
      'backgroundcolor','w');
   uicontrol('style','text',...
      'string',' enter max speed of rotation [rpm] | or 2 element vector (e.g. [50 100]) for speed range',...
      'units','normalized','pos',[.03 .09+dy .5 .08],...
      'backgroundcolor','y');
   uicontrol('style','edit',...
      'string','10000','units','normalized',...
      'pos',[.55 .09+dy .15 .08],...
      'tag',[toolname 'rpm'],...
      'backgroundcolor','w');
   uicontrol('style','text',...
      'string','enter number of steps',...
      'units','normalized','pos',[.03 .03+dy .5 .045],...
      'backgroundcolor','y');
   uicontrol('style','edit',...
      'string','100','units','normalized',...
      'pos',[.55 .03+dy .15 .045],...
      'tag',[toolname 'N'],...
      'backgroundcolor','w');
   uicontrol('style','push',...
      'string','GO','units','normalized',...
      'pos',[.85 .03 .1 .1],...
      'callback',goahead);
   %---------------------------------------------------------------------------------
   
   uicontrol('style','text',...
      'string','Angular acceleration (Rad/s^2), (0-quasi static)',...
      'units','normalized','pos',[.03 .05 .5 .06],...
      'backgroundcolor','y');
   uicontrol('style','edit',...
      'string','000','units','normalized',...
      'pos',[.55 .05 .15 .06],...
      'tag',[toolname 'alpha'])
   
end


function x=myeval(S)
% safe eval + error message
try
 x=eval(S);
catch
   try
	fprintf(' cannot evaluate the expression %s \n',S)
   end
end
