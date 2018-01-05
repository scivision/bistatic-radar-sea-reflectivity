function [P,gammaR] = grazing_angles(P);

P = eqn13(P);

[P,phi1,phi2,theta3,theta4] = calcphi(P);

[P.R1, P.R2] = eqn14(P,phi1,phi2);

% Calculate grazing and incidence angles from receiver hR
P.verth1 = (P.hR + P.Re) - (P.Re/cos(phi1));
horzh1 = P.Re * tan(phi1);
P.gammaR = acos((P.R1.^2 + horzh1.^2 - P.verth1.^2) ./ (2 * P.R1 .* horzh1));
if isnan(P.gammaR)
  P.gammaR = pi/2;
end

%Grazing angle from reflecting surface to Receiver
P.theta1 = pi/2 - P.gammaR;

% convenience varable
P.grazRx = rad2deg(P.gammaR);
 
P = calcreflangles(P,phi2, theta3, theta4);

end %function


function P = eqn13(P)

phi = P.D ./ P.Re;
% Calculate the height of Transmitter
try
  P.ht;
catch
  TD = deg2rad(P.thetad);
  
  P.hT = (P.Re + P.hR) .* sin(TD + pi/2) ./ ...
          sin(pi - (TD + pi/2) - phi)...
         - P.Re;      
end

P.Rd = directraylength(P, phi);
  
end % function


function Rd = directraylength(P,phi)
%% Direct ray path length
Rd = sqrt((P.hT - P.hR).^2 + 4*(P.Re + P.hR) .* (P.Re + P.hT) .* sin(phi/2).^2);
  
end
%%

function [R1, R2] = eqn14(P,phi1,phi2)
  
R1 = sqrt(P.hR.^2 + 4*P.Re .* (P.Re + P.hR) .* sin(phi1/2).^2);
R2 = sqrt(P.hT.^2 + 4*P.Re .* (P.Re + P.hT) .* sin(phi2/2).^2);
  
end % function


function [P,phi1,phi2,theta3,theta4] = calcphi(P)
  
%% Eqn 14 and 15
x1 = hypot(P.xPatch, P.yPatch);
phi1 = x1 / P.Re;
if P.xPatch == 0
  theta4 = 0;
elseif P.xPatch < 0
  theta4 = pi/2 + acos(P.xPatch./x1);
else
  theta4 = acos(P.xPatch./x1);
end

P.thetaRx = rad2deg(theta4);
x2 = sqrt(x1.^2 + P.D.^2 - 2 * x1 .* P.D .* cos(theta4));
theta3 = acos((x2.^2 + P.D.^2 - x1.^2) ./ (2 * x2 .* P.D));

P.thetaTx = rad2deg(theta3);
phi2 = x2 / P.Re;
  
end % function


function P = calcreflangles(P,phi2,theta3,theta4)

%Angle from Rx horizontal to Reflecting surface
P.phiRx = 90 - acosd(((P.Re+P.hR).^2 + P.R1.^2 - P.Re.^2) ./ (2 * P.R1 .* (P.Re+P.hR)));
P.verth2 = (P.hT + P.Re) - P.Re ./ cos(phi2);
horzh2 = P.Re * tan(phi2);

P.gammaT = acos((P.R2.^2 + horzh2.^2 - P.verth2.^2) ./...
            (2 * P.R2 .* horzh2));
if isnan(P.gammaT)
  P.gammaT = pi/2;
end

%Grazing angle from reflecting surface to Transmitter
P.grazTx = rad2deg(P.gammaT);
P.theta2 = pi/2 - P.gammaT;
%Angle from Tx horizontal to Reflecting surface
P.phiTx = 90 - acosd(((P.Re + P.hT).^2 + P.R2.^2 - P.Re.^2) ./...
                     (2 * P.R2 .* (P.Re + P.hT)));
if P.yPatch < 0 
  P.totAngle = abs(theta4) + theta3;
else
  P.totAngle = 2 * pi - (abs(theta4) + theta3);
end
  
  
end % function