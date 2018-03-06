function [wx,wy]=animate2(vx,vy,n)
%w=animate2(vx,vy,n)
% animate a complex mode shape for a vibrating system
%
% input :
%          v  -   complex (real) mode shape
%          n  -   number of devitions in a cycle (2*pi) [optional]
%
%  output :
%          w  -   a matrix of rotated & scaled mode shapes for plotting
%
%    USE   plot(w) to see mode animated

% bucher izhak  4/10/89

if nargin<3,n=8;end
dp=pi/n; vx=vx(:); vy=vy(:);
 wx=[];  wy=wx;
 for p=0:dp:pi*2
    v1=real(vx)*cos(p)-imag(vx)*sin(p);
    v2=real(vy)*cos(p)-imag(vy)*sin(p);
  wx=[wx v1]; wy=[wy v2];
 end
