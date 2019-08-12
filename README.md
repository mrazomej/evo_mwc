# `evo_mwc` 

## Overview
This repository contains all active research materials for a project using MWC
model parameters as selectable quantitative traits.

## Layout
The repository is split into seven main directories, many of which have
subdirectories. This structure has been designed to be easily navigable by
humans and computers alike, allowing for rapid location of specific files and
instructions. Within each directory is a `README.md` file which summarizes the
purpose of that directory as well as some examples where necessary. 

### **`code`** 
Where all of the *executed* code lives. This includes pipelines, scripts, and
figure files. 
 * **`processing`**: Any code used to *transform* the data into another type
   should live here. This can include everything from parsing of text data,
   image segmentation/filtering, or simulations.
 * **`analysis`**: Any code to to *draw conclusions* from an experiment or data
   set. This may include regression, dimensionality reduction, or calculation
   of various quantities.
 * **`exploratory`**: A sandbox where you keep a record of your different
   approaches to transformation, interpretation, cleaning, or generation of
   data.
 * **`figures`**: Any code used to generate figures for your finished work,
   presentations, or for any other use.

### **`data`** 
All raw data collected from your experiments as well as copies of the
transformed data from your processing code. 

### **`miscellaneous`** 
Files that may not be code, but are important for reproducibility of your
findings.
* **`protocols`**: A well annotated and general description of the experiments.

* **`materials`**: Information regarding the materials used in the experiments

* **`software details`**: Information about your computational environment 

### **`tests`** 
All test suites for your code. *Any custom code you've written should be
thoroughly and adequately tested to make sure you know how it is working.*

### **`evo_mwc`** 
Custom code you've written that is *not* executed directly, but is called from
files in the `code` directory. If you've written your code in Python, for
example, this can be the root folder for your custom software module or simply
house a file with all of your functions. 

### **`templates`** 
Files that serve as blank templates that document the procedures taken for each
experiment, simulation, or analysis routine. 

# License Information
<img src="https://licensebuttons.net/l/by-nd/3.0/88x31.png"> This work is
licensed under [CC-BY-ND](https://creativecommons.org/licenses/by-nd/4.0/). All
software is issued under the standard MIT license which is as follows:

```
Copyright 2019, The authors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```