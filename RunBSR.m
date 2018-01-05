clear

[sigmaCoPol_dB, sigmaXPol_dB, grazRx, grazTx, phiRx, phiTx,...
 thetaRx, thetaTx, R1, R2, Rd, hT] = ...
ReflectivityCoeff_Calculation;%(hR, thetad, SeaState, D, FGHz,...
% xPatch, yPatch, Shadowing, TxPol, Type,hT)

assert(sigmaCoPol_dB, -2.10261523881432577099)
assert(sigmaXPol_dB,  -80)
assert(grazRx, 21.80121772475218477894)
assert(grazTx,  3.13021359358712603083)
assert(phiRx,   21.80155475919652019456)
assert(phiTx,    3.19728335901506000027)
assert(thetaRx,    0)
assert(thetaTx,    0)
assert(R1, 53.85170268752635536202)
assert(R2, 9965.50994275009725242853)
assert(Rd, 10014.36908997420869127382)
assert(hT, 549.99431537464261054993)