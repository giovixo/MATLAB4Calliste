% Main Script for data processing
% Version 0.1

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
ticID = tic; Apix = mc_pixelize(Ared); toc(ticID);
clear('ticID');
disp('> The pixelated photons history Apix is ready.');
%% Analysis of the level 2 (pixelated detector) data (see 'help mc_tools2' for more)
mc_tools2(Apix, 2);
mc_tools2(Apix, 3);
%% Analysis of the level 2 (pixelated detector) data (see 'help mc_polarization' for more)
load 'double_map.mat'
newMap = mc_map_filter(double_map, 1, 5);
[alpha, q]= mc_polarization(newMap, 3);
%dlmwrite('Q2alpha_z_free_e190-337_filter2-5_theta_10.0.txt', [alpha', q'],',');
plot(alpha, q, 'r*')
axis([0 400 -0.8 0.8]);
xlabel('alpha (degree)','FontSize',18);
ylabel('Q','FontSize',18);
grid;