
P = struct('SeaState',3,'Shadowing','y','D',10e3,'Re',8500e3,'thetad',3.0,'Type',1,...
           'hR',20,'xPatch',50,'yPatch',9);

P.tanbeta0 = seaslope(P.SeaState);

P = grazing_angles(P);
ShadowFactor = shadow_factor(P);

figure(8), clf(8)
plot(ShadowFactor)