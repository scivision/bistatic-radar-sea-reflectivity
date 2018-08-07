#!/usr/bin/env python
from pathlib import Path
import subprocess
from oct2py import Oct2Py
import numpy as np
import pytest

R = Path(__file__).resolve().parents[1]


def test_bsr():
    subprocess.check_call(['octave-cli', '-q', 'Test.m'], cwd=R / 'tests')


def test_wideangle_scatter():
    P = {'grazRx': 2.0,
         'grazTx': np.arange(0.1, 10, .1),
         'TxPol': 'V',
         'FGHz': 1.5,
         'SeaState': 3}

    with Oct2Py() as oc:
        oc.addpath(str(R))
        sigmaCo = oc.wide_angle_scatter(P, 0., 0.).squeeze()

        print(sigmaCo)


def test_specular():
    freqGHz = 10  # per pg. 4 of Report
    seastate = [0, 2, 3, 5, 6]
    sigmaH = [0.01, 0.11, 0.29, 1.03, 1.61]  # Table 1 of Report for SS 0,2,3,5,6

    gamma = np.arange(0, 6, .1)

    with Oct2Py() as oc:
        for S, s in zip(seastate, sigmaH):
            Rhos = oc.specular_reflection(s, gamma, freqGHz).squeeze()
            print(Rhos)


if __name__ == '__main__':
    pytest.main(['-x', __file__])
