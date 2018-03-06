function [Rot,T,vv]=reduce(Rot,NO_rigid_modes)
%Rot=reduce(rotor)
%
% perfrom model order reduction for a rotor
%
%  This function performs a MIXED reduction which is in essense a
%  Modal reduction + static (GUYAN) reduction
%^
% Still experimental ...
% I. Bucher
 
if isfield(Rot,'Reduct') % reduce model ?
   nr=length(Rot.RESP_DOF);
   ind0=Rot.RESP_DOF;
   n=size(Rot.M,1);
   ind=1:n;
   ind1=ind; 
   ind1(ind0)=[];
   
   %>>>>>> Transform 
   T= [eye(nr) ; -Rot.K(ind1,ind1)\Rot.K(ind1,ind0)];
   T([ind0(:) ; ind1(:)],:)=T; % re-order
   %T=[];
   [vv dd]=eigl(Rot.K,Rot.M,Rot.Reduct.Nmodes);
   vv=[T vv];
   % mass orthogonalisation
   vv=orthg(full(vv));
   %mr=diag( Q.'*Rot.M*Q );
   %vv=Q*diag( 1./sqrt(mr) );
   
   Rot.M=vv'*Rot.M*vv;
   Rot.K=vv'*Rot.K*vv;
   Rot.G=vv'*Rot.G*vv;
   %       Rot.Kst=vv'*Rot.Kst*vv;
   Rot.D=vv'*Rot.D*vv;
   if ~isempty('Rot.Fu_cos')
      Rot.Fu_cos=vv.'*Rot.Fu_cos;
      Rot.Fu_sin=vv.'*Rot.Fu_sin;
   end
   Rot.T=vv;
   Rot.dd=sqrt(dd);
   Rot.Reduct.flag=1;
else
   Rot.T=eye(size(Rot.M));
   Rot.Reduct.flag=0;
   
end

function Q=orthg(A)
% find an orthonormal basis for A
%   % QR decomposition
   [Q,R,E]=qr(A);
%   % Determine r = effective rank
   tol = eps*norm(A,'fro');
   r = sum(abs(diag(R)) > tol);
   r = r(1); % fix for case where R is vector.
%   % Use first r columns of Q.
   if r > 0
      Q = Q(:,1:r);
%      % Cosmetic sign adjustment
      Q = -Q;
      Q(:,r) = -Q(:,r);
   else
      Q = []; disp(' reduces.m: empty basis'),
   end
