%tst_sim2.m
%

Rot=rotfe('unbal2');
 Rot.Reduct.Type='modal';Rot.Reduct.Nmodes=6;
 Rot=rotfe(Rot);   % build new model this time reduce order
 Rot.D=addpdamp(Rot.M,Rot.K,.02);

 [a b c d bu du]=rot2ss(Rot);

sim('sim_tutorial2')
