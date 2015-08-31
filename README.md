# MATLAB for Cusp #

### Contributors ###

* G. De Cesare - decesare.giovanni@gmail.com

### Purpose ###

* Code for the analysis of the Cusp Monte Carlo data
* Release 0.1
* Dependences: MATLAB

### Directories ###

* matlab: MATLAB source code
* dataset: it contains a short sample data file


### How to run ###

* Open the MATLAB application on your pc
* Eventually edit mc.m file
* Run mc.m

The code is based on two steps data analysis.

In step 1 the data file is read and the energy deposits list for each input photons is evaluated. We call these data "raw photon history" (stored into the A array).

In step 2 the energy deposits are sampled in a pixelated detector. We call these data "pixelated photon history" (stored into Apix array).

The parameters of the run are stored into the PAR.m class.


