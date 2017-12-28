function  P = grazing_angles(P);

%% Eqn 13
alpha = P.D/P.Re; % phi in Report
TD = deg2rad(P.thetad);
% Calculate the height of Transmitter
if P.Type == 1
  P.hT = ((P.Re + P.hR) * sin(TD + pi/2) / ...
         sin(pi - (TD + pi/2) - alpha)) - P.Re;
end

%% Direct ray path length
P.Rd = sqrt((P.hT - P.hR)^2 + 4*(P.Re+P.hR)*(P.Re+P.hT)*sin(alpha/2)^2);
%% Eqn 14 and 15
x1 = hypot(P.xPatch, P.yPatch);
alpha1 = x1 / P.Re;
if P.xPatch == 0
  theta4 = 0;
elseif P.xPatch < 0
  theta4 = pi/2 + acos(P.xPatch/x1);
else
  theta4 = acos(P.xPatch/x1);
end

P.thetaRx = rad2deg(theta4);
x2 = sqrt(x1^2 + P.D^2 - 2 * x1 * P.D * cos(theta4));
theta3 = acos((x2^2 + P.D^2 - x1^2)/(2 * x2 * P.D));

P.thetaTx = rad2deg(theta3);
alpha2 = x2 / P.Re;

P.R1 = sqrt(P.hR^2 + 4 * P.Re * (P.Re + P.hR) * sin(alpha1/2)^2);
P.R2 = sqrt(P.hT^2 + 4 * P.Re * (P.Re + P.hT) * sin(alpha2/2)^2);

% Calculate grazing and incidence angles from receiver hR
P.verth1 = (P.hR + P.Re) - (P.Re/cos(alpha1));
horzh1 = P.Re * tan(alpha1);
P.graz1 = acos((P.R1^2 + horzh1^2 - P.verth1^2) / (2 * P.R1 * horzh1));
if isnan(P.graz1)
  P.graz1 = pi/2;
end

%Grazing angle from reflecting surface to Receiver
P.theta1 = pi/2 - P.graz1;

% convenience varable
P.grazRx = rad2deg(P.graz1);

%% 

%Angle from Rx horizontal to Reflecting surface
P.phiRx = 90 - acosd(((P.Re+P.hR)^2 + P.R1^2 - P.Re^2)/(2 * P.R1 * (P.Re+P.hR)));
P.verth2 = (P.hT + P.Re) - P.Re/(cos(alpha2));
horzh2 = P.Re * tan(alpha2);
P.graz2 = acos((P.R2^2 + horzh2^2 - P.verth2^2)/(2 * P.R2 * horzh2));
if isnan(P.graz2)
  P.graz2 = pi/2;
end

%Grazing angle from reflecting surface to Transmitter
P.grazTx = rad2deg(P.graz2);
P.theta2 = pi/2 - P.graz2;
%Angle from Tx horizontal to Reflecting surface
P.phiTx = 90 - acosd(((P.Re + P.hT)^2 + P.R2^2 - P.Re^2)/(2 * P.R2 * (P.Re + P.hT)));
if P.yPatch < 0 
  P.totAngle = abs(theta4) + theta3;
else
  P.totAngle = 2 * pi - (abs(theta4) + theta3);
end

end