function [Rot,T,vv]=reduceg(Rot,NO_rigid_modes)
%Rot=reduceg(rotor)
%
% perfrom model order reduction of a rotor
%
%  This function performs a MIXED reduction which is in essense a
%  Modal reduction + static (GUYAN) reduction
%^
% I. Bucher, 28-7-99, Rev.  1.5
%
% INPUT:
%   Rot  (output of rotfe)
% with the following fields,
%   Reduct, Reduct.Nmodes, Rot.RESP_DOF
% OUTPUT:
%   reduced order matrices M,G,K, D and projected right hand side arguments
%        Fu_cos  Fu_sin
%   Rot.Reduct.flag=1  marks the fact that a reduction took place
%   Rot.T the transformation matrix



if isfield(Rot,'Reduct') % reduce model ?
   nr=length(Rot.RESP_DOF);	% no. of master dof
   ind0=Rot.RESP_DOF;		   % and the co-ordinates
   n=size(Rot.M,1);			   % total no. of dofs
   ind=1:n; ind1=ind; 		   % cord. vector
   ind1(ind0)=[];					% remove master cords.

dd=0;
vv= [eye(nr) ; -Rot.K(ind1,ind1)\Rot.K(ind1,ind0)]; % static reduction  - solve for non-master
vv([ind0(:) ; ind1(:)],:)=vv; % reorder 
   % mass orthogonalisation
   vv=orthg(full(vv));         % remove dependent columns
   %mr=diag( Q.'*Rot.M*Q );
   %vv=Q*diag( 1./sqrt(mr) );
   
   Rot.M=vv'*Rot.M*vv;   Rot.K=vv'*Rot.K*vv;   Rot.G=vv'*Rot.G*vv;
   %       Rot.Kst=vv'*Rot.Kst*vv;
   Rot.D=vv'*Rot.D*vv;
   if ~isempty(Rot.Fu_cos)
      Rot.Fu_cos=vv.'*Rot.Fu_cos;
   	Rot.Fu_sin=vv.'*Rot.Fu_sin;
   end
   
   Rot.T=vv;
   Rot.dd=sqrt(dd);
   Rot.Reduct.flag=1;
   Rot.Reduct.Type='static';
   
else  % no Reduct sub-field therefore ignore completely
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
