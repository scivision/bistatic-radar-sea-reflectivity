function [sigmaCoPol, sigmaXPol] = wide_angle_scatter(P, sigmaCoPol, sigmaXPol)

  sigmaMdb = eqn21(P);

  [sigmaCoPol, sigmaXPol] = eqn22(sigmaMdb,sigmaCoPol,sigmaXPol);
  
end


function sigma = eqn21(P)
%Have to include Monostatic for wide angle scattering
  %     if xPatch < 0
  %         graz = grazRx;
  %     else
  graz = min(P.grazRx, P.grazTx); 
  %Choose the smaller of the two grazing angles
  %     end;
  
  
  %% Table 2
  switch(lower(P.TxPol))
    case 'h', CC1 = -73.0;  CC2 = 20.781; CC3= 7.351; CC4=25.65; CC5 = 0.0054;
    case 'v', CC1 = -50.796; CC2 = 25.93; CC3 = 0.7093; CC4 = 21.588; CC5 = 0.00211;
  end
  
  sigma = CC1 ...
    + CC2 * log10(sind(graz)) ...
    + (27.5 + CC3 * graz) * log10(P.FGHz) ./ (1.0 + 0.95 * graz) ...
    + CC4 * (P.SeaState + 1) .^ (1./(2.0 + 0.085 * graz + 0.033 * P.SeaState)) ...
    + CC5 * graz.^2;
  
end


function [sigmaCoPol, sigmaXPol] = eqn22(sigmaMdb,sigmaCoPol,sigmaXPol)
  
  sigma_M = 10.^(sigmaMdb ./ 10.);
  sigmaCoPol = max(sigmaCoPol, sigma_M);
  
  sigmaXPol = max(sigmaXPol, 0.);
  
end
