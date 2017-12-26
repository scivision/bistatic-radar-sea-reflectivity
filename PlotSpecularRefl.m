c = 299792458; % m/s
f0 = 10e9; % per pg. 4 of Report

lambda = c/f0; % m

seastate = ['0','2','3','5','6'];
sigmaH = [0,0.08,0.2,2.5,4]; 

gamma = 0:0.01:6; 

figure(1)
ax = axes('nextplot','add');
grid(ax,'on')
i = 1;
for s = sigmaH
  Rhos = specular_reflection(s,gamma,lambda);
  plot(ax,gamma,Rhos,'linewidth',2,'DisplayName',seastate(i))
  i = i+1;
end

legend(ax,'show')
title(ax,'Specular rReflectivity vs. grazing angle and sea state')