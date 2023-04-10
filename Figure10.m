% Figure 10, page 18
% No shadowing
% No wide angle scatter
% 10 km downrange x 300 m crossrange patch
% 2 x 2 deg. beamwidth

clear

P = struct(Shadowing='y', Re=8500e3,...
           xPatch=50, yPatch=0,...
           D=10e3, TxPol='V',FGHz=3,...
           hR=20, SeaState=3, thetad=0);
           

%% iterate
P = grazing_angles(P);

%% Iterate over all directions to patch

%% apply beam tapering and sum returns

