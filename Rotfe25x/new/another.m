% another.m : A RotFE 2 example of a more complex rotor
% By A.Hallas October 1999

% The rotor is 1 metre long and is to be divided into 10 elements (2 in parallel)

%   Node No.   1   2   3   4   5   6   7   8   9   10
NODES=1.0e-3*([0  50 200 300 400 500 600 700 800 1000]);

% Elements of different inside and outside diameters and also of different
% material types.  Note the elements between nodes 2 and 3 that are in parallel.

ELEMENTS=[1 2  40.0e-3  10.0e-3  1
          2 3  20.0e-3  10.0e-3  1
			 2 3  40.0e-3  20.0e-3  2
          3 4  20.0e-3  10.0e-3  1
          4 5  30.0e-3  8.0e-3   3
          5 6  20.0e-3  10.0e-3  1
          6 7  30.0e-3  15.0e-3  1
          7 8  20.0e-3  10.0e-3  1
          8 9  30.0e-3  15.0e-3  1
          9 10 20.0e-3  10.0e-3  1];

% Mat 1 is mild steel with E=207GPa, rho=7850 Kgm-3 and Poisson’s Ratio=0.3
% Mat 2 is an Al alloy with E=68.9GPa, rho=2720 Kgm-3 and Poisson’s Ratio=0.3
% Mat 3 is a Ti Alloy with E=110e9, rho=5000Kgm-3 and Poisson’s Ratio=0.31

MATERIALS = [207e9 7850 0.3; 68.9e9 2720 0.3; 110e9 5000 0.31];

% Two identical discs at nodes 4 and 5.  Discs have o/d 190mm, i/d 10mm,
% width 10mm and material type 3.

DISCS=[4 190e-3 10e-3 10e-3 3; 5 190e-3 10e-3 10e-3 3];

% Two bearings of the same stiffness.  Bearings located at nodes 2 and 9
% with both Kxx and Kyy=1.0e11 NmRad-1.  Cross stiffness terms all zero.

SPRINGS=[2 1.0e11 1.0e11; 4 1e11 1e11; 9 1.0e11 1.0e11];

% Damping at both bearings.  Bearing at node 2 has Dxx and Dyy=0.01.
% Bearing at node 9 has Dxx and Dyy=0.0001.  All cross damping terms are
% zero.

DASHPOTS=[2 0.01 0.01; 9 0.0001 0.0001];

% A point mass at node 7.  Mass=0.2Kg, Jp=0.04Kgm2 and Jt=0.02Kgm2

POINT_MASS=[7 0.2 0.04 0.02];

% Unbalance at node 5 of 1Kgmm in the x-direction and 0 in the y-direction

UNBALANCE=[5 1e-3 0];

% No degrees of freedom to be set to zero

BCNodeDir=[];

% No forced nodes

FNodeDir=[];

% No response nodes

RNodeDir=[];

% Misaligned at the bearing at node 2.  dx=4mm and dy=2mm. The misalignment is of the type
% where it is defined after connecting the rotor and bearings.

MISALIGN=[2 4e-3 2e-3];

MISTYPE=1;

% No Reduction
% Reduct.Nmodes=; This Line is not required
% Reduct.Type=;	This Line is not required

% END OF FILE
