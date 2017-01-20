# MATLAB for Cusp #

### Contributors ###

* G. De Cesare - decesare.giovanni  at gmail.com

### Infos ###

* Code for the analysis of the Cusp Monte Carlo data
* Dependences: MATLAB

### Directories ###

* matlab: MATLAB source code
* dataset: it contains a short sample data file

### How to run ###

* Open the MATLAB gui on your pc
* To set som file path, edit PAR.m file
* Also edit mc.m file, if required
* Run mc.m

The code is based on two steps data analysis.

In step 1 the data file is read and the energy deposits list for each input photons is evaluated. We call these data "raw photon history"
or LEVEL 1 DATA for short (stored into the A array).

In step 2 the energy deposits are sampled in a pixelated detector. We call these data "pixelated photon history" ore LEVEL 2 DATA for
short (stored into Apix array).

The parameters of the run are stored into the PAR.m class.

### Example ###

```
%% Step 1: read the file and return the data array
disp('> Step 1...');
ticID = tic; [A, len] = mc_read('01PolCrabCusp.dat', [190., 337.]); toc(ticID);
clear('ticID');
Ared = A(:,:,1:len);
clear('A');
disp('> The raw photons history Ared is ready.');
%% Analysis of the level 1 data (see 'help mc_tools1' for more)
mc_tools1(Ared, 1);
hold on;
mc_tools1(Ared, 2);
hold off;
%% Step 2: Convert A into a 'photons history' into a pixelated detector
disp('> Step 2...');
ticID = tic; Apix = mc_pixelize2(Ared); toc(ticID);
clear('ticID');
disp('> The pixelated photons history Apix is ready.');
%% Analysis of the level 2 (pixelated detector) data (see 'help mc_tools2' for more)
mc_tools2(Apix, 2);
mc_tools2(Apix, 3);
%% Analysis of the level 2 (pixelated detector) data (see 'help mc_polarization' for more)
load 'double_map.mat'
newMap = mc_map_filter(double_map, 2, 5);
[alpha, q]= mc_polarization(newMap, 3);
plot(alpha, q, 'r*')
axis([0 400 -0.8 0.8]);
xlabel('alpha (degree)','FontSize',18);
ylabel('Q','FontSize',18);
grid;

```
