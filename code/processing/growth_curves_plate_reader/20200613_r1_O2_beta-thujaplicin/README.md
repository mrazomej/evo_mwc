---
status: Rejected
reason: experiment not yet completed
---

# 2020-06-13 Plate Reader Growth Measurement

## Purpose
The purpose of this experiment is to check the effectiveness of the negative
selction given by the small molecule β-thujaplicin on cells expressing the TetA
efflux pump.

## Strain Information

| Plasmid | Genotype | Host Strain | Shorthand |
| :------ | :------- | ----------: | --------: |
| `pZS4*5-mCherry`| `wild-type` |  HG105 |`HG105` |
| `pZS4*5-mCherry`| `galK<>25O2+11-tetA-C51m` |  HG105 |`O2 R0` |
| `pZS4*5-mCherry`| `galK<>25O2+11-tetA-C51m` |  HG104 |`O2 R22` |
| `pZS4*5-mCherry`| `galK<>25O2+11-tetA-C51m`, `ybcN<>4*5-RBS1027-lacI` |  HG105 |`O2 R260` |
| `pZS4*5-mCherry`| `galK<>25O2+11-tetA-C51m`, , `ybcN<>4*5-RBS1L-lacI` |  HG105 |`O2 R1740` |

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
of LB in 14 mL culture tubes.

2. Cells were diluted 1:1000 into 4 mL of M9 + 0.5% glucose media ≈ 8 hours 
after the initial inoculation to adapt cells into the M9 media.

3. The cells were then diluted 1:100 into the plate reader 96 well plate with a
total volume of 300 µL.

4. The plate was placed in a Biotek Gen5 plate reader and grown at 37C, shaking
in a linear mode at the fastest speed. Measurements were taken every 15 minutes
for approximately 36 hours.