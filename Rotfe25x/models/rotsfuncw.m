function [sys,x0,str,ts] = rotsfuncw(t,x,u,flag,Rot)
%rotsfuncw
%
%      sfunc for simulink (see Simulink's help for Sfunc)
%
%  This function is used for simulation of a rotor: 
%   rotating shaft + discs etc (See RotFE)
%  The model incorporated in Rot (which is a Matlab data structure)
%  is the output of Rotfe.m
%
%   Model simulated is 
%   M*x''+(D+W*G)*x'+K*x=F_cos*cos(W*t)+F_sin(W*t)+u
%
% Where:
%    D - damping matrix (mostly dashpots)
%	  W,G - Speed of rotation [Rad/s] and Gyro matrix
%    K   - Stiffness
%    F_cos, F_sin - coef. vectors for unbalance (Rot.F_cos ..)
%    u  - external input (acting upon locations define by FNodeDir in the model template file)
%
%  ( Note: the response location are defined by RNodeDir)
%    
%   
%   See sfuntmpl.m for a general S-function template.
%
%   See also SFUNTMPL.
 
global Arot Brot Crot Drot

 switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
case 0,
   W=0;
    [Arot,Brot,Crot,Drot]=rot2ss(Rot,W);
    [sys,x0,str,ts]=mdlInitializeSizes(Arot,Brot,Crot,Drot);

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
case 1,
   n=length(u);  W=u(1); u=u(2:n);
       [Arot,Brot,Crot,Drot]=rot2ss(Rot,W);
       if length(Rot.UNBALANCE)>0 % was any unbalance in the template file
          sys = Arot*x + Brot*u;  % compute derivatives x'=Arot*x+Brot*u
          nu=size( Rot.M,1); % size of input vector
          % add unbalance, recall B=[0; inv(M)]
          
          Fu=W^2*(Rot.M\( (Rot.Fu_cos*cos(W*t)+Rot.Fu_sin*sin(W*t))));
          sys=sys+[zeros(nu,1);Fu];
       else
           sys = Arot*x + Brot*u;
       end
          
  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
case 3,
    n=length(u);  W=u(1); u=u(2:n);
    
    %sys=mdlOutputs(t,x,u,Arot,Brot,Crot,Drot);
    sys=Crot*x; % faster
  %%%%%%%%%%%%%%%%%%%
  % Unhandled flags %
  %%%%%%%%%%%%%%%%%%%
  case { 2, 4, 9 },
    sys = [];

  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end
% end rotsfuncw

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes(A,B,C,D)

sizes = simsizes;
sizes.NumContStates  = length(A);
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = size(C,1);
sizes.NumInputs      = size(B,2)+1;
sizes.DirFeedthrough = any(D(:)~=0);
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);
x0  = zeros(sizes.NumContStates,1);
str = [];
ts  = [0 0];

% end mdlInitializeSizes
 