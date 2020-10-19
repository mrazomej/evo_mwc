---
status: Preparing
reason: 
---

# 2020-10-19 Plate Reader Growth Measurement

## Purpose
Repeating experiment for both tetracycline and sucrose on the unrepressed strain compared to wild type, and also trying out combinations of these two substrates and see how the effects of them combine.

## Strain Information

| Plasmid | Genotype | Host Strain | Shorthand |
| :------ | :------- | ----------: | --------: |
| `none`| `none` |  HG105 |`HG105` |
| `pZS4*5-CFP`| `galK<>25O2+11-sacB-tetA-C51m` |  HG105 |`O2 R0` |


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

1. Cells as described in "Strain Information" were grown to saturation in 5 mL
   of LB + Kan overnight.

2. The next morning cells were diluted 1:1,000 into 4 mL of M9 + 0.5% glucose.

3. 10 µL of saturated M9 cultures were added to 300 µL of media according to the
   plate layout.

4. The plate was placed in a Biotek Gen5 plate reader and grown at 37ºC, shaking
   in a linear mode at the fastest speed. Measurements were taken every 25
   minutes for approximately 24 hours.

## Conclusions

The conclusions presented here come from a qualitative assessment of the data 
done with the `growth_plate_reader_exploration.ipynb` file.
