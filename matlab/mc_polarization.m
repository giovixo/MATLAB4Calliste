function [angle, Q_arr] = mc_polarization( double_map, n )
%MC_POLARIZATION Evaluate the polarization at many angles
%
%   [alpha, q] = MC_POLARIZATION(double_map)
%   [alpha, q] = MC_POLARIZATION(double_map, n)
%   
%   The angles are defined in the PAR.POLARIZATION_ANGLES array

    if (~exist('n', 'var'))
        n = 1;
    end

    angle = abs(PAR.POLARIZATION_ANGLES);
    Q_arr = [];

    % 7 x 7 double events map. We consider events up to the order 3
    double_map_small = double_map(98:104,98:104);

    % Define the pixel edges
    edges={linspace(-3.5,3.5,8),linspace(-3.5,3.5,8)};

    switch n
        case 1
            disp('Evaluating Q with method 1 ...');
            % Loop over different angles
            for theta = PAR.POLARIZATION_ANGLES
                atheta = abs(theta);
                % Define "the polarization line"
                % The angular coefficient is ...
                m = tan( atheta*(pi/180.) );
                if PAR.LOG == 1
                    disp(['Theta = ',num2str(atheta)]);
                    disp(['m = ',num2str(m)]);
                end
                x = linspace(-3.5,3.5,700)';
                y = (-1. / m) * x;  %-2.4143 * x; % 22.5 degree
                % Histogram the points of the line and then get the pixels with the line
                % inside
                h = hist3([x, y], 'Edges', edges);
                matrix1 = h(1:end-1,1:end-1);
                pixels = matrix1 > 1;
                % Evaluate the count belong the line
                scol = sum(double_map_small(pixels));

                % Define line orthogonal to "the polarization line"
                x = linspace(-3.5,3.5,700)';
                y = m * x; %0.4142 * x;
                % Histogram the points of the line and then get the pixels with the line
                % inside
                h = hist3([x, y], 'Edges', edges);
                matrix2 = h(1:end-1,1:end-1);
                pixels = matrix2 > 1;
                % Evaluate the count belong the line
                srow = sum(double_map_small(pixels));
                % Display the matrix (if theta < 0)
                if theta < 0
                    colormap hot;
                    imagesc(matrix1);
                    colorbar;
                    axis square;
                end
                % Estimate the polarization factor
                Q = (srow - scol ) / (srow + scol);
                Q_arr = [Q_arr Q];
                if PAR.LOG == 1
                    disp(['Q = ',num2str(Q)]);
                end
            end
            disp('done.');
        case 2
            disp('Evaluating Q with method 2 ...');
            % Loop over different angles
            for theta = PAR.POLARIZATION_ANGLES
                atheta = abs(theta);
                % Define "the polarization line"
                % The angular coefficient is ...
                m = tan( atheta*(pi/180.) );
                if PAR.LOG == 1
                    disp(['Theta = ',num2str(atheta)]);
                    disp(['m = ',num2str(m)]);
                end
                x = linspace(-3.5,3.5,700)';
                y = (-1. / m) * x;  %-2.4143 * x; % 22.5 degree
                deltaM = 0.06;
                y1 = ( (-1. / m) - deltaM) * x;
                y2 = ( (-1. / m) + deltaM) * x;
                y3 = ( (-1. / m) - 0.5 * deltaM) * x;
                y4 = ( (-1. / m) + 0.5 * deltaM) * x;
                x = [x' x' x' x' x']';
                y = [y' y1' y2' y3' y4']';
                % Histogram the points of the line and then get the pixels with the line
                % inside
                h = hist3([x, y], 'Edges', edges);
                matrix1 = h(1:end-1,1:end-1);
                pixels = matrix1 > 1;
                % Evaluate the count belong the line
                scol = sum(double_map_small(pixels));

                % Define line orthogonal to "the polarization line"
                x = linspace(-3.5,3.5,700)';
                y = m * x; %0.4142 * x;
                y1 = ( m - deltaM ) * x;
                y2 = ( m + deltaM) * x;
                y3 = ( m - 0.5 * deltaM) * x;
                y4 = ( m + 0.5 * deltaM) * x;
                x = [x' x' x' x' x']';
                y = [y' y1' y2' y3' y4']';
                % Histogram the points of the line and then get the pixels with the line
                % inside
                h = hist3([x, y], 'Edges', edges);
                matrix2 = h(1:end-1,1:end-1);
                pixels = matrix2 > 1;
                % Evaluate the count belong the line
                srow = sum(double_map_small(pixels));
                % Display the matrix (if theta < 0)
                if theta < 0
                    colormap hot;
                    imagesc(matrix1);
                    colorbar;
                    axis square;
                end
                % Estimate the polarization factor
                Q = (srow - scol ) / (srow + scol);
                Q_arr = [Q_arr Q];
                if PAR.LOG == 1
                    disp(['Q = ',num2str(Q)]);
                end
            end
            disp('done.');            
    end
end

