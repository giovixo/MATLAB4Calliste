% Main Script for data processing
% Version 0.1
%% Step 1: read the file and return the data array
disp('Start processing...');
A = mc_read('PolCrabCusp_short.dat');
%% Step 2: Convert A into a 'photons history' into a pixelated detector
Apix = mc_pixelize(A);