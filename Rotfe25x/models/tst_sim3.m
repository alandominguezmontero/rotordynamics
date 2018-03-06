%tst_sim3.m
%
%Demonstrates the usage of rotfe in a simulink diagram
%This example creates a state-space representation 

Rot=rotfe('unbal1');
Rot.UNBALANCE=[5 0.3 0];
Rot=rmfield(Rot,'Reduct'); % no model reduction, remove this field
Rot.PROP_DAMP=0.02;		 	% add 2% damping to all modes at W=0 !!!!
Rot=rotfe(Rot);   			% build new model withour reduction
Rot.W=100;
[a b c d bu du]=rot2ss(Rot);
B=[bu*[Rot.Fu_cos Rot.Fu_sin] b];
D=[0*d(:,1:2) d];
%sim_tutorial
sim('sim_tutorial3')
yf=y;


disp(' any key to run reduce order model')
pause

 Rot.Reduct.Type='modal';Rot.Reduct.Nmodes=4;
 Rot=rotfe(Rot);   % build new model this time reduce order
 Rot.D=addpdamp(Rot.M,Rot.K,.02);
 Rot.W=100;
 [a b c d bu du]=rot2ss(Rot);
 B=[bu*[Rot.Fu_cos Rot.Fu_sin] b];
 D=[0*d(:,1:2) d];

%sim_tutorial
sim('sim_tutorial3')

figure
subplot(2,1,1)
plot(yf.time,yf.signals.values(:,1),y.time,y.signals.values(:,1))
subplot(2,1,2)
plot(yf.time,yf.signals.values(:,2),y.time,y.signals.values(:,2))
 title(' full modal vs. modal-reduced')