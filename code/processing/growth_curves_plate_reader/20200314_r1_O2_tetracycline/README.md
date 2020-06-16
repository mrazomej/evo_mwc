---
status: Rejected
reason: O2-R1740 does not follow the expected trend. Possible contamination.
---

# 2020-03-14 Plate Reader Growth Measurement

## Purpose
The objective of this experiment is to measure the growth rate differences of
all of the O2 constructs with more precision.

## Strain Information

| Plasmid | Genotype | Host Strain | Shorthand |
| :------ | :------- | ----------: | --------: |
| `pZS4*5-mCherry`| `wild type` |  HG105 |`wt` |
| `pZS4*5-mCherry`| `galK<>25O2+11-tetA-C51m` |  HG105 |`O2 ∆` |
| `pZS4*5-mCherry`| `galK<>25O2+11-tetA-C51m` |  HG104 |`O2 R22` |
| `pZS4*5-mCherry`| `galK<>25O2+11-tetA-C51m`, `ybcN<>5-RBS1027-lacI` |  HG104 |`O2 R260` |
| `pZS4*5-mCherry`| `galK<>25O2+11-tetA-C51m`, `ybcN<>5-RBS1L-lacI` |  HG104 |`O2 R1740` |


## Plate Layout

**96 plate layout**

![plate layout](output/plate_layout.png)


## Notes & Observations
The plate was arranged in a checkerboard way using only the 4 central rows of
the plate to remove biases in oxygenation and therefore growth rate for
different sections of the plate.

## Analysis Files

**Whole Plate Growth Curves**

![plate layout](output/growth_plate_summary.png)

**Whole Plate Growth Rate Inferences**

![plate layout](output/growth_rate_summary.png)

## Experimental Protocol

1. Cells as described in "Strain Information" were grown to saturation in 4 mL
   of LB in a deep 96 well plate.

2. Cells were diluted 1:1000 into 4 mL of M9 + 0.5% glucose media in culture
   tubes and grown until saturation.

3. The cells were then diluted 1:50 into the plate reader 96 well plate with a
   total volume of 300 µL.

4. The plate was placed in a Biotek Gen5 plate reader and grown at 37ºC,
   shaking in a linear mode at the fastest speed. Measurements were taken every
   15 minutes for approximately 20 hours.

## Conclusion

The conclusions listed here come from an exploration of the data. In particular
the file `growth_plate_reader_exploration.ipynb` with its interactive plots
was used to reach these conclusions.

The **best concentration of tetracycline** seems to lie between **1 and 2
µg/mL**. Above that the selection is too strong and the cells don't grow
particularly well.

The data reveals something troublesome about the `O2-R1740` strain. It seems not
to follow the cool trend that the other strains were following. In particular it
is worrisome that is seems to resemble too much the `O2-R22` data. This could
indicate that there is a contamination of the strain, but further experiments
will need to be done in order to assess this claim.