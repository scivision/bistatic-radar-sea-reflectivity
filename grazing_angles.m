function [grazRx, grazTx, phiRx, phiTx,thetaRx, thetaTx,R1,R2,Rd,hT,P] = grazing_angles(P);

alpha = P.D/P.Re;
TD = deg2rad(P.thetad);
% Calculate the height of Transmitter
if P.Type == 1
  beta = pi - (TD + pi/2) - alpha;
  hT = ((P.Re + P.hR) * sin(TD + pi/2)/ (sin(beta))) - P.Re;
end

Rd = sqrt((hT - P.hR)^2 + 4*(P.Re+P.hR)*(P.Re+hT)*sin(alpha/2)^2);
x1 = sqrt(P.xPatch^2 + P.yPatch^2);
alpha1 = x1 / P.Re;
if P.xPatch == 0
  theta4 = 0;
elseif P.xPatch < 0
  theta4 = pi/2 + acos(P.xPatch/x1);
else
  theta4 = acos(P.xPatch/x1);
end

thetaRx = rad2deg(theta4);
x2 = sqrt(x1^2 + P.D^2 - 2 * x1 * P.D * cos(theta4));
theta3 = acos((x2^2 + P.D^2 - x1^2)/(2 * x2 * P.D));
thetaTx = rad2deg(theta3);
alpha2 = x2 / P.Re;
R1 = sqrt(P.hR^2 + 4 * P.Re * (P.Re + P.hR) * sin(alpha1/2)^2);
R2 = sqrt(hT^2 + 4 * P.Re * (P.Re + hT) * sin(alpha2/2)^2);

% Calculate grazing and incidence angles from receiver hR
P.verth1 = (P.hR + P.Re) - (P.Re/cos(alpha1));
horzh1 = P.Re * tan(alpha1);
P.graz1 = acos((R1^2 + horzh1^2 - P.verth1^2) / (2 * R1 * horzh1));
if isnan(P.graz1)
  P.graz1 = pi/2;
end

%Grazing angle from reflecting surface to Receiver
P.theta1 = pi/2 - P.graz1;

% convenience varable
grazRx = rad2deg(P.graz1);

%% 

%Angle from Rx horizontal to Reflecting surface
phiRx = 90 - acosd(((P.Re+P.hR)^2 + R1^2 - P.Re^2)/(2 * R1 * (P.Re+P.hR)));
P.verth2 = (hT + P.Re) - P.Re/(cos(alpha2));
horzh2 = P.Re * tan(alpha2);
P.graz2 = acos((R2^2 + horzh2^2 - P.verth2^2)/(2 * R2 * horzh2));
if isnan(P.graz2)
  P.graz2 = pi/2;
end

%Grazing angle from reflecting surface to Transmitter
grazTx = rad2deg(P.graz2);
P.theta2 = pi/2 - P.graz2;
%Angle from Tx horizontal to Reflecting surface
phiTx = 90 - acosd(((P.Re + hT)^2 + R2^2 - P.Re^2)/(2 * R2 * (P.Re + hT)));
if P.yPatch < 0 
  P.totAngle = abs(theta4) + theta3;
else
  P.totAngle = 2 * pi - (abs(theta4) + theta3);
end

end