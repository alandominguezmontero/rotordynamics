% ==> ELEMENTS 
%-------------------------------- 
 ELEMENTS =[1 2 0.1 0.05 1;2 3 0.15 0.05 1;2 3 .3 .2 3; 3 4 .06 0 2; 4 5 .05 0 1] ; 
%-------------------------------- 
% ==> dim 
%-------------------------------- 
% ==> M 
%-------------------------------- 
% ==> dof 
%-------------------------------- 
 dof =[3 4 5 6 9 10 11 12] ; 
%-------------------------------- 
% ==> W 
%-------------------------------- 
 W =10 ; 
%-------------------------------- 
% ==> NODES 
%-------------------------------- 
 NODES =[0:0.5:3] ; 
%-------------------------------- 
% ==> MATERIALS 
%-------------------------------- 
 MATERIALS =[209000000000 7800 0.3;70e9 3000 .38 ; 40e9 5000 .29] ; 
%-------------------------------- 
% ==> DISCS 
%-------------------------------- 
 DISCS =[] ; 
%-------------------------------- 
% ==> POINT_MASS 
%-------------------------------- 
 POINT_MASS =[] ; 
%-------------------------------- 
% ==> SPRINGS 
%-------------------------------- 
 SPRINGS =[] ; 
%-------------------------------- 
% ==> DASHPOTS 
%-------------------------------- 
 DASHPOTS =[] ; 
%-------------------------------- 
% ==> BCNodeDir 
%-------------------------------- 
 BCNodeDir =1 ; 
%-------------------------------- 
% ==> Bcord 
%-------------------------------- 
 Bcord =[1;2;7;8] ; 
%-------------------------------- 
% ==> UNBALANCE 
%-------------------------------- 
 UNBALANCE =[3 1 0] ; 
%-------------------------------- 
% ==> FNodeDir 
%-------------------------------- 
 FNodeDir =[3.1 3.3] ; 
%-------------------------------- 
% ==> RNodeDir 
%-------------------------------- 
 RNodeDir =[3.1 3.3] ; 
 %-------
 Reduct.Type='modal'; Reduct.Nmodes=4; 