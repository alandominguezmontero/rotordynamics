%tst_sim1.m
%
%Demonstrates the usage of rotfe in a simulink diagram
%This example creates a state-space representation 

Rot=rotfe('unbal1');
Rot.UNBALANCE=[5 0.3 0];
Rot=rmfield(Rot,'Reduct'); % no model reduction, remove this field
Rot.PROP_DAMP=0.02;		 	% add 2% damping to all modes at W=0 !!!!
Rot=rotfe(Rot);   			% build new model withour reduction
Rot.W=100;
[U1 W1]=rotunbal(Rot,20000,200);
[a b c d bu du]=rot2ss(Rot);

%sim_tutorial
sim('sim_tutorial')


disp(' any key to run reduce order model')
pause

 Rot.Reduct.Type='mixed';Rot.Reduct.Nmodes=16;
 Rot=rotfe(Rot);   % build new model this time reduce order
 Rot.D=addpdamp(Rot.M,Rot.K,.02);
 [U2 W2]=rotunbal(Rot,20000,200);

 [a b c d bu du]=rot2ss(Rot);

sim('sim_tutorial')
