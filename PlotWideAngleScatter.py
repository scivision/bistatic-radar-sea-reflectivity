#!/usr/bin/env python
"""Example of calling Matlab code from Python using Oct2Py"""
from oct2py import Oct2Py
import numpy as np
from matplotlib.pyplot import figure, show


def main():
    P = {'grazRx': 2.0,
         'grazTx': np.arange(0.1, 10, .1),
         'TxPol': 'V',
         'FGHz': 1.5,
         'SeaState': 3}

    with Oct2Py() as oc:
        sigmaCo = oc.wide_angle_scatter(P, 0., 0.).squeeze()
# %%
    ax = figure().gca()
    ax.plot(P['grazTx'], 10*np.log10(sigmaCo), label='co')
    ax.set_ylabel('$\sigma^0_{VV}$')
    ax.set_xlabel('Transmit grazing angle [deg]')
    ax.set_title(f'Wide Angle Scatter, {P["FGHz"]} GHz')

    show()


if __name__ == '__main__':
    main()
