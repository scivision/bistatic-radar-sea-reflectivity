
% TODO needs clarification on parameter sweep (iterative solver?)
clear
%% parameters
P = struct('Shadowing','y','Re',8500e3,'Type',1,...
           'xPatch',50,'yPatch',0);
           
N = 200; % number of points to plot (arbitrary)

%% model
thetad = [.90, 4.8575, 9.835];

SeaStates = [0,1,3,6];

P.D = 10e3;

P.hR = 10:10:100;

%% iterate


for td = thetad
  P.thetad = td;
  
  figure
  ax = axes('nextplot','add');
  xlabel(ax,'Incident Ray: grazing angle [deg]')
  ylabel(ax,'Shadow Factor [normalized]')
  grid(ax,'on')
  
  for SeaState = SeaStates

    P.tanbeta0 = seaslope(SeaState);

    P = grazing_angles(P);

    ShadowFactor = shadow_factor(P);

    loglog(ax,P.grazRx, ShadowFactor,'displayname',int2str(SeaState))
  end
  title(ax,['TX grazing angle (deg): ',num2str(P.grazTx)])
end

legend(ax,'show','location','southeast')