classdef TestUnit < matlab.unittest.TestCase

methods (TestMethodSetup)

function apath(~)
cwd = fileparts(mfilename('fullfile'));
addpath(fullfile(cwd, '..'))
end
end

methods (Test)

function test_wideangle_scatter(tc)

P = struct(grazRx=2.0, grazTx=5, TxPol='V', FGHz=1.5, SeaState=3);

sigmaCo = wide_angle_scatter(P, 0., 0.);

tc.verifyEqual(sigmaCo, 1.97404113e-5, RelTol=0.001)

end

function test_specular(tc)

freqGHz = 10;  % pg. 4 of Report
sigmaH = 1.03; % Table 1 of Report for SS 5

gamma = 3;

Rhos = specular_reflection(sigmaH, gamma, freqGHz);
tc.verifyEqual(Rhos, 1.354232695e-111, RelTol=0.001)

end

end

end