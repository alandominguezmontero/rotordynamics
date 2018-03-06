% 

w = [8.8 18.9   1e3
     33.2   11.5 3e3
	 15.5 18.77 1e3
	 6.16   16   1e3
	 28.2  11.9   1e3
	 6       18.5  1e3
	 23   12     1e3
	 6   16     1e3
	 15.44  19   1e3
	 32.5 19    1e3
	 49   11.3   3e3
	 8     17.6  1e3]*1e-3;  %M not mm
	 
 
 i1=7;
 i2=48;
 i3 = 53;
 i4 = 57;
 D=[i1 20e-3 11.4e-3  31.76e-3 2
       i1  73.9e-3 20e-3 9e-3 2
       i1  114.32e-3 73.9e-3 2.41e-3 2
      i2   40e-3 11.4e-3 13.75e-3  2
     i3  74.8e-3 11.4e-3  18e-3 2
     i4  155e-3 11.4e-3 4.25e-3 2];

 [NODES ELM ww]=get_elem_shaft2(w,4.5e-3);
  
   
%====================================================================================           
%   (3)                                                                                         
% define material sets                                                                          
% MATERIALS=[E1 rho1 nu1; E2 rho2 nu2; ..... ]                                                          
% units=   E - [Pa] [psi] (young modulus)                                                       
%  rho [Kg/m^3] [lb/in^3] (density)  
%  nu [.] poison ration (0.3 for most metals)                                                           
%                                                                                               
%====================================================================================           
                                                                                                
 MATERIALS=[200e9 7800 0.29;71.7e9 2830 0.33;  670e9 7800 0.3];     
%====================================================================================           
%   (4)                                                                                         
% define discs (rigid)                                                                          
% DISCS=[node1 d_out d_in width material_no; % define disc #1                                   
%        node2 ... ]       % etc.                                                                   
% units=   node1- integer, nodes number                                                         
%   d_out, d_in - (length) [m] [in] (diameter)                                                  
%   width   - (length) [m] [in] (disc's width)                                                  
%   material_no - integer, dfines the material set                                              
%                                                                                               
%====================================================================================           
                
ELEMENTS=ELM;
                                                                        
     DISCS=[D];
        
  
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
               
               
kc=1e6;  % coupling stiffness
 kb=100e6;
  SPRINGS=[	%13 kc kc   % the missing entries, e.g. Kxy etc.                                     
                        16 kb kb
                        36 kb kb];
                    
         return           
                    
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

FNodeDir=[ 	 	];

%====================================================================================           
%   (8)                                                                                         
% 
% RNodeDir=[node1.dir1 ; node2.dir2; ... nodeQ.dirQ]
%   node1=1,2, ..   dir=1,2,3,4
%    dir1=1->'xx' 3->'yy'  4->'mx' 2->'my'
 

RNodeDir=[ ];

%====================================================================================           
%   (9)                                                                                         
% boundry conditions
%
% BCNodeDir=[node1.dir1 ; node2.dir2; ... nodeQ.dirQ]
%   node1=1,2, ..   dir=1,2,3,4
%    dir1=1->'xx' 3->'yy'  4->'mx' 2->'my'
%

BCNodeDir=[  ] ;

  PROP_DAMP=[];  %   1 percent

%====================================================================================           
%   (10)                                                                                         
% unbalance specification
%
% UNBALANCE=[node1 ux1 uy1 ; node2  ux2 uy2; ... nodeQ uxQ uyQ]   node1=1,2, ..
%
%  nodei specifies the node number in the finite element model
%  uxi  - m*e (mass x displacement) unbalance in the x-direction
%  uyi  - m*e (mass y displacement) unbalance in the y-direction
 

  UNBALANCE=[N_NODES 1e-3 0];
  
%====================================================================================           
%   (11)                                                                                         
% Point mass specification
%
% POINT_MASS=[node1 m Jp Jd]
%  node1=1,2, ..  m-mass [kg] , Jp,Jd - moment of inertia [Kg-m^2]
% nd1=POINT_MASS(:,1); 	% find node
% m=POINT_MASS(:,2); 	% masses
% Jp=POINT_MASS(:,3);  Jd=POINT_MASS(:,4); 

  POINT_MASS=[ ];
 