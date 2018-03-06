%cobra0.m                                                                                     
%                                                                                               
% by: I. Bucher 16-Feb-2002
                                     
                                                                                         
 NODES=[linspace(0,1.46,10) ] ;                                                              
                                                                                                
  N_NODES=length(NODES);      
  
  TR35=3.5;    
 for q=1:N_NODES-1, 
	ELEMENTS(q,:)=[q q+1 TR35*25.4e-3 (TR35-2*0.052)*25.4e-3 1]; 
 end                                       
                                                                                                
                                                                                                
                                                                        
% MATERIALS=[E1 rho1 nu1; E2 rho2 nu2; ..... ]                                                          
                                                                                                
 MATERIALS=[72400000000 2770 0.3;
		210e9 7800 0.3; 70e9 3200 0.3];     
% DISCS=[node1 d_out d_in width material_no; % define disc #1                                   

TR35=3.5;                       
                                                                         
 DISCS=[	1       TR35*[2.54e-2 2.54e-2-4e-3*2]   2.22*25.4e-3 1                                                                     
 		N_NODES TR35*[2.54e-2 2.54e-2-4e-3*2]	2.22*25.4e-3 1    ];                                                                         

   DISCS=[];                                                                                          
   
% SPRINGS=[node1 Kxx1 Kyy1 Kxy1 Kyx1 Ktt1 Kpp1 Ktp1 Kpt1   % bearing #1                         
                                                                                                
 SPRINGS=[];                                                                                      
 DASHPOTS=[];                                                                                   

 

FORCE_NODE=[ 3 	; 3 	;  5 	; 	5	];
FORCE_DIR= ['xx'; 'yy' 	; 'xx' 	; 	'yy'	];

RESP_NODE=[ 2 	; 2 	;  5 	; 	5	];
RESP_DIR= ['xx'; 'yy' 	; 'xx' 	; 	'yy'	];


BCNodeDir=[1+[1:4]/10 N_NODES+.1 N_NODES+.3]';

  UNBALANCE=[2 1e-3 0];

  POINT_MASS = [ 1  1.0 2e-3  1.6e-3
                N_NODES 1.0 2e-3  1.6e-3];
   
TorsionBC=1;                


