% Main Script for data processing
% Version 0.1
%% Step 1: read the file and return the data array
disp('> Step 1...');
A = mc_read('PolCrabCusp_short.dat');
disp('> The row photons history A is ready')
%% Step 2: Convert A into a 'photons history' into a pixelated detector
disp('> Step 2...');
Apix = mc_pixelize(A);
disp('> The pixelated photons history Apix is ready');