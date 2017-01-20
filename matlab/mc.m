% Main Script for data processing
% Version 0.1

%% Step 1: read the file and return the data array
disp('> Step 1...');
%fileName = '01PolCrabCusp.dat';
%%fileName = '300keVCalistePolarizationAngle00.dat';
%fileName = '300keVCalistePolarizationAngle01.dat';
%fileName = '300keVCalistePolarizationAngle05.dat';
%fileName = '200keVCalistePolarizationAngle30.dat';
%fileName ='TestCaliste200keV.dat';
fileName = '300keVCalistePol00deg1M.dat';
%ticID = tic; [A, len] = mc_read(fileName, [190., 337.]); toc(ticID);
ticID = tic; [A, len] = mc_read(fileName, [10., 400.]); toc(ticID);
clear('ticID');
Ared = A(:,:,1:len);
clear('A');
disp('> The raw photons history Ared is ready.');
%% Analysis of the level 1 data (see 'help mc_tools1' for more)
figure;
mc_tools1(Ared, 1);
hold on;
mc_tools1(Ared, 2);
hold off;
%% Step 2: Convert A into a pixelated detector
disp('> Step 2...');
ticID = tic; Apix = mc_pixelize2(Ared); toc(ticID);
clear('ticID');
disp('> The pixelated photons history Apix is ready.');
%% Step 2b: apply energy resolution and threshold 
 Apix = mc_hit(Apix, PAR.THRESHOLD);
%% Analysis of the level 2 (pixelated detector) data (see 'help mc_tools2' for more)
figure;
mc_tools2(Apix, 2); % Evaluate the scattering map for double events
mc_tools2(Apix, 3); % Estimate the polarization factor Q
%% Analysis of the level 2 (pixelated detector) data (see 'help mc_polarization' for more)
figure;
load 'double_map.mat'
newMap = mc_map_filter(double_map, 2, 5);
%newMap = mc_map_filter(double_map, 3, 7);
% NO filter
%newMap = double_map;
[alpha, q]= mc_polarization(newMap, 3);
%[alpha, q]= mc_polarization(double_map, 3);
%dlmwrite('Q2alpha_e190-337_z_const_nofilter.txt', [alpha', q'],' ');
%dlmwrite('double_map_z_xxx_190-337.txt', double_map(80:120,80:120),',');
%dlmwrite('polarizationProfileEnergy300kevPolarizationAngle00.dat', [alpha', q'],' ');
plot(alpha, q, 'r*')
axis([0 400 -1. 1.]);
xlabel('alpha (degree)','FontSize',18);
ylabel('Q','FontSize',18);
grid;