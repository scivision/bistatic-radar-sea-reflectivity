clear
%% parameters
P = struct('Shadowing','y','D',10e3,'Re',8500e3,'Type',1,...
           'hR',20,'xPatch',50,'yPatch',0);
           
N = 200; % number of points to plot (arbitrary)

%% model
P.thetad = logspace(-1,2,N); % degrees

SeaStates = [0,1,3,6];

%% iterate
figure(8), clf(8)
ax = axes('nextplot','add');
xlabel(ax,'Incident Ray: grazing angle [deg]')
ylabel(ax,'Shadow Factor [normalized]')
title(ax,'Todo')
grid(ax,'on')

for SeaState = SeaStates

  P.tanbeta0 = seaslope(SeaState);

  P = grazing_angles(P);
  ShadowFactor = shadow_factor(P);

  loglog(ax,P.thetad, ShadowFactor,'displayname',int2str(SeaState))
end

legend(ax,'show','location','southeast')