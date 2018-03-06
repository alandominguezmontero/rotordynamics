% PMET4.M		
%
NODES=[0
    0.0250
    0.0695
    0.1140
    0.1390
    0.1900
    0.2080
    0.2485
    0.2890
    0.3090
    0.3290
    0.3722
    0.4154
    0.4586
    0.5018
    0.5450
    0.6160
    0.6870
    0.7580
    0.8290
    0.9000
    0.9710
    1.0420
    1.1130
    1.1840
    1.2550
    1.2950
    1.3660
    1.4060
    1.4815
    1.5215
    1.5615
    1.6015
    1.6415
    1.6815
    1.7215
    1.7615
    1.8015
    1.8485
    1.8955
    1.9344
    1.9732
    2.0121
    2.0510
    2.0899
    2.1288
    2.1676
    2.2065]' ;
 
ELEMENTS = [ ...
      
    1.0000    2.0000    0.0620         0    1.0000
    1.0000    2.0000    0.1400    0.0620    2.0000
    2.0000    3.0000    0.0620         0    1.0000
    2.0000    3.0000    0.0950    0.0620    2.0000
    3.0000    4.0000    0.0620         0    1.0000
    3.0000    4.0000    0.1000    0.0620    2.0000
    4.0000    5.0000    0.0750         0    1.0000
    4.0000    5.0000    0.2940    0.0750    2.0000
    5.0000    6.0000    0.1000         0    1.0000
    6.0000    7.0000    0.1000         0    1.0000
    6.0000    7.0000    0.1400    0.1000    2.0000
    7.0000    8.0000    0.1600         0    1.0000
    7.0000    8.0000    0.1770    0.1600    2.0000
    8.0000    9.0000    0.1600         0    1.0000
    8.0000    9.0000    0.1770    0.1600    2.0000
    9.0000   10.0000    0.1620         0    1.0000
    9.0000   10.0000    0.2300    0.1620    2.0000
   10.0000   11.0000    0.1640         0    1.0000
   10.0000   11.0000    0.2300    0.1640    2.0000
   11.0000   12.0000    0.1684         0    1.0000
   11.0000   12.0000    0.2500    0.1684    2.0000
   12.0000   13.0000    0.1728         0    1.0000
   12.0000   13.0000    0.2500    0.1728    2.0000
   13.0000   14.0000    0.1772         0    1.0000
   13.0000   14.0000    0.2500    0.1772    2.0000
   14.0000   15.0000    0.1816         0    1.0000
   14.0000   15.0000    0.2500    0.1816    2.0000
   15.0000   16.0000    0.1860         0    1.0000
   15.0000   16.0000    0.2500    0.1860    2.0000
   16.0000   17.0000    0.2200         0    1.0000
   17.0000   18.0000    0.2200         0    1.0000
   18.0000   19.0000    0.2200         0    1.0000
   19.0000   20.0000    0.2200         0    1.0000
   20.0000   21.0000    0.2200         0    1.0000
   21.0000   22.0000    0.2200         0    1.0000
   22.0000   23.0000    0.2200         0    1.0000
   23.0000   24.0000    0.2200         0    1.0000
   24.0000   25.0000    0.2200         0    1.0000
   25.0000   26.0000    0.2200         0    1.0000
   26.0000   27.0000    0.2200         0    1.0000
   26.0000   27.0000    0.5500    0.2200    2.0000
   27.0000   28.0000    0.2200         0    1.0000
   28.0000   29.0000    0.2200         0    1.0000
   28.0000   29.0000    0.5500    0.2200    2.0000
   29.0000   30.0000    0.2200         0    1.0000
   30.0000   31.0000    0.2860         0    1.0000
   30.0000   31.0000    0.5600    0.2860    2.0000
   31.0000   32.0000    0.3718         0    1.0000
   31.0000   32.0000    0.5600    0.3718    2.0000
   32.0000   33.0000    0.4833         0    1.0000
   32.0000   33.0000    0.5600    0.4833    2.0000
   33.0000   34.0000    0.5600         0    1.0000
   34.0000   35.0000    0.4998         0    1.0000
   34.0000   35.0000    0.5600    0.4998    2.0000
   35.0000   36.0000    0.3845         0    1.0000
   35.0000   36.0000    0.5600    0.3845    2.0000
   36.0000   37.0000    0.2958         0    1.0000
   36.0000   37.0000    0.5600    0.2958    2.0000
   37.0000   38.0000    0.2275         0    1.0000
   37.0000   38.0000    0.5600    0.2275    2.0000
   38.0000   39.0000    0.1600         0    1.0000
   38.0000   39.0000    0.1770    0.1600    2.0000
   39.0000   40.0000    0.1600         0    1.0000
   39.0000   40.0000    0.1770    0.1600    2.0000
   40.0000   41.0000    0.1600         0    1.0000
   40.0000   41.0000    0.2500    0.1600    2.0000
   41.0000   42.0000    0.1567         0    1.0000
   41.0000   42.0000    0.2500    0.1567    2.0000
   42.0000   43.0000    0.1534         0    1.0000
   42.0000   43.0000    0.2500    0.1534    2.0000
   43.0000   44.0000    0.1501         0    1.0000
   43.0000   44.0000    0.2500    0.1501    2.0000
   44.0000   45.0000    0.1468         0    1.0000
   44.0000   45.0000    0.2500    0.1468    2.0000
   45.0000   46.0000    0.1435         0    1.0000
   45.0000   46.0000    0.2500    0.1435    2.0000
   46.0000   47.0000    0.1402         0    1.0000
   46.0000   47.0000    0.2500    0.1402    2.0000
   47.0000   48.0000    0.1370         0    1.0000
   47.0000   48.0000    0.2500    0.1370    2.0000 ];
      
  MATERIALS = [207e9 	7833.412  	0.3
 				    0.0  	7833.412  	0.3];
              
% No disk here
DISCS=[];
%
SPRINGS = [];

% No point masses
POINT_MASS=[];
% 
FNodeDir=[13.1 13.3 43.1 43.3];
RNodeDir=FNodeDir;

% Specify reduced order
Reduct.Nmodes = 8;
Reduct.Type = 'modal';

% End of PMET4.M