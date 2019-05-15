---
status: Rejected
reason: Dilution too high. Took too long to reach maximum growth rate
---

# 2019-05-03 Plate Reader Growth Measurement

## Purpose
This experiment aims to measure the growth rate of the *E. coli* strains of interest in media with 10 µg/mL chloramphenicol selection.

## Strain Information

| Plasmid | Genotype | Host Strain | Shorthand |
| :------ | :------- | ----------: | --------: |
| `pZS4*5-mCherry`| `galK<>25O2+11-sacB-cmR-YFP` |  HG105 |`O2 R0` |
| `pZS4*5-mCherry`| `galK<>25O2+11-sacB-cmR-YFP` |  HG104 |`O2 R22` |
| `pZS4*5-mCherry`| `galK<>25O2+11-sacB-cmR-YFP`, `ybcN<>4*5-RBS1027-lacI` |  HG105 |`O2 R260` |
| `pZS4*5-mCherry`| `galK<>25O2+11-sacB-cmR-YFP`, , `ybcN<>4*5-RBS1L-lacI` |  HG105 |`O2 R1740` |
| `pZS4*5-mCherry`| `galK<>25O3+11-sacB-cmR-YFP` |  HG105 |`O3 R0` |
| `pZS4*5-mCherry`| `galK<>25O3+11-sacB-cmR-YFP` |  HG104 |`O3 R22` |
| `pZS4*5-mCherry`| `galK<>25O3+11-sacB-cmR-YFP`, `ybcN<>4*5-RBS1027-lacI` |  HG105 |`O3 R260` |
| `pZS4*5-mCherry`| `galK<>25O3+11-sacB-cmR-YFP`, , `ybcN<>4*5-RBS1L-lacI` |  HG105 |`O3 R1740` |

## Notes & Observations


## Analysis Files

**Whole Plate Growth Curves**
![plate layout](output/growth_plate_summary.png)

**Whole Plate Growth Rate Inferences**
![plate layout](output/growth_rate_summary.png)

## Experimental Protocol

1. Cells as described in "Strain Information" were grown to saturation in 0.5 mL
of LB in a deep 96 well plate.

2. Cells were diluted 1:10,000 into M9 + 0.5% glucose media on a new deep 96
well plate 12 hours before the experiment for cells to be at exponential growth.

3. The cells were then diluted 1:1000 into the plate reader 96 well plate with a
total volume of 300 µL.

4. The plate was placed in a Biotek Gen5 plate reader and grown at 37C, shaking
in a linear mode at the fastest speed. Measurements were taken every 7 minutes
for approximately 24 hours.
