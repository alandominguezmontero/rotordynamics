function disprot(Rot)
%disprot(Rot)
%
% display the parameters of a Rot structure which
% is the outcome of rotfe.m
%
% Example:
% Rot=rotfe('simple1s'); disprot(Rot)
%
% 8-8-99, By I. Bucher, Rev 0.9

fprintf('    \n    ***  Report of a Rotfe structure ** \n'), putline('-',80)
fprintf('    Total no. of dofs           %d            \n',Rot.dim)
fprintf('    Constrainted dofs           %d            \n',length(Rot.Bcord))
putline('-',80)
fprintf('    ** Constrainted dofs **       \n' )
s=Rot.cord_name(Rot.Bcord);
for q=1:length(Rot.Bcord)
   fprintf(' %s ,', s{q} )
end
fprintf('\n')

putline('-',80)

fprintf('\n    ** Forces act at **       \n' )
s=Rot.cord_name(Rot.FORCE_DOF);
for q=1:length(s),fprintf(' %s ,', s{q} ),end
fprintf('\n')
putline('-',80)

fprintf('\n    ** Response measured at **       \n' )
s=Rot.cord_name(Rot.RESP_DOF);
for q=1:length(s),fprintf('               %s ,', s{q} ),end
fprintf('\n')
putline('-',80)

fprintf('\n    ** Unbalance at **       \n' )
s=Rot.cord_name(Rot.UNBAL_DOF);
for q=1:size(Rot.UNBALANCE,1),
   fprintf('   at %s  ux=%g  uy=%g\n', s{q},Rot.UNBALANCE(q,2), Rot.UNBALANCE(q,3)),
end

fprintf('\n')
putline('-',80)
for q=1:size(Rot.SPRINGS,1)
   fprintf(' spring at node %d ,  K= ', Rot.SPRINGS(q,1) )
   fprintf(' %g,', Rot.SPRINGS(q,2:end) )
   fprintf('\n' )
end

         





function putline(c,n)
%
for q=1:n
   fprintf('%s',c)
end
   fprintf('\n')





 