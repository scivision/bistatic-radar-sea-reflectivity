function RhoS = specular_reflection(sigmaH,gamma,lambda)
  % Eqn 6 of NRL Tech Report
  % 
  % sigmaH: RMS wave height (meters)
  % lambda: radar wavelength  (meters)
  % gamma: grazing angle (deg)
  %
  % https://en.wikipedia.org/wiki/Wave_height
  
  RhoS = exp(-1/2 * ((4*pi*sigmaH.*sind(gamma))./lambda).^2);
  
end  % function