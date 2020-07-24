---
status: Rejected
reason: The effect of the positive and negative selection were too small
---

# 2020-07-23 Plate Reader Growth Measurement

## Purpose
Now that we have decided that the tetA single gene construct were not taking us
in the right direction is time to start testing a different strategy. The
objective of this experiment is to measure the effect of both positive selection
(tetracycline) and negative selection (sucrose) on the O2+11-sacB-tetA-c51m
constructs.

## Strain Information

| Plasmid | Genotype | Host Strain | Shorthand |
| :------ | :------- | ----------: | --------: |
| `pZS4*5-mCherry`| `none` |  HG105 |`HG105` |
| `pZS4*5-mCherry`| `galK<>25O1+11-sacB-tetA-c51m` |  HG105 |`O1 R0` |
| `pZS4*5-mCherry`| `galK<>25O1+11-sacB-tetA-c51m` |  HG104 |`O1 R22` |
| `pZS4*5-mCherry`| `galK<>25O1+11-sacB-tetA-c51m`, `ybcN<>4*5-RBS1027-lacI` |  HG105 |`O1 R260` |
| `pZS4*5-mCherry`| `galK<>25O1+11-sacB-tetA-c51m`, , `ybcN<>4*5-RBS1L-lacI` |  HG105 |`O1 R1740` |

## Plate Layout

**96 plate layout**

![plate layout](output/plate_layout.png)

## Notes & Observations


## Analysis Files

**Whole Plate Growth Curves**

![plate layout](output/growth_plate_summary.png)

**Whole Plate Growth Rate Inferences**

![plate layout](output/growth_rate_summary.png)

## Experimental Protocol

1. Cells as described in "Strain Information" were grown to saturation in 4 mL
   of LB + Spec + Kan (except `HG105`) in 14 mL culture tubes at 37ºC.

2. After ≈ 8 hours, when the LB cultures were saturated, cells were diluted
   1:1,000 into M9 + 0.5% glucose media + corresponding antibiotics and grown 
   overnight for ≈ 18 hours at 37ºC.

3. 10 µL of these saturated cultures were added to 300 µL of the corresponding
   media according to the plate layout.
   

4. The plate was placed in a Biotek Gen5 plate reader and grown at 37ºC, shaking
   in a linear mode at the fastest speed. Measurements of OD600 were taken every
   25 minutes for approximately 24 hours.

# Conclusions

The conclusions are based on a qualitative assessment of the data done with the
`growth_curve_exploration.ipynb` file.

From this data we can see that both selections were too small. 1 µg/mL
tetracycline wasn't enough, neither 0.5% sucrose. The only difference in growth
is seen in the R1740 strain. This strain was outside of the usual rows used for
consistent measurements. Even the no-selection well showed this behavior;
therefore it is unlikely that this is a real effect.

The data is not useful. We will need to increase the concentration of the
selection agents.