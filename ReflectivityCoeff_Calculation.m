function [sigmaCoPol_dB, sigmaXPol_dB,...
grazRx, grazTx, phiRx, phiTx, thetaRx, thetaTx, R1, R2, Rd, hT] = ...
ReflectivityCoeff_Calculation(hR, thetad, SeaState, D, FGHz, xPatch, yPatch, Shadowing, TxPol, Type,hT)
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
  Type = 1;
end

%% Define slope from Sea State
switch SeaState
  case 0, tanbeta0 = 0.05;
  case 1, tanbeta0 = 0.12;
  case 2, tanbeta0 = 0.14;
  case 3, tanbeta0 = 0.15;
  case 4, tanbeta0 = 0.16;
  case 5, tanbeta0 = 0.18;
  case 6, tanbeta0 = 0.22;
  case 7, tanbeta0 = 0.25;
  otherwise error(['unknown Sea State ',int2str(SeaState)])
end

P = struct('FGHz',FGHz,'TxPol',TxPol,'SeaState',SeaState,'Shadowing',Shadowing,...
       'tanbeta0',tanbeta0,'hR',hR,'D',D,'Re',Re,'thetad',thetad,...
       'Type',Type,'xPatch',xPatch,'yPatch',yPatch);

%% START CALCULATION OF SURFACE REFLECTIVITY

[grazRx,grazTx, phiRx, phiTx, thetaRx, thetaTx, R1,R2,Rd,hT,P] = ...
    grazing_angles(P);

if P.verth1 > 0 && P.verth2 > 0 
  ShadowFactor = shadow_factor(P);

  [sigmaCoPol, sigmaXPol] = wave_facet_scatter(P,ShadowFactor);

  [sigmaCoPol, sigmaXPol] = wide_angle_scatter(P, grazRx, grazTx, sigmaCoPol, sigmaXPol);
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
