% TODO off by constant. Shapes seem right.
% Figure 8.

clear
%% parameters
P = struct('Shadowing','y','Re',8500e3,'Type',1,...
           'xPatch',50,'yPatch',0);
           
N = 200; % number of points to plot (arbitrary)

%% model
SeaStates = [0,1,3,6];

grazTx = [1,5,10]; % degrees
grazRx = logspace(-1,2,N);

%% iterate
P.theta1 = pi/2 - deg2rad(grazRx);
theta2 = pi/2 - deg2rad(grazTx);
i=0;
for P.theta2 = theta2
  i=i+1;
  
  figure
  ax = axes('nextplot','add');
  xlabel(ax,'Incident Ray: grazing angle [deg]')
  ylabel(ax,'Shadow Factor [normalized]')
  grid(ax,'on')
  
  for SeaState = SeaStates
    P.tanbeta0 = seaslope(SeaState);

    ShadowFactor = shadow_factor(P);

    loglog(ax, grazRx, ShadowFactor,'displayname',int2str(SeaState))
  end
  
  title(ax,['TX grazing angle (deg): ',num2str(grazTx(i))])
end

legend(ax,'show','location','southeast')