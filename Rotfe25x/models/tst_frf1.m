%tst_sim1.m
%

Rot=rotfe('unbal2');
Rot.UNBALANCE=[5 0.3 0];
Rot=rmfield(Rot,'Reduct'); % no reduction
zeta=[ones(1,4)*.09 ];%ones(1,4)*.12 ones(1,4)*.12];
Rot.PROP_DAMP=zeta;		 % add 2% damping
%Rot.D=addpdamp(Rot.M,Rot.K,zeta);
Rot=rotfe(Rot);   % build new model withour reduction
Rot.W=00;

w=[0:.2:40]';
H=rotfrf(Rot,w);
%sim_tutorial
return


Rot.Reduct.Type='modal';Rot.Reduct.Nmodes=6;
Rot=rotfe(Rot);   % build new model this time reduce order
Rot.W=00;
H1=rotfrf(Rot,w);
Rot.Reduct.Type='mixed';Rot.Reduct.Nmodes=6;
Rot=rotfe(Rot);   % build new model this time reduce order
Rot.W=00;
H2=rotfrf(Rot,w);
 
 
 semilogy(w,abs([H H1 H2]))