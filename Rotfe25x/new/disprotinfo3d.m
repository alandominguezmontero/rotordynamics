function DispRotInfo3d(cmd,no)
%
%

   Rot=get(gcf,'userdata');
   
switch(cmd)
   case	'Element',   
   msg=['Element No.' int2str(no) '; Nodes ' int2str(Rot.ELEMENTS(no,1)) '-' int2str(Rot.ELEMENTS(no,2)) '; do=' num2str(1000*Rot.ELEMENTS(no,3)) ...
         ', di=' num2str(1000*Rot.ELEMENTS(no,4)) ...
         ', Mat=' int2str(Rot.ELEMENTS(no,5))];
	case	'Disc',   
    msg=['Disc @ Node-' int2str(Rot.DISCS(no,1)) ...
       '; do=' num2str(1000*Rot.DISCS(no,2)) ' , W=' num2str(Rot.DISCS(no,3)*1000) ];
	case	'Spring',   
    msg=['Spring @ Node-' int2str(Rot.SPRINGS(no,1)) ...
       '; Kxx=' num2str(Rot.SPRINGS(no,2)) '; Kyy=' num2str(Rot.SPRINGS(no,3))];
	case  'BC',    
      ind=find(fix(Rot.BCNodeDir)==no); cdir=[];
      DIR=round(10*(Rot.BCNodeDir-fix(Rot.BCNodeDir)));
       dirs={'all' 'xx' 'my' 'yy' 'mx'};
   		for q=ind(:)',cdir=[cdir ', ' dirs{DIR(q)+1}]; end
    		 msg=['BC @ Node-' int2str(no) ...
           '; Constrained in'  cdir];
  case  'Pmass',    
   	ind=find(Rot.POINT_MASS(:,1)==no); cdir=[];
      msg=['Point mass @ Node-' int2str(no) ...
       '; m='  num2str(Rot.POINT_MASS(ind,2)) '; Jp='  num2str(Rot.POINT_MASS(ind,3)) '; Jd='  num2str(Rot.POINT_MASS(ind,3)) ];

 end


  switch(cmd)
  case	{'Pmass','Element','Disc','Spring','BC'}
     h=title(' ');
     set(h,'FontSize',14,'String',msg);
  end

  