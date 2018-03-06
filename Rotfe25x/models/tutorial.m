  NODES=[0 0.3 0.5 0.6 0.8 1.0 ] ;                                                              
                                                                                                 
  ELEMENTS=[ 	...
      1 2  30e-3 12e-3 1                                                                                                                                            
   	2 3  32e-3 10e-3 1
   	3 4  22e-3 8e-3 1
      4 5  28e-3 6e-3 1
      5 6  30e-3 6e-3 1];                                                                          
                                                                                                
                                                                                                 
 MATERIALS=[210e9 7800 0.3; 70e9 3200 0.3];     
 
 DISCS=[	6  0.2 	12e-3 12e-3 1     ];                                               
                                                                                                
SPRINGS=[1 2e3 2e3; 2 2e3 2e3];

%BCNodeDir=[ 1.1  3.3 ] ;
  
  POINT_MASS=[5 .01 0 0];
  DASHPOTS=[3 1.2 1.2];
    UNBALANCE=[6 100e-3 0];
    
    FNodeDir=[ 5.1 	; 5.3 	];
    RNodeDir=[ 6.1 	; 6.3 	 	];
