function [sigmaCoPol_dB, sigmaXPol_dB,...
grazRx, grazTx, phiRx, phiTx, thetaRx, thetaTx, R1, R2, Rd, hT] = ...
ReflectivityCoeff_Calculation(hR, thetad, SeaState, D, FGHz, xPatch, yPatch, Shadowing, TxPol)
% from Appendix A.1 of
% http://www.dtic.mil/dtic/tr/fulltext/u2/a610697.pdf 
% V. Gregers-Hansen and R. Mital   NRL  2014
% 

%% CONSTANTS
Re = 8500e3;   % 4/3 Earth Radius [km]
if ~nargin
  hR = 20;
  D = 10e3;
  thetad = 3.0;
  SeaState = 3;
  xPatch = 50;
  yPatch = 0;
  FGHz = 3;
  Shadowing = 'Y';
  TxPol = 'V';
end


P = struct('FGHz',FGHz,'TxPol',TxPol,'SeaState',SeaState,'Shadowing',Shadowing,...
       'hR',hR,'D',D,'Re',Re,'thetad',thetad,...
       'xPatch',xPatch,'yPatch',yPatch);
P.tanbeta0 = seaslope(P.SeaState);

%% START CALCULATION OF SURFACE REFLECTIVITY
try
P.theta1; P.theta2;
catch
P = grazing_angles(P);
end

if P.verth1 > 0 && P.verth2 > 0 
  [sigmaCoPol, sigmaXPol] = compute_coeff(P);
else
  sigmaCoPol = 0;
  sigmaXPol = 0;
end %verth1 > 0 && verth2 > 0

%% Co-and X-Pol Bistatic RCS in dB
sigmaCoPol_dB = 10.*log10(sigmaCoPol);
sigmaXPol_dB = 10.*log10(sigmaXPol);
sigmaCoPol_dB(sigmaCoPol_dB <= -80) = -80;
sigmaXPol_dB(sigmaXPol_dB <= -80) = -80;

%% output expansion
grazRx = P.grazRx;
grazTx = P.grazTx;
phiRx = P.phiRx;
phiTx = P.phiTx;
thetaRx = P.thetaRx;
thetaTx = P.thetaTx;
R1 = P.R1;
R2 = P.R2;
Rd = P.Rd;
hT = P.hT;
