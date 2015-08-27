% Main Script for data processing
% Version 0.1
%% Step 1: read the file and return the data array
disp('> Step 1...');
ticID = tic; A = mc_read('PolCrabCusp_short.dat'); toc(ticID);
disp('> The row photons history A is ready')
%% Step 1 analysis example (see 'help mc_tools' for more)
log_text1 = mc_tools1(A, 2);
%% Step 2: Convert A into a 'photons history' into a pixelated detector
disp('> Step 2...');
ticID = tic; Apix = mc_pixelize(A); toc(ticID);
disp('> The pixelated photons history Apix is ready');