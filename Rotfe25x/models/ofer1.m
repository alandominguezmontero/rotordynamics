% model.m - creat the database for the FE model                                     
%====================================================================================           
%   (1)                                                                                         
% define nodal locations from left side to right                                                                       
% NODES=[z1 z2 z3 ... ]                                                                         
% units=[Length] ([Meters])                                                                     
%                                                                                               
%====================================================================================           
  
 NODES=[0 12 29.775 47.55 (57.1:9.55:143.05) 1.60825e+002 178.6 190.6] ;   
 NODES=NODES*1e-3; %in [m]
%====================================================================================           
%   (2)                                                                                         
% define ELEMENTS                                                                               
% elements=[node1 node2 d_out d_in material_no ;  % element #1                                  
%   ...    % element #2                                                                         
%    ... ]     % etc.                                                                           
%                                                                                               
% node1, node2 : integer indices of entries in NODES                                            
% d_out, d_in  : [length][M] outer and inner diameters of a hollow shaft                        
% material _no : integer index. defines approp. row in the MATERIAL matrix (table)              
%====================================================================================           
s=size(NODES,2)
dout=1.9050e-002;  % shaft diameter [m] ;  
din=0;
mat=1;
for i=1:s-1
    ELEMENTS(i,:)=[i (i+1) dout din mat ];                                                                          
end
     
                                      
%====================================================================================           
%   (3)                                                                                         
% define material sets                                                                          
% MATERIALS=[E1 rho1 nu1; E2 rho2 nu2; ..... ]                                                          
% units=   E - [Pa] [psi] (young modulus)                                                       
%  rho [Kg/m^3] [lb/in^3] (density)  
%  nu [.] poison ration (0.3 for most metals)                                                           
%                                                                                               
%====================================================================================           
                                                                                                
 MATERIALS=[
                        210e9 7800 0.3;         %shaft
                        210e9 7800 0.3            %disc
                    ];     
%====================================================================================           
% DISCS=[node1 d_out d_in width material_no cylinder_mass;....]
%====================================================================================           
 
 DISCS=[ 2 0.062  1.9050e-002 0.012 2 0.1128;...
        16 0.062  1.9050e-002 0.012 2 0.1128];                                                                         

 %====================================================================================           
% SPRINGS=[node1 Kxx1 Kzz1 Kxz1 Kzx1;....]                     
%====================================================================================           
% spr1=size([p1 p2 p3],2)+1;
% spr2=size([p1 p2 p3 p4 p5 p6 p7 p8],2)+1;

  SPRINGS=[	4 596 	596   0 0 ;
           	14 596 	596  0 0];   

%====================================================================================           
% DASHPOTS=[node1 xi;.....]
%====================================================================================           
 DASHPOTS=[2  0.03;      
           15  0.03];   


%====================================================================================           
% UNBALANCE=[node1 ux1 uz1 ; node2  ux2 uz2; ... nodeQ uxQ uzQ]   node1=1,2, ..
  UNBALANCE=[2 1 0;
             16 1 0];

  %==================================================================================== 
           
% AMB=[node1 node2]   if node2==0 point force otherwise node2-node1==1 and force is spread between
  AMB=[11 12];
            

  %==================================================================================== 
%   (11)                                                                                         
% Point mass specification
%
% POINT_MASS=[node1 m Jp Jd]
%  node1=1,2, ..  m-mass [kg] , Jp,Jd - moment of inertia [Kg-m^2]
% nd1=POINT_MASS(:,1); 	% find node
% m=POINT_MASS(:,2); 	% masses
% Jp=POINT_MASS(:,3);  Jd=POINT_MASS(:,4); 

%  POINT_MASS=[2 1e-3 1e3 1e3];
  POINT_MASS=[];