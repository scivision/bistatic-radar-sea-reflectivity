classdef TestCore < matlab.unittest.TestCase

methods (Test)

function test_core(tc)

[sigmaCoPol_dB, sigmaXPol_dB, grazRx, grazTx, phiRx, phiTx,...
 thetaRx, thetaTx, R1, R2, Rd, hT] = ...
ReflectivityCoeff_Calculation;%(hR, thetad, SeaState, D, FGHz,...
% xPatch, yPatch, Shadowing, TxPol,hT)

tc.assertEqual(sigmaCoPol_dB, -2.10261523881432577099)
tc.assertEqual(sigmaXPol_dB,  -80)
tc.assertEqual(grazRx, 21.80121772475218477894)
tc.assertEqual(grazTx,  3.13021359358712603083)
tc.assertEqual(phiRx,   21.80155475919652019456)
tc.assertEqual(phiTx,    3.19728335901506000027)
tc.assertEqual(thetaRx,    0)
tc.assertEqual(thetaTx,    0)
tc.assertEqual(R1, 53.85170268752635536202)
tc.assertEqual(R2, 9965.50994275009725242853)
tc.assertEqual(Rd, 10014.36908997420869127382)
tc.assertEqual(hT, 549.99431537464261054993)

end 

end

end

