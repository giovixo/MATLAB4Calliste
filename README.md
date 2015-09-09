# MATLAB for Cusp #

### Contributors ###

* G. De Cesare - decesare.giovanni@gmail.com

### Infos ###

* Code for the analysis of the Cusp Monte Carlo data
* Dependences: MATLAB

### Directories ###

* matlab: MATLAB source code
* dataset: it contains a short sample data file


### How to run ###

* Open the MATLAB on your pc
* Eventually edit PAR.m file
* Eventually edit mc.m file
* Run mc.m

The code is based on two steps data analysis.

In step 1 the data file is read and the energy deposits list for each input photons is evaluated. We call these data "raw photon history" (stored into the A array).

In step 2 the energy deposits are sampled in a pixelated detector. We call these data "pixelated photon history" (stored into Apix array).

The parameters of the run are stored into the PAR.m class.

### Example ###

```
#!matlab
% Read a file and return the data array A
A = mc_read('01PolCrabCusp.dat'); 

%% Level 1 analysis example (see 'help mc_tools1' for more)
log_text = mc_tools1(A, 1);
disp(log_text);

%% Step 2: Convert A into a 'photons history' into the 'pixelated photon history' Apix
Apix = mc_pixelize(A);

%% Level 2 analysis example (see 'help mc_tools2' for more)
log_text = mc_tools2(A, 1);
disp(log_text);

%% Level 2 analysis example (see 'help mc_polarization' for more)
[alpha, q]= mc_polarization(double_map);
plot(alpha, q,'r*')
xlabel('alpha (degree)','FontSize',18);
ylabel('Q','FontSize',18);
grid;
```
