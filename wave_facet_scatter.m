function [sigmaCoPol, sigmaXPol] = wave_facet_scatter(P, ShadowFactor);

c = 299792458; % m/s

% Electrical properties of sea water
lambda = c / (P.FGHz*1e9); % [m]
epsrc = 80 - 1j * 60 * lambda * 4; % complex reflection coeff
murc = 1; % permittivity
YEarth = sqrt(epsrc/murc);

% eqn 12: bisector angle
tanbeta = sqrt(sin(P.theta1)^2 - 2 * sin(P.theta1) * sin(P.theta2) * cos(P.totAngle) + sin(P.theta2)^2)...
          / (cos(P.theta1) + cos(P.theta2));


temp1 = (1+tanbeta^2)^2/(P.tanbeta0^2) * exp(-(tanbeta/P.tanbeta0)^2);
temp1 = temp1 * ShadowFactor;
%Calculate alpha -- to include Polarization
alpha = acos((sqrt(1 - cos(P.graz1)*cos(P.graz2)*cos(P.totAngle) + sin(P.graz1)*sin(P.graz2)))/sqrt(2));
Alpha = pi/2 - alpha;

if strcmpi(P.TxPol,'H')
  RHoriz = (sin(Alpha) - sqrt(YEarth^2 - cos(Alpha)^2)) / (sin(Alpha) + sqrt(YEarth^2 - cos(Alpha)^2));
elseif strcmpi(P.TxPol,'V')
  RVert = (YEarth^2 * sin(Alpha) - sqrt(YEarth^2 - cos(Alpha)^2)) / (YEarth^2 * sin(Alpha) + sqrt(YEarth^2 - cos(Alpha)^2));
end

cosX = cos(P.theta1) * cos(P.theta2) - sin(P.theta1) * sin(P.theta2) * cos(P.totAngle);
sinX = sqrt(1 - cosX^2);
sinbeta1 = sin(P.theta1) * sin(P.totAngle) / sinX;
sinbeta2 = sin(P.theta2) * sin(P.totAngle) / sinX;
cosbeta1 = (sin(P.theta2) * cos(P.theta1) + cos(P.theta2) * sin(P.theta1) * cos(P.totAngle))/sinX;
cosbeta2 = (sin(P.theta1) * cos(P.theta2) + cos(P.theta1) * sin(P.theta2) * cos(P.totAngle))/sinX;

if strcmpi(P.TxPol,'H')
  sigmaCoPol =temp1 * real((abs(RHoriz) * cosbeta1 * cosbeta2)^2);
  sigmaXPol = temp1 * real((abs(RHoriz) * cosbeta1 * sinbeta2)^2);
elseif strcmpi(P.TxPol,'V')
  sigmaCoPol = temp1 * real((abs(RVert) * cosbeta1 * cosbeta2)^2);
  sigmaXPol = temp1 * real((abs(RVert) * cosbeta1 * sinbeta2)^2);
end