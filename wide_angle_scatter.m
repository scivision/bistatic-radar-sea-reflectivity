function [sigmaCoPol, sigmaXPol] = wide_angle_scatter(P, grazRx, grazTx,sigmaCoPol, sigmaXPol)

  %Have to include Monostatic for wide angle scattering
  %     if xPatch < 0
  %         graz = grazRx;
  %     else
  graz = min(grazRx,grazTx); 
  %Choose the smaller of the two grazing angles
  %     end;
  
%% Table 2
  if strcmpi(P.TxPol,'H')
    CC1 = -73.0;  CC2 = 20.781; CC3= 7.351; CC4=25.65; CC5 = 0.0054;
  elseif strcmpi(P.TxPol,'V')
    CC1 = -50.796; CC2 = 25.93; CC3 = 0.7093; CC4 = 21.588; CC5 = 0.00211;
  end

%% Eqn 21
  sigma_M = CC1...
          + CC2 * log10(sind(graz))...
          + (27.5 + CC3 * graz) * log10(P.FGHz) / (1.0 + 0.95 * graz)...
          + CC4 * (P.SeaState + 1) .^ (1/(2.0 + 0.085 * graz + 0.033 * P.SeaState))...
          + CC5 * graz.^2;
%% Eqn 22
  sigma_M_db = 10.^(sigma_M./10.);
  sigmaCoPol = max(sigmaCoPol, sigma_M_db);
  
  sigmaXPol = max(sigmaXPol, 0.);
end