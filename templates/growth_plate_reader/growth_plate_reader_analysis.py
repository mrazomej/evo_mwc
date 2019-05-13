# -*- coding: utf-8 -*-
import sys
sys.path.insert(0, '../../../../')
import numpy as np
import pandas as pd
import string
import os
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages
import evo_utils.viz
colors = evo_utils.viz.set_plotting_style()
import evo_utils.fitderiv
import seaborn as sns
import statsmodels.api as sm

# Define the experimental constants
# For figure titles
DATE = 
RUN_NO = 

# Define parameters to group strains by
GROUP = ['strain', 'selection']

# Define if you only want to plot existing results
REPLOT = False
# ----------------------------------

# Load the data.
data = pd.read_csv(f'output/{DATE}_r{RUN_NO}_growth_plate.csv')

# Generate a dictionary of the mean blank at each time point.
blank_vals = {t: val['OD600'].mean() for t, val in
              data[data['strain'] == 'blank'].groupby(['time_min'])}

# Add mean blank values for each time point to the dataframe,
# as well as background subtracted OD values.
for k, v in blank_vals.items():
    data.loc[data['time_min'] == k, 'blank_val'] = v
data['OD_sub'] = data['OD600'] - data['blank_val']

# Group data by selected criteria
data_group = data.groupby(GROUP)
# List groups
groups = [group for group, data in data_group]

# Initialize data frame to save derivatives
columns = list(data.columns) + ['logOD_fit', 'logOD_fit_std',
                              'growth_rate', 'growth_rate_std',
                              'doubling_time', 'doubling_time_std']
df_gp = pd.DataFrame(columns=columns)

# Check if the analysis should be done
if not REPLOT:
    # Loop through groups
    for group, df in data_group:
        # Check if the group is not a blank
        if group[0] == 'blank':
            continue
        print(group)
        # Build input as required by the Gaussian process function.
        # This is time as  an array and then the OD as a 2D array with a column
        # per replica
        # Obtain time
        time = np.sort(df['time_min'].unique())
        # List wells in group
        wells = list(df.well.unique())
        # Extract OD measurements into the corresponding array
        if len(wells) == 1:  # For cases with one replica only
            OD = df[df.well == wells[0]].sort_values(by='time_min').OD600.values
        else:  # For cases with multiple replicas
            OD = np.zeros([len(time), len(wells)])
            # Loop through wells
            for i, well in enumerate(wells):
                # Extract OD data and sort by time (just in case)
                OD[:, i] = df[df.well ==
                              well].sort_values(by='time_min').OD600.values

        # Using the package [`fitderiv`]
        # (http://swainlab.bio.ed.ac.uk/software/fitderiv/)
        # from Peter Swain's lab,
        # perform non-parametric inference of the time-dependent growth rates.
        gp = evo_utils.fitderiv.fitderiv(time, OD)

        # Create dataframe with full time series results of the fit
        gp_df = gp.export('NONE', savegp=False, savestats=False)
        # List columns to be saved
        gp_df = gp_df[['t', 'od', 'log(OD)', 'log(OD) error',
                       'gr', 'gr error']]
        # Rename some columns to remove undesired characters
        gp_df.rename(columns={'log(OD)': 'logOD_fit',
                              'log(OD) error': 'logOD_fit_std',
                              'gr': 'growth_rate',
                              'gr error': 'growth_rate_std',
                              'od': 'OD600', 't': 'time_min'}, inplace=True)
        # Compute doubling time
        gp_df['doubling_time'] = np.log(2) / gp_df['growth_rate']
        # Compute doubling time STD
        gp_df['doubling_time_std'] = np.log(2) * gp_df['growth_rate_std'] /\
                                     (gp_df['growth_rate']**2)

        # List information that is missing from this dataframe
        miss_cols = [col for col in df.columns if col not in gp_df]

        gp_df = pd.concat([gp_df.reset_index(drop=True),
                           df[df.well ==
                           wells[0]][miss_cols].reset_index(drop=True)],
                          axis=1)

        # Append dataframe
        df_gp = pd.concat([df_gp, gp_df], ignore_index=True)

    # Export result
    df_gp.to_csv(f'output/{DATE}_r{RUN_NO}_gaussian_process_deriv.csv')

# Read derivatives
df_gp = pd.read_csv(f'output/{DATE}_r{RUN_NO}_gaussian_process_deriv.csv')

# group derivatives
df_gp_group = df_gp.groupby(GROUP)
# Print growth curve and its derivative for each group

# Initialize multi-page PDF
with PdfPages('output/growth_rate.pdf') as pdf:
    # Loop through groups
    for group in groups:
        # check that there are no blanks
        if group[0] == 'blank':
            continue
        # Initialize figure
        fig, ax = plt.subplots(2, 1, figsize=(4, 4), sharex=True)
        # Extract curve data
        growth_data = data_group.get_group(group)
        rate_data = df_gp_group.get_group(group)
        # Plot plate reade data
        ax[0].plot(growth_data.time_min, growth_data.OD600, lw=0, marker='.')
        # Plot growth rate with credible region
        ax[1].plot(rate_data.time_min, rate_data.growth_rate)
        ax[1].fill_between(rate_data.time_min,
                           rate_data.growth_rate + rate_data.growth_rate_std,
                           rate_data.growth_rate - rate_data.growth_rate_std,
                           alpha=0.5)
        # Label plot
        ax[0].set_title(str(group))
        ax[0].set_ylabel(r'OD$_{600}$')
        ax[1].set_ylabel(r'growth rate (min$^{-1}$)')
        ax[1].set_xlabel('time (min)')
        plt.tight_layout()
        pdf.savefig()
        plt.close()
