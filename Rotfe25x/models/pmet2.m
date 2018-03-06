% PMET2.M       Data defining PMET programme AMB rotor.
%                               The laminations are representedexplicitly as 
%                               elements parallel to the shaft, but with zero
%                               Young's modulus.
%
% Sss
% Version 1 26/8/99  Reduced order modes

NODES=[0 0.095 .19 .285 .365 .465 .565 .665 .765 .865 .965 1.065 1.165 ...
      1.265 1.365 1.445 1.54 1.635 1.75 1.8 1.9 1.96 1.9825];

ELEMENTS=[1 2  0.16  0.0    1
          1 2  0.25  0.16   2
          2 3  0.16  0.0    1
          2 3  0.25  0.16   2
          3 4  0.16  0.0    1
          3 4  0.25  0.16   2
          4 5  0.16  0.0    1
          4 5  0.18  0.16   2
          5 6  0.22  0.0    1
          5 6  0.565 0.22   2
          6 7  0.22  0.0    1
          6 7  0.565 0.22   2
          7 8  0.22  0.0    1
          7 8  0.565 0.22   2
          8 9  0.22  0.0    1
          8 9  0.565 0.22   2
          9 10 0.22  0.0    1
          10 11 0.22  0.0    1
          11 12 0.22  0.0    1
          12 13 0.22  0.0    1
          13 14 0.22  0.0    1
          14 15 0.22  0.0    1
          15 16 0.16  0.0    1
          15 16 0.18  0.16   2
          16 17 0.16  0.0    1
          16 17 0.25  0.16   2
          17 18 0.16  0.0    1
          17 18 0.25  0.16   2
          18 19 0.16  0.0    1
          19 20 0.14  0.0    1
          19 20 0.3   0.14   2
          20 21 0.12  0.0    1
          21 22 0.115 0.0    1
          21 22 0.175 0.115  2
          22 23 0.115 0.0    1
          22 23 0.25  0.115  2];
       
       MATERIALS = [206.8e9 7833.412  0.3
                      0.0   7833.412  0.3];
       
% No disk here
DISCS=[];
%
SPRINGS=[3 1 1 
         17 1 1];
% No point masses
POINT_MASS=[];
% 
FNodeDir=[ 3.1 3.3 17.1 17.3 ];
RNodeDir=[ 3.1 3.3 17.1 17.3 ];

% Specify reduced order
%Reduct.Nmodes = 8;
%Reduct.Type = 'mixed';

% End of PMET2.M
