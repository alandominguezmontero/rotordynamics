% Uspiz Yona,  overhand motor
%====================================================================================           
%   (1)                                                                                         
% define nodal locations                                                                        
% NODES=[z1 z2 z3 ... ]                                                                         
% units=[Length] ([Meters])                                                                     
%                                                                                               
%====================================================================================           
                                                                                                
NODES=[0 47.5 97.5 184.5 263.5 342.5 381.5 621.5 684 694 ...
       788.5 863.5 917.5 1357.5 1447.5 1523.5 1617 1627 1689.5 1752]*1e-3;
   
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
                                                                                                
 ELEMENTS=[ 	1 2  35e-3 0 1                                                                  
   		2 3  35e-3 0 1                                                                           
  		3 4  69e-3 0 1                                                                            
  		4 5  69e-3 0 1                                                                            
  		5 6  69e-3 0 1                                                                            
        6 7  69e-3 0 1
        7 8 79.375e-3 0 1
        8 9 80e-3 0 1
        9 10 79.375e-3 0 1
        10 11 90e-3 0 1
        11 12 122e-3 0 1
        12 13 123e-3 0 1
        13 14 123e-3 0 1
        13 14 326e-3 123e-3 2
        14 15 123e-3 0 1
        15 16 122e-3 0 1
        16 17 90e-3 0 1
        17 18 80e-3 0 1
        18 19 80e-3 0 1
     19 20 75e-3 0 1];                                                                          
                                                                                                
                                                                                                
% or for example define uniform shaft                                                           
%  N_NODES=length(NODES);                                                                       
% for q=1:N_NODES-1, ELEMENTS(q,:)=[q q+1 15e-3 0 1]; end                                       
%====================================================================================           
%   (3)                                                                                         
% define material sets                                                                          
% MATERIALS=[E1 rho1 nu1; E2 rho2 nu2; ..... ]                                                          
% units=   E - [Pa] [psi] (young modulus)                                                       
%  rho [Kg/m^3] [lb/in^3] (density)  
%  nu [.] poison ration (0.3 for most metals)                                                           
%                                                                                               
%====================================================================================           
                                                                                                
 MATERIALS=[210e9 7800 0.3; 70e7 9.2069e+003 0.3];     
%====================================================================================           
%   (4)                                                                                         
% define discs (rigid)                                                                          
% DISCS=[node1 d_out d_in width material_no; % define disc #1                                   
%        node2 ... ]       % etc.                                                                   
%  units=   node1	- integer, nodes number                                                         
%   d_out, d_in 	- (length) [m] [in] (diameter)                                                  
%   width   			- (length) [m] [in] (disc's width)                                                  
%   material_no 	- integer, dfines the material set                                              
%                                                                                               
%====================================================================================           
                                                                                                
 DISCS=[	 ];                                                                         
                                                                                                
%====================================================================================           
%   (5)                                                                                         
% define boundry conditions - springs                                                           
% SPRINGS=[node1 Kxx1 Kyy1 Kxy1 Kyx1 Ktt1 Kpp1 Ktp1 Kpt1   % bearing #1                         
%   node2 Kxx2 Kyy2 Kxy2 Kyx2 Ktt2 Kpp2 Ktp2 Kpt2   % bearing #2                                
%     ...       % etc.                                                                          
%  ]                                                                                            
%  where:                                                                                       
% linear (x,y) dofs have the following stiffness matrix                                         
%  Kxxyy=[Kxx Kxy; Kyx Kyy];                                                                    
% angular (p~=- dz/dy, t~=dz/dy)                                                                
%  Kpptt=[Kpp Kpt; Ktp Ktt]                                                                     
%                                                                                               
%  units: node - positive integer, index of node location z=NODES(node)                         
%  K- spring rate  Kg/m,  lb/in etc.                                                            
%                                                                                               
%====================================================================================           
                                                                                                
  SPRINGS=[	9 80e6 80e6   % the missing entries, e.g. Kxy etc.                                     
    		   18 80e6 80e6];   % are assumed to be zero                                                     
 

%====================================================================================           
%   (6)                                                                                         
% define boundry conditions dashpots                                                            
% DASHPOTS=[node1 Cxx1 Cyy1 Cxy1 Cyx1 Ctt1 Cpp1 Ctp1 Cpt1   % bearing #1                        
%   node2 Cxx2 Cyy2 Cxy2 Cyx2 Ctt2 Cpp2 Ctp2 Cpt2   % bearing #2                                
%  %====================================================================================           
%   (6)                                                                                         
% define boundry conditions dashpots                                                            
% DASHPOTS=[node1 Cxx1 Cyy1 Cxy1 Cyx1 Ctt1 Cpp1 Ctp1 Cpt1   % bearing #1                        
%   node2 Cxx2 Cyy2 Cxy2 Cyx2 Ctt2 Cpp2 Ctp2 Cpt2   % bearing #2                                
%     ...       % etc.                                                                          
%  ]                                                                                            
%  where:                                                                                       
% linear (x,y) dofs have the following stiffness matrix                                         
%  Cxxyy=[Cxx Cxy; Cyx Cyy];                                                                    
% angular (p~=- dz/dy, t~=dz/dy)                                                                
%  Cpptt=[Cpp Cpt; Ctp Ctt]                                                                     
%                                                                                               
%  units: node - positive integer, index of node location z=NODES(node)                         
%  C- dashpot rate  kg/s,                                                                       
%                                                                                               
%====================================================================================           
                                                                                                
 DASHPOTS=[];                                                                                   

%====================================================================================           
                                                                                                
  PROP_DAMP=[.01];  %   1 percent

%====================================================================================           
%   (7)                                                                                         
% 
% FNodeDir=[node1.dir1 ; node2.dir2; ... nodeQ.dirQ]
%   node1=1,2, ..   dir=1,2,3,4
%    dir1=1->'xx' 3->'yy'  4->'mx' 2->'my'
%

FNodeDir=[ 2.1 	; 2.3 	];

%====================================================================================           
%   (8)                                                                                         
% 
% RNodeDir=[node1.dir1 ; node2.dir2; ... nodeQ.dirQ]
%   node1=1,2, ..   dir=1,2,3,4
%    dir1=1->'xx' 3->'yy'  4->'mx' 2->'my'
 

RNodeDir=[ 2.1 	; 2.3; 13.1 ;14.1 	 	];

%====================================================================================           
%   (9)                                                                                         
% boundry conditions
%
% BCNodeDir=[node1.dir1 ; node2.dir2; ... nodeQ.dirQ]
%   node1=1,2, ..   dir=1,2,3,4
%    dir1=1->'xx' 3->'yy'  4->'mx' 2->'my'
%

BCNodeDir=[  ] ;


%====================================================================================           
%   (10)                                                                                         
% unbalance specification
%
% UNBALANCE=[node1 ux1 uy1 ; node2  ux2 uy2; ... nodeQ uxQ uyQ]   node1=1,2, ..
%
%  nodei specifies the node number in the finite element model
%  uxi  - m*e (mass x displacement) unbalance in the x-direction
%  uyi  - m*e (mass y displacement) unbalance in the y-direction
 

  UNBALANCE=[2 24*0.001 0];
  
%====================================================================================           
%   (11)                                                                                         
% Point mass specification
%
% POINT_MASS=[node1 m Jp Jd]
%  node1=1,2, ..  m-mass [kg] , Jp,Jd - moment of inertia [Kg-m^2]
% nd1=POINT_MASS(:,1); 	% find node
% m=POINT_MASS(:,2); 	% masses
% Jp=POINT_MASS(:,3);  Jd=POINT_MASS(:,4); 

POINT_MASS=[2 12 0 0 ;4 25 0 0; 5 24 0 0 ; 6 23 0 0];
 

%====================================================================================           
%   (12)                                                                                         
% Misalignment at bearings
%
%  MISALIGN=[node1 dx dy]
%  node1=1,2, ..  dx,dy -distance [m]
% MISALIGNMNET is usually defined at a bearing (wher there's a spring)
%  MISALIGNMNET is defined at zero speed
%  The effect of MISALIGNMNET is implemented by application of
% a constant vector of forces, causing the specified MISALIGNMNET

%MISALIGN=[2 1e-3 .2e-3; 4 1.2e-3 .25e-2; 5 2e-3 0; 5 0 -3e-3];

% Running RotFE a constant force Fmalgn is created. adding the static
% deflection due to this force gives the true response

%====================================================================================           
%   ( )                                                                                         
% Model-size reduction
% 
%  Reduct.Type = {'modal' 'mixed' 'static'} (choose one)
%  Note that Rot.RESP_DOF neeed to be defined as master coordinates
%  Reduct.Nmodes = 2, 4 .... no. of modes to 
     