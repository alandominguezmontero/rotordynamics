function [phi,lam,lamerr,nit] = eigl(K,M,nm,options,shift)

ShiftStatus = 0;                     
ts_clk  = clock;
comp = computer; comp = comp(1:3);   

 
if nargin == 3
   
   Verbose = 1;
   Dofopt  = 1;
   Maxerr  = .01;
   
elseif nargin == 4
   
   if isempty(options)
      Verbose = 0;
      Dofopt  = 1;
      Maxerr  = .01;
   else
      Verbose = options(1);
      Dofopt  = options(2);
      Maxerr  = options(3);
   end
   
elseif nargin == 5
   
   if isempty(options)
      Verbose = 1;
      Dofopt  = 1;
      Maxerr  = .01;
   else
      Verbose = options(1);
      Dofopt  = options(2);
      Maxerr  = options(3);
   end
   
   if shift ~= 0
      K = K + shift*M;   %apply the shift
      ShiftStatus = 1;   %shift will be applied
   end
   
end
Verbose=0;

% ------------------ Number of DOFs
ndof  = size(K,1);
if ndof <= 1
   return
end

% ------------------ Number of Modes
if nm > ndof
   nm = ndof;
end

% ------------------ Number of Modes for Convergence 
if nm <= ndof/3
   nmconv = 2*nm;
else
   nmconv = nm;
end

if Verbose
   fprintf(1,'Lanczos Start\n')
end
% ------------------------------------------------------- Optimize DOF Ordering
if Dofopt
   if Verbose
      if comp == 'PCW'
         fprintf(1,'   Optimize DOFs\n')   
      else
         fprintf(1,'   Optimize DOFs\r')
      end
      tt_clk = clock;
   end
   
   p       = symamd(K);
   [xx,pp] = sort(p);
   K       = K(p,p);
   M       = M(p,p);
   
   
   if Verbose
      fprintf(1,'   Optimize DOFs %5i sec\n',round(etime(clock,tt_clk)))
   end
end
% ------------------------------------------------------- Cholesky Decomposition
if Verbose
   if comp == 'PCW'
      fprintf(1,'   Cholesky\n')
   else
      fprintf(1,'   Cholesky\r')
   end
   tt_clk = clock;
end

K = chol(K);

if Verbose
   fprintf(1,'   Cholesky      %5i sec\n',round(etime(clock,tt_clk)))
   if comp == 'PCW'
      fprintf(1,'   Iteration   0\n')
   else
      fprintf(1,'   Iteration   0\r')
   end
   tt_clk = clock;
end
% ------------------------------------------------------- Initialize

nmup  = min(3*nm,ndof);    % Used to initialize Lanczos Matrix 
phi   = zeros(ndof,nmup);  % Lanczos Matrix
hh    = zeros(nmup,nmup);  % Reduced Ritz Matrix

% ------------------------------------------------------- First Iteration

vec      = rand(ndof,1);      % Starting Vector
bb       = sqrt(vec'*M*vec);
phi(:,1) = vec/bb;
vec      = K'\(M*phi(:,1));
vec      = K\vec;
aa       = phi(:,1)'*M*vec;

% ------------------------------------------------------- Other Iterations

for im = 2:ndof+1
   %  ------------------------------------------- Lanczos Calculation
   
   if Verbose
      if comp == 'PCW'
         fprintf(1,'   Iteration %3i %5i sec\n',im-1, ...
            round(etime(clock,tt_clk)))
      else
         fprintf(1,'   Iteration %3i %5i sec\r',im-1, ... 
            round(etime(clock,tt_clk)))
      end
      tt_clk = clock;
   end
   
   vec    = vec - aa*phi(:,im-1);
   
   if im>2
      vec = vec - bb*phi(:,im-2);
   end
   
   %  ------------------------------------------- Schmidt Reorthogonalization
   vmp = phi(:,1:im-1)'*(M*vec);
   vec = vec - phi(:,1:im-1)*vmp;
   
   %  ------------------------------------------- Lanczos Scaler Parameters
   bb  = sqrt(vec'*M*vec);
   
   %  ------------------------------------------- Reduced Ritz Matrix
   nit = im-1;
   
   hh(nit,nit) = aa;
   hh(nit,im)  = bb;
   hh(im,nit)  = bb;
   
   %  ------------------------------------------- Convergence Check
   if (nit >= nmconv & ~rem(nit,10)) | nit == ndof
      %     ---------------------------------------- Reduced Tridiagonal Matrix 
      
      [phr,lam] = eig(hh(1:nit,1:nit));
      lam       = 1 ./ abs(diag(lam));
      [lam,ind] = sort(lam);
      phr       = real(phr(:,ind));
      
      
      %     ---------------------------------------- Upper Error Bound on Eigenvalues
      
      lamerr    = 100*abs(bb*(phr(nit,:)'.*lam));
      
      if max(lamerr(1:nm)) < Maxerr | nit == ndof
         
         %        ------------------------------------- Converged Modes
         phi       = phi(:,1:nit)*phr(:,1:nm);
         if Dofopt
            phi    = phi(pp,:);
         end
         lam       = lam(1:nm);
         lamerr    = lamerr(1:nm);
         
         if Verbose
            fprintf(1,'\nLanczos End      %5i sec\n',round(etime(clock,ts_clk)))
         end
         
         break
         
      end
      
   end
   
   %  ------------------------------------------- Other Lanczos Scaler Parameters
   phi(:,im) = vec/bb;
   vec       = K'\(M*phi(:,im));
   vec       = K\vec;
   aa        = phi(:,im)'*M*vec;
   
   %  ------------------------------------------- End of Loop
end


% if a shift is applied the eigenvalues of the original system are given by
if ShiftStatus == 1
   lam = lam - shift;
end

return

