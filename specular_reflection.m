function RhoS = specular_reflection(sigmaH, gamma, freqGHz)
  % Eqn 6 of NRL Tech Report
  % 
  % sigmaH: RMS wave height (meters)
  % freqGHz: Radar RF freqency (GHz)
  % gamma: grazing angle (deg)
  %
  % https://en.wikipedia.org/wiki/Wave_height
  c = 299792458; % m/s
  
  lambda = c/(freqGHz*1e9); % m
  
  RhoS = exp(-1/2 * ((4*pi*sigmaH.*sind(gamma)) ./ lambda).^2);
  
end  % function