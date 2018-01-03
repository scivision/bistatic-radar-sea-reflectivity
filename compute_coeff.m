function [sigmaCoPol, sigmaXPol] = compute_coeff(P)
  
  
ShadowFactor = shadow_factor(P);

[sigmaCoPol, sigmaXPol] = wave_facet_scatter(P,ShadowFactor);

[sigmaCoPol, sigmaXPol] = wide_angle_scatter(P, sigmaCoPol, sigmaXPol);

  
  
  
  
end