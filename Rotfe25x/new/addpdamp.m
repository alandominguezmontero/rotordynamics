function C=addpdamp(varargin)
% D=addpdamp(M,K,zeta);
%   or
% D=addpdamp(M,K,zeta,Nmodes);
%   or
% D=addpdamp(phi,omega,zeta)
%
% M,K - mass and stiffness matrices
% zeta - modal damping coefficients                           
% or                                                          
% phi - mode shapes (mass normalised)
% omega - natural frequneices  squared
% zeta  - damping factors     
% Nmodes - (optional) allows one to determined the no. of damping factors to set
% addpdamp creates a proportional damping matrix D, such that     
% phi'*D*phi=2*diag(zeta)*diag(omega)  (diagonal matrix)      
%                                                             
% where phi are the mass-normalised eigenvectors              
% omega natural frequencies 
% zeta damping factors
%
% EXAMPLE:                                                    
% M=diag([1 2]); K=[2 -1; -1 1]; D=addpdamp(M,K,[0.01 .03]);  
% a=[zeros(2) eye(2); -M\[K D]]; s=eig(a);                    
% disp('    zeta       wn'),disp([-real(s)./abs(s) abs(s)])   
                                                            
% by I. Bucher 12-2-1996 
% 16.7.96

zeta=varargin{3};

switch nargin
case 4, [M,K,zeta,Nmodes]=deal(varargin{:});
      [phi omega]=eiglv(K,M,Nmodes,[1 .01 .01],1);   
   
case 3, 
   if min(size(varargin{2}))==1,
      [phi,omega,zeta]=deal(varargin{:}); 
      Nmodes=min(min(size(omega)),length(zeta));
   else
      [M,K,zeta]=deal(varargin{:}); 
       Nmodes=min([length(M),20,length(zeta)]);
      [phi omega]=eigl(K,M,Nmodes,[1 .01 .01],1);   
   end
   otherwise, error(' addpdamp:    wrong number of inputs')
end


if length(zeta)==1, zeta=zeta*ones(Nmodes,1); end                            

C=0.5*phi'\(diag(zeta)*diag(sqrt(omega)))/phi;  
     
  C=real(C);
