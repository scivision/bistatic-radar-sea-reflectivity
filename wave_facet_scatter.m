function [sigmaCoPol, sigmaXPol] = wave_facet_scatter(P, ShadowFactor);

% eqn 12: bisector angle
% offset from 12 by 90 deg., probably for shallow angle instability
tanbeta = sqrt(sin(P.theta1).^2 - 2 .* sin(P.theta1) .* sin(P.theta2) .* cos(P.totAngle) + sin(P.theta2).^2)...
          ./ (cos(P.theta1) + cos(P.theta2));


temp1 = (1+tanbeta.^2).^2 ./ P.tanbeta0.^2 .* exp(-(tanbeta ./ P.tanbeta0).^2);
temp1 = temp1 .* ShadowFactor;


cosX = cos(P.theta1) .* cos(P.theta2) - sin(P.theta1) .* sin(P.theta2) .* cos(P.totAngle);
sinX = sqrt(1 - cosX.^2);
%sinbeta1 = sin(P.theta1) * sin(P.totAngle) / sinX;
sinbeta2 = sin(P.theta2) .* sin(P.totAngle) ./ sinX;

[a2, a3] = eqn18(P);

cosbeta1 = a3 ./ sinX;
cosbeta2 = a2 ./ sinX;

%% Calculate alpha -- to include Polarization
alpha = eqn17(P);

switch P.TxPol
  case {'h','H'}
    rho0H = eqn2(P, alpha);
    sigmaCoPol = temp1 .* real((abs(rho0H) .* cosbeta1 .* cosbeta2).^2);
    sigmaXPol  = temp1 .* real((abs(rho0H) .* cosbeta1 .* sinbeta2).^2);
  case {'v','V'}
    rho0V = eqn3(P, alpha);
    sigmaCoPol = temp1 .* real((abs(rho0V) .* cosbeta1 .* cosbeta2).^2);
    sigmaXPol  = temp1 .* real((abs(rho0V) .* cosbeta1 .* sinbeta2).^2);
end

end % function


function rho0H = eqn2(P, alpha)
  % Fresnel reflection coefficient: horizontal polarization
  
  Y = sea_permittivity(P.FGHz);
  
  Alpha = pi/2 - alpha;
  
  rho0H = (sin(Alpha) - sqrt(Y.^2 - cos(Alpha).^2)) ./ ...
          (sin(Alpha) + sqrt(Y.^2 - cos(Alpha).^2));
  
end % function


function rho0V = eqn3(P, alpha)
  % Fresnel reflection coefficient: vertical polarization
  
  Y = sea_permittivity(P.FGHz, alpha);
  
  Alpha = pi/2 - alpha;
  
  rho0V = (Y.^2 * sin(Alpha) - sqrt(Y.^2 - cos(Alpha).^2)) ./ ...
          (Y.^2 * sin(Alpha) + sqrt(Y.^2 - cos(Alpha).^2));
  
end % function


function Y = sea_permittivity(FreqGHz)
  % Eqn 5.
  
c = 299792458; % m/s
epsr = 80; % seawater
sigmac = 4; % seawater conductivity Siemens

% Electrical properties of sea water
lambda = c ./ (FreqGHz*1e9); % [m]
epsrc = epsr- 1j * 60 * lambda .* sigmac; % complex reflection coeff
murc = 1; % permittivity
Y = sqrt(epsrc ./ murc);
  
end % function


function alpha = eqn17(P)
  
alpha = acos(sqrt(1 - cos(P.gammaR)*cos(P.gammaT)*cos(P.totAngle) + sin(P.gammaR)*sin(P.gammaT)) / ...
             sqrt(2));  
  
end % function


function [a2, a3] = eqn18(P)
  
  a2 = sin(P.theta1) .* cos(P.theta2) + cos(P.theta1) .* sin(P.theta2) .* cos(P.totAngle);
  a3 = sin(P.theta2) .* cos(P.theta1) + cos(P.theta2) .* sin(P.theta1) .* cos(P.totAngle);
  
end % function
