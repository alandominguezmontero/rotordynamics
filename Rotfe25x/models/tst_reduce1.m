%tst_sim1.m
%

Rot=rotfe('unbal2');
Rot.UNBALANCE=[5 0.3 0];
Rot=rmfield(Rot,'Reduct'); % no reduction
zeta=[ones(1,4)*.03 ];%ones(1,4)*.12 ones(1,4)*.12];
Rot.PROP_DAMP=zeta;		 % add 2% damping
%Rot.D=addpdamp(Rot.M,Rot.K,zeta);
Rot=rotfe(Rot);   % build new model withour reduction
Rot.W=300;
[a1 b1 c1 d1 bu1 du1]=rot2ss(Rot);

%sim_tutorial


Rot.Reduct.Type='modal';Rot.Reduct.Nmodes=2;
Rot=rotfe(Rot);   % build new model this time reduce order
Rot.W=300;
[a2 b2 c2 d2 bu2 du2]=rot2ss(Rot);

Rot.Reduct.Type='mixed';Rot.Reduct.Nmodes=2;
Rot=rotfe(Rot);   % build new model this time reduce order
Rot.W=300;
[a3 b3 c3 d3 bu3 du3]=rot2ss(Rot);
 
[y x t]=impulse(a1,b1,c1,d1,1);
[y2 x2 t2]=impulse(a2,b2,c2,d2,1,t);
[y3 x3 t3]=impulse(a3,b3,c3,d3,1,t);

 	subplot(2,1,1)
plot(t,[y(:,1) y2(:,1) y3(:,1)])
legend('y1','y1_modal','y1_mixed')

subplot(2,1,2)

plot(t,[y(:,2) y2(:,2) y3(:,2)])

legend('y2','y2_modal','y2_mixed')
