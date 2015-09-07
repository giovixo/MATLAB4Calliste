function [ info ] = mc_polarization( double_map )
%MC_POL Evaluate the polarization at many angles
%
%   The angles values are inside the PAR.POLARIZATION_ANGLES array

% 7 x 7 double events map. We consider events up to the order 3
double_map_small = double_map(98:104,98:104);  

% Display the map
colormap hot;
imagesc(log(double_map_small));
colorbar;

% Define the pixel edges 
edges={linspace(-3.5,3.5,8),linspace(-3.5,3.5,8)};

% Define "the polarization line"
x = linspace(-3.5,3.5,500)';
y = 0.4142 * x; % 22.5 degree
% Histogram the points of the line and then get the pixels with the line 
% inside
h = hist3([x, y], 'Edges', edges);
matrix = h(1:end-1,1:end-1);
pixels = matrix > 10;
% Evaluate the count belong the line
scol = sum(double_map_small(pixels));

% Define line orthogonal to "the polarization line"
x = linspace(-3.5,3.5,500)'; 
y = -2.4143 * x;
% Histogram the points of the line and then get the pixels with the line 
% inside
h = hist3([x, y], 'Edges', edges);
matrix = h(1:end-1,1:end-1);
pixels = matrix > 10;
% Evaluate the count belong the line
srow = sum(double_map_small(pixels));

% Estimate the polarization factor
Q = (srow - scol ) / (srow + scol);
disp(['Q = ',num2str(Q)]);

info = 'Processing done.';
end

