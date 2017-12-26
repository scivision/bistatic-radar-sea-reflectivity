function [sigmaCoPol_dB, sigmaXPol_dB,...
grazRx, grazTx, phiRx, phiTx, thetaRx, thetaTx, R1, R2, Rd, hT] = ...
ReflectivityCoeff_Calculation(hR, thetad, SeaState, D, FGHz, xPatch, yPatch, Shadowing, TxPol, Type,hT)
% from Appendix A.1 of
% http://www.dtic.mil/dtic/tr/fulltext/u2/a610697.pdf 
% V. Gregers-Hansen and R. Mital   NRL  2014
% 

%% CONSTANTS
SpeedofLight = 3e8;
Re = 8500e3;
if nargin == 0
  hR = 20;
  D = 10e3;
  thetad = 3.0;
  SeaState = 3;
  xPatch = 50;
  yPatch = 0;
  FGHz = 3;
  Shadowing = 'Y';
  TxPol = 'V';
  Type = 1;
end

%% Define slope from Sea State
if SeaState == 0
  tanbeta0 = 0.05;
elseif SeaState == 1
  tanbeta0 = 0.12;
elseif SeaState == 2
  tanbeta0 = 0.14;
elseif SeaState == 3
  tanbeta0 = 0.15;
elseif SeaState == 4
  tanbeta0 = 0.16;
elseif SeaState == 5
  tanbeta0 = 0.18;
elseif SeaState == 6
  tanbeta0 = 0.22;
elseif SeaState == 7
  tanbeta0 = 0.25;
end

% Electrical properties of sea water
lambda = SpeedofLight/(FGHz*1e9);
epsrc = 80 - 60 * sqrt(-1) * lambda * 4;
murc = 1;
YEarth = sqrt(epsrc/murc);
%% START CALCULATION OF SURFACE REFLECTIVITY
alpha = D/Re;
TD = deg2rad(thetad);
% Calculate the height of Transmitter
if Type == 1
  beta = pi - (TD + pi/2) - alpha;
  hT = ((Re + hR) * sin(TD + pi/2)/ (sin(beta))) - Re;
end

Rd = sqrt((hT - hR)^2 + 4*(Re+hR)*(Re+hT)*sin(alpha/2)^2);
x1 = sqrt(xPatch^2 + yPatch^2);
alpha1 = x1/Re;
if xPatch == 0
  theta4 = 0;
elseif xPatch < 0
  theta4 = pi/2 + acos(xPatch/x1);
else
  theta4 = acos(xPatch/x1);
end

thetaRx = rad2deg(theta4);
x2 = sqrt(x1^2 + D^2 - 2 * x1 * D * cos(theta4));
theta3 = acos((x2^2 + D^2 - x1^2)/(2 * x2 * D));
thetaTx = rad2deg(theta3);
alpha2 = x2/Re;
R1 = sqrt(hR^2 + 4 * Re * (Re + hR) * sin(alpha1/2)^2);
R2 = sqrt(hT^2 + 4 * Re * (Re + hT) * sin(alpha2/2)^2);
% Calculate grazing and incidence angles from receiver hR
verth1 = (hR + Re) - (Re/cos(alpha1));
horzh1 = Re * tan(alpha1);
graz1 = acos((R1^2 + horzh1^2 - verth1^2) / (2 * R1 * horzh1));
if isnan(graz1)
  graz1 = pi/2;
end

%Grazing angle from reflecting surface to Receiver
grazRx = rad2deg(graz1);
theta1 = pi/2 - graz1;
%Angle from Rx horizontal to Reflecting surface
phiRx = 90 - acosd(((Re+hR)^2 + R1^2 - Re^2)/(2 * R1 * (Re+hR)));
verth2 = (hT + Re) - Re/(cos(alpha2));
horzh2 = Re * tan(alpha2);
graz2 = acos((R2^2 + horzh2^2 - verth2^2)/(2 * R2 * horzh2));
if isnan(graz2)
  graz2 = pi/2;
end

%Grazing angle from reflecting surface to Transmitter
grazTx = rad2deg(graz2);
theta2 = pi/2 - graz2;
%Angle from Tx horizontal to Reflecting surface
phiTx = 90 - acosd(((Re + hT)^2 + R2^2 - Re^2)/(2 * R2 * (Re + hT)));
if yPatch < 0 
  totAngle = abs(theta4) + theta3;
else
  totAngle = 2 * pi - (abs(theta4) + theta3);
end

tanbeta = sqrt(sin(theta1)^2 - 2 * sin(theta1) * sin(theta2) * cos(totAngle) + sin(theta2)^2) / (cos(theta1) + cos(theta2));

if strcmpi(Shadowing,'Y') ==1
  v1 = abs(cot(theta1))/(sqrt(2)*tanbeta0);
  v2 = abs(cot(theta2))/(sqrt(2)*tanbeta0);
  B1 = (exp(-v1 * v1) ./ v1 - sqrt(pi) * erfc(v1)) ./ (2 * sqrt(pi));
  B2 = (exp(-v2 * v2) ./ v2 - sqrt(pi) * erfc(v2)) ./ (2 * sqrt(pi));
  Shadow_Factor = (1 + erf(v1)) * (1 + erf(v2)) ./ (4 .* (1 + B1 + B2));
else
  Shadow_Factor = 1;  
end

if verth1 > 0 && verth2 > 0 
  temp1 = (1+tanbeta^2)^2/(tanbeta0^2) * exp(-(tanbeta/tanbeta0)^2);
  temp1 = temp1 * Shadow_Factor;
  %Calculate alpha -- to include Polarization
  alpha = acos((sqrt(1 - cos(graz1)*cos(graz2)*cos(totAngle) + sin(graz1)*sin(graz2)))/sqrt(2));
  Alpha = pi/2 - alpha;

  if strcmpi(TxPol,'H') == 1
    RHoriz = (sin(Alpha) - sqrt(YEarth^2 - cos(Alpha)^2)) / (sin(Alpha) + sqrt(YEarth^2 - cos(Alpha)^2));
  elseif strcmpi(TxPol,'V') ==1
    RVert = (YEarth^2 * sin(Alpha) - sqrt(YEarth^2 - cos(Alpha)^2)) / (YEarth^2 * sin(Alpha) + sqrt(YEarth^2 - cos(Alpha)^2));
  end

  cosX = cos(theta1) * cos(theta2) - sin(theta1) * sin(theta2) * cos(totAngle);
  sinX = sqrt(1 - cosX^2);
  sinbeta1 = sin(theta1) * sin(totAngle) / sinX;
  sinbeta2 = sin(theta2) * sin(totAngle) / sinX;
  cosbeta1 = (sin(theta2) * cos(theta1) + cos(theta2) * sin(theta1) * cos(totAngle))/sinX;
  cosbeta2 = (sin(theta1) * cos(theta2) + cos(theta1) * sin(theta2) * cos(totAngle))/sinX;

  if strcmpi(TxPol,'H') == 1
    sigmaCoPol =temp1 * real((abs(RHoriz) * cosbeta1 * cosbeta2)^2);
    sigmaXPol = temp1 * real((abs(RHoriz) * cosbeta1 * sinbeta2)^2);
  elseif strcmpi(TxPol,'V') == 1
    sigmaCoPol = temp1 * real((abs(RVert) * cosbeta1 * cosbeta2)^2);
    sigmaXPol = temp1 * real((abs(RVert) * cosbeta1 * sinbeta2)^2);
  end

  %Have to include Monostatic for wide angle scattering
  %     if xPatch < 0
  %         graz = grazRx;
  %     else
  graz = min(grazRx,grazTx); 
  %Choose the smaller of the two grazing angles
  %     end;
  if strcmpi(TxPol,'H') ==1
    CC1 = -73.0;  CC2 = 20.781; CC3= 7.351; CC4=25.65; CC5 = 0.0054;
  elseif strcmpi(TxPol,'V') ==1
    CC1 = -50.796; CC2 = 25.93; CC3 = 0.7093; CC4 = 21.588; CC5 = 0.00211;
  end

  temp2 = CC1 + CC2 * log10(sind(graz)) + ...
  (27.5 + CC3* graz) * log10(FGHz)/(1.0 + 0.95 * graz) + ...
  CC4 * (SeaState + 1) ^ (1/(2.0 + 0.085 * graz + 0.033 * SeaState)) + CC5 * graz.^2;

  temp2 = 10^(temp2/10);
  A = [sigmaCoPol, temp2];
  sigmaCoPol = max(A);
  A = [sigmaXPol, 0];
  sigmaXPol = max(A);
else
  sigmaCoPol = 0;
  sigmaXPol = 0;
end %verth1 > 0 && verth2 > 0

%% Co-and X-Pol Bistatic RCS in dB
sigmaCoPol_dB = 10.*log10(sigmaCoPol);
sigmaXPol_dB = 10.*log10(sigmaXPol);
if sigmaCoPol_dB <= -80
  sigmaCoPol_dB = -80;
end

if sigmaXPol_dB <= -80
  sigmaXPol_dB = -80;
end
