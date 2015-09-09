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
%% Step 1: read the file and return the data array
disp('> Step 1...');
ticID = tic; A = mc_read('01PolCrabCusp.dat'); toc(ticID);
clear('ticID');
disp('> The raw photons history A is ready.');
%% Analysis of the level 1 (row) data (see 'help mc_tools1' for more)
mc_tools1(A, 1);
%% Step 2: Convert A into a 'photons history' into a pixelated detector
disp('> Step 2...');
ticID = tic; Apix = mc_pixelize(A); toc(ticID);
clear('ticID');
disp('> The pixelated photons history Apix is ready.');
%% Analysis of the level 2 (pixelated detector) data (see 'help mc_tools2' for more)
mc_tools2(Apix, 2);
%% Analysis of the level 2 (pixelated detector) data (see 'help mc_polarization' for more)
load 'double_map.mat'
[alpha, q]= mc_polarization(double_map);
plot(alpha, q,'r*')
xlabel('alpha (degree)','FontSize',18);
ylabel('Q','FontSize',18);
grid;
```
