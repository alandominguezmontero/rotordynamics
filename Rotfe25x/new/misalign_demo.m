%misalign_demo
%
% I. bucher  begining of 2004

R=rotfe('another');  % build a model

R.MISALIGN=[4 4e-3 4e-3; 9 2e-3 -6e-3] ; % set misalgnment at bearings (nodes 4 * 9)

 drawrot another nodes

 fprintf('\n\n\n\')
 disp('note that the bearigns are indeed at 4 & 9')
 disp('>> Press key to continue <<')
 pause    % note that the bearigns are indeed at 4 & 9
 
 
  R=rotfe(R);   % re-run rotfe with the new misalignment
  
  
  Q=R.K\R.Fmalgn;   % compute the response to the misalignment via the ewquivalent reaction forces
  
  
  clf,plot_resp(R,Q);  % plot rotor + static deflection
  fprintf('\n\n\n\')
  disp(' now click mouse on deflection curves to read the displacements')
  
  disp(' Please note that near the bearings we get indeed the value of MISALIGN')
  
  disp(' --izhak')
  