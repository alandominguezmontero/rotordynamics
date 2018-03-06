%demo_rotfe
%
%Demonstrating  some of Rotfe abilities
%
% Rotfe :  a simple finite element program for rotordynamics
%
%
% Author:  Izhak Bucher
% Email:   bucher@technion.ac.il
% Where:   Mechanical Engineering
%          Technion, Israel Institute of Technology
%          Haifa 32000
%          Israel
%


%----------> Must type the below command before running this
%
%     rotfeini   <<<<<<-------------------------------------
%
%      % include all relevant folders in path <----

close all, bdclose all
echo demo_rotfe 
echo on



modeplot2 rz4
h=findobj('tag','modeplot2critspd');
h1=findobj('tag','modeplot2solid');
h2=findobj('tag','modeplot2N');
h3=findobj('tag','modeplot2modeN');
h4=findobj('tag','modeplot2section');

set(h,'value',2);  % do critical speed analysis (not modal analysis)

modeplot2 go       % compute critical speeds and corresponding motion(s)

pause(1)

for q=1:5,
    modeplot2 modeplus  % move to next mode (like pressing the + pushbutton)
    pause(3)            % wait a bit
end


set(h1,'value',1) % solid   % choose solid display (effective only in 3d mode)
set(h2,'value',1) % 3D      % switch to 3D
set(h3,'value',1) % mode 1  % choose model # 1
modeplot2 display           % and refresh display  -- like changing the displayed mode

for q=1:5,
    modeplot2 modeplus      % advnace to visialize a few modes
    pause(.3)
end

%%%%%%%%%%%%%%%%%%%%%%%%555
% campbell
%  Compute the campbell diagram of a model
%
close all
figure      % new figure
 campbell simple1s      % choose campbell-diagram  of model='simple1s' -see under models 
 campbell go            % compute
 
set(gca,'ylim',[0 350]) % choose part of the range (there are high frequencies that are not interesting)

pause (5);


close all

figure
 S=dir('models\*.m');  % use the drawrot function to show some exisitng models
 for q=1:length(S)
      try
          drawrot(S(q).name);
          pause(.3)
      catch
          disp(sprintf(' skipped %s,  this one (not a valid model',S(q).name))
      end
  end
  
close all
  for q=1:length(S)
      try
          drawrot3d_sec(S(q).name);
          pause(.3)
      catch
          disp(sprintf(' skipped %s,  this one (not a valid model',S(q).name))
      end
  end
  
 