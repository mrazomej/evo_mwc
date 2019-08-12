# Our numerical workhorses
import numpy as np
import pandas as pd

"""
Title:
    model.py
Last update:
    2019-05-13
Author(s):
    Manuel Razo-Mejia
Purpose:
    This file compiles all of the relevant functions for theoretical models of
    gene regulation related to the evo_mcw project.
"""


# THERMODYNAMIC FUNCTIONS
def p_act(C, ka=139, ki=0.53, epsilon=4.5, logC=False):
    '''
    Returns the probability of a lac repressor being in the active state, i.e.
    able to bind the promoter as a function of the ligand concentration.

    Parameters
    ----------
    C : array-like.
        concentration(s) of ligand at which evaluate the function.
    ka, ki : float.
        dissociation constants for the active and inactive states respectively
        in the MWC model of the lac repressor.
    epsilon : float.
        energetic barrier between the inactive and the active state.
    logC : Bool.
        boolean indicating if the concentration is given in log scale

    Returns
    -------
    p_act : float.
        The probability of the repressor being in the active state.
    '''
    C = np.array(C)
    if logC:
        C = 10**C

    return (1 + C / ka)**2 / \
        ((1 + C / ka)**2 + np.exp(-epsilon) * (1 + C / ki)**2)


def fold_change(C, R, eRA, ka=139, ki=0.53, Nns=4.6E6, epsilon=4.5,
                         logC=False):
    '''
    Computes the gene expression fold-change as expressed in the simple
    repression thermodynamic model of gene expression as a function of
    repressor copy number, repressor-DNA binding energy, and MWC parameters.

    Parameters
    ----------
    C : array-like.
        concentration(s) of ligand at which evaluate the function.
    R : array-like.
        repressor copy number per cell
    eRA : array-like.
        repressor-DNA binding energy
    ka, ki : float.
        dissociation constants for the active and inactive states respectively
        in the MWC model of the lac repressor.
    Nns : float. Default = 4.6E6
        number of non-specific binding sites in the bacterial genome.
    epsilon : float.
        energetic barrier between the inactive and the active state.
    logC : Bool.
        boolean indicating if the concentration is given in log scale

    Returns
    -------
    p_act : float.
        The probability of the repressor being in the active state.
    '''
    return (1 + R / Nns * p_act(C, ka, ki, epsilon, logC) * np.exp(-eRA))**-1

