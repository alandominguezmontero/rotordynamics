% TMtestRot.m : Model of Turbomeca Test Rotor.
%               Note:  Some parts simplified further from the Turbomeca model.
%
% By A.Hallas July 1999

% All details provided by F. Batlle at Turbomeca
%   Node No.   1  2  3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19
NODES=1.0e-3*([0 50 90 130 140 200 210 220 230 240 250 260 270 280 290 300 310 320 330 ...
               340 560 585 610 634 659 684 699 713 726 735]);
%   Node No.    20  21  22  23  24  25  26  27  28  29  30
%    (Cont.)

ELEMENTS=[1 2  65.0e-3   40.0e-3  1    
   		 2 3  60.0e-3   15.0e-3  1
          3 4  55.0e-3   40.0e-3  1
          4 5  55.0e-3   50.0e-3  1
          5 6  51.5e-3   22.0e-3  2
          6 7  57.5e-3   22.0e-3  2
          7 8  62.0e-3   22.0e-3  2
          8 9  68.0e-3   22.0e-3  2
          9 10 75.0e-3   22.0e-3  2
         10 11 83.5e-3   22.0e-3  2
         11 12 93.0e-3   22.0e-3  2
         12 13 103.5e-3  22.0e-3  2
         13 14 115.0e-3  22.0e-3  2
         14 15 128.0e-3  22.0e-3  2
         15 16 142.0e-3  22.0e-3  2
         16 17 157.5e-3  22.0e-3  2
         17 18 174.0e-3  22.0e-3  2
         18 19 191.0e-3  22.0e-3  2
         19 20 220.0e-3  22.0e-3  2
         20 21 82.0e-3   74.0e-3  3
         21 22 92.5e-3   17.5e-3  3
         22 23 92.5e-3   17.5e-3  3
         23 24 82.0e-3   74.0e-3  3
         24 25 103.0e-3  17.5e-3  3
         25 26 103.0e-3  17.5e-3  3
         26 27 82.0e-3   74.0e-3  3
         27 28 57.5e-3   46.5e-3  3
         28 29 40.0e-3   15.0e-3  3
         29 30 40.0e-3   23.0e-3  3];
     
MATERIALS = [200e9 7700 0.3; 110e9 4450 0.3; 205e9 8200 0.3];

DISCS=[22 190.0e-3 17.5e-3 12.0e-3 3; 25 190.0e-3 17.5e-3 10.0e-3 3];

SPRINGS=[1 15.0e6 15.0e6; 30 25.0e6 25.0e6];

% No point masses
POINT_MASS=[];

% No Specified Dashpots
% Dashpots input: damping
DASHPOTS=[];    

%FNodeDir=[1.1 1.3 30.1 30.3];

%RNodeDir=[1.1 1.3 30.1 30.3];
Reduct.Nmodes=20; Reduct.Type='modal';

%W=0;

