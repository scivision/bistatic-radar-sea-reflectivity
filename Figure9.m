clear
% FIXME not matching Figure 9--check Nathanson input parameters to ensure they're appropriate.

P = struct('Shadowing','y','Re',8500e3,'Type',1,...
           'xPatch',50,'yPatch',0,...
           'D',10e3,'TxPol','V','FGHz',3);
           
N = 20; % number of points to plot (arbitrary)

%% model
SeaStates = 0:6;
P.hR=20;
P.thetad = logspace(-1,1.8,200);

%% iterate
P = grazing_angles(P);

figure(9), clf(9)
ax = axes('nextplot','add');
xlabel(ax,'Transmit grazing angle [deg]')
ylabel(ax,'\sigma^0 [dB]','interpreter','latex')
grid(ax,'on')

for P.SeaState = SeaStates
  P.tanbeta0 = seaslope(P.SeaState);

  [sigmaCoPol, sigmaXPol] = compute_coeff(P);

  semilogx(ax, P.grazTx, 10*log10(sigmaCoPol),'displayname',int2str(P.SeaState))
end

title(ax,'Vertical Polarization')

legend(ax,'show','location','southeast')