%Contents.m for RotFE ver 2.1
% 
% Date 2-Aug-99
% By I. Bucher
%
% rotfe2 Directory
% Contains the Rotordynamics Toolbox
%
% Finite Elemenets (Modelling)
%-----------------------------
% Rotfe  	Rotor Finite Element model (bending)
% Rottors	Rotor Finite Element model (Torsion)
% shaffet	utility to FE program (torsion) called by Rottors
%
% Reduced order modelling and handling
%--------------------------------------
% Rotfe		Build reduced order model (now handles reduced & full models)
% Rot2ss		Create state-space of reduced and full model
%
%Computaional routines + Graphical interface
%--------------------------------------------
% campbell	- compute and draw Campbell diagrams
% modeplot  - compute and draw mode shapes 
% tmodeplot - compute and plot torsional modes
% drawrot   -  draw model
% drawresp  - draw response onto mode and animate  (not fully supported)
% drawresp3 - drawresponse onto model in 3 D       (not fully supported)
%
% Roteig		Compute eigenvectos and eigenvalues
% rotmshape	compute and plot cont. Amplitude shape given corrdinates
% rotmshape3 compute and plot 3d AS ABOVE
% Rotfrf 	Compute frquency response function
% drawresp  draw a response vector overlayed onto the model
% rot2ss		convert rotor to state space (now handels reduce order models)
% rotunbal  compute the response to unbalance at different speeds
%
%Simulink/rotor (demos)
% tst_sim1 / sim_tutorial	-	basic usage of rotfe simulation of unbalance
% tst_sim2 / sim_tutorial2 -  combine exernal forces and unbalance crude appraoch
% tst_sim3 / sim_tutorial3 -  combine exernal forces and unbalance
%
% Demos
% 
rotlib		- library of simulink rotor elements & demos
% sim_tutorial -  
% simrotor1.mdl  (simulink models)
% simrotor3.mdl
% simrotor3a.mdl
% simrotor1rb.mdl
% simrotork.mdl
% rotsfunc.m		sfuntion for Simulink
% rotsfuncw			speed dependent Sfunction. Used within 
%
% Utility
% rot2templ	   convert a rotor struct into an ascii template file
% eigl			fast partial eigenvalues solution for non-rotating case 
 