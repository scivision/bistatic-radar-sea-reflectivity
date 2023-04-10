function [sigmaCoPol, sigmaXPol] = compute_coeff(P)
arguments
  P (1,1) struct
end

ShadowFactor = shadow_factor(P);

[sigmaCoPol, sigmaXPol] = wave_facet_scatter(P,ShadowFactor);

[sigmaCoPol, sigmaXPol] = wide_angle_scatter(P, sigmaCoPol, sigmaXPol);
  
end