import numpy as np
from matplotlib.pyplot import figure, show
from oct2py import Oct2Py


def plot_specular_refl(fGHz, seastate, sigmaH):

    gamma = np.arange(0, 6, .1)
# %% Figure 2 of Report
# doesn't quite match  Figure 2.
    ax = figure(2).gca()

    with Oct2Py() as oc:
        for S, s in zip(seastate, sigmaH):
            Rhos = oc.specular_reflection(s, gamma, fGHz).squeeze()
            ax.plot(gamma, Rhos, label=S)

    ax.grid(True)
    ax.legend()
    ax.set_title('Specular Reflectivity vs. grazing angle and sea state')
    ax.set_xlabel('Grazing angle [deg]')
    ax.set_ylabel('reflection [normalized]')


if __name__ == '__main__':
    fGHz = 10  # per pg. 4 of Report
    seastate = [0, 2, 3, 5, 6]
    sigmaH = [0.01, 0.11, 0.29, 1.03, 1.61]  # Table 1 of Report for SS 0,2,3,5,6

    plot_specular_refl(fGHz, seastate, sigmaH)

    show()
