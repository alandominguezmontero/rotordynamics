function [V,D]=mkeig(K,M)
%[Vectors, EigenValues]=mkeig(K,M)
%
% [V, s]=mkeig(K,M)
%	compute the mass-normalised eigenvectors and eigenvalues of s*M*V=M*V
%
% s=mkeig(K,M)
%	compute the  eigenvalues of s*M*V=M*V
%
% by : I. Bucher 1.Nov.1993
%

 [V,D]=eig(K,M);
 [D j]=sort(diag(D));
 V=V(:,j);
 mr=diag(V.'*M*V);
 n=length(mr);
 V=V*diag(ones(n,1)./sqrt(mr(:)));
%
