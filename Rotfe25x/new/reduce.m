function Rot=reduce(Rot)
%Rot=reduce(rotor)
%
% perfrom model order reduction for a rotor
%
% - Using modal reduction
% - adds the rigid body modes to the total count
%
% I. Bucher, 8-7-98, Rev.  1.0
% I. Bucher, 28-7-99, Rev.  1.5
%
% INPUT:
%   Rot  (output of rotfe)
% with the following fields,
%   Reduct, Reduct.Nmodes, 
% OUTPUT:
%   reduced order matrices M,G,K, D and projected right hand side arguments
%        Fu_cos  Fu_sin
%   Rot.Reduct.flag=1  marks the fact that a reduction took place


if isfield(Rot,'Reduct') % reduce model ?
   
   %% Check for rigid body modes
   dd=sort(eig((Rot.K+Rot.K.')/2)); 
   Rot.Reduct.Nmodes=Rot.Reduct.Nmodes+ sum( abs(dd)<1e-2 ); %  add the rigid body modes
   																  % to the total count
   [vv dd]=eigl(Rot.K,Rot.M,Rot.Reduct.Nmodes,[1 .001 .001],1);
   
      % mass orthogonalisation
      vv=orthg(full(vv));
   %mr=diag( Q.'*Rot.M*Q );
   %vv=Q*diag( 1./sqrt(mr) );

   
   Rot.M=vv'*Rot.M*vv;
   Rot.K=vv'*Rot.K*vv;
   Rot.G=vv'*Rot.G*vv;
   Rot.Kst=vv'*Rot.Kst*vv;
      Rot.KH=vv'*Rot.KH*vv;
   Rot.D=vv'*Rot.D*vv;
if ~isempty(Rot.Fu_cos),   Rot.Fu_cos=vv.'*Rot.Fu_cos; end
if ~isempty(Rot.Fu_sin), Rot.Fu_sin=vv.'*Rot.Fu_sin; end
   
   Rot.T=vv;
   Rot.dd=sqrt(dd);
    Rot.Reduct.flag=1;  % mark the fact that the M,G,K are reduced
   Rot.Reduct.Type='modal';  % mark the fact that the M,G,K are reduced
     
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
      Q = []; disp(' reduce.m: empty basis'),
   end
