clear


P = struct('Shadowing','y','Re',8500e3,'Type',1,...
           'xPatch',50,'yPatch',0);
           
N = 20; % number of points to plot (arbitrary)

%% model
SeaStates = 0; %[0,1,3,6];

grazTx = logspace(0,1.8,N); % degrees
grazRx = 21.8;

%% iterate
P.theta1 = pi/2 - deg2rad(grazRx);
P.theta2 = pi/2 - deg2rad(grazTx);

figure
ax = axes('nextplot','add');
xlabel(ax,'Incident Ray: grazing angle [deg]')
ylabel(ax,'Shadow Factor [normalized]')
grid(ax,'on')

for SeaState = SeaStates
  P.tanbeta0 = seaslope(SeaState);

  [sigmaCoPol, sigmaXPol] = compute_coeff(P);

  loglog(ax, grazTx, sigmaCoPol,'displayname',int2str(SeaState))
end

title(ax,'Vertical Polarization')

legend(ax,'show','location','southeast')