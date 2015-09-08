function [ info ] = mc_polarization( double_map )
%MC_POLARIZATION Evaluate the polarization at many angles
%
%   MC_POLARIZATION(double_map)
%   
%   The angles values are defined in the PAR.POLARIZATION_ANGLES array

% 7 x 7 double events map. We consider events up to the order 3
double_map_small = double_map(98:104,98:104);  

% Display the map
%colormap hot;
%imagesc(log(double_map_small));
%colorbar;

% Define the pixel edges 
edges={linspace(-3.5,3.5,8),linspace(-3.5,3.5,8)};

% Define "the polarization line"
x = linspace(-3.5,3.5,700)';
y = -2.4143 * x; % 22.5 degree
%y = -x; % 45 degree
% Histogram the points of the line and then get the pixels with the line 
% inside
h = hist3([x, y], 'Edges', edges);
matrix1 = h(1:end-1,1:end-1);
pixels = matrix1 > 10;
% Evaluate the count belong the line
scol = sum(double_map_small(pixels));

% Define line orthogonal to "the polarization line"
x = linspace(-3.5,3.5,700)'; 
y = 0.4142 * x;
%y = x;
% Histogram the points of the line and then get the pixels with the line 
% inside
h = hist3([x, y], 'Edges', edges);
matrix2 = h(1:end-1,1:end-1);
pixels = matrix2 > 10;
% Evaluate the count belong the line
srow = sum(double_map_small(pixels));

% Display the matrix
colormap hot;
%matrix = 2*matrix1 + matrix2;
imagesc(matrix1);
colorbar;
axis square;

% Estimate the polarization factor
Q = (srow - scol ) / (srow + scol);
disp(['Q = ',num2str(Q)]);

info = 'Processing done.';
end

