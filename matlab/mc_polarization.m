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

    Q_arr = [];

    % 21 x 21 double evevents map 
    % max distance = 10
    double_map_small = double_map(91:111, 91:111);

    % Define the pixel edges
    edges={linspace(-10.5, 10.5, 22), linspace(-10.5, 10.5, 22)};
    
    switch n
        case 1
            disp('Evaluating Q with method 1 ...');
            angle = abs(PAR.POLARIZATION_ANGLES);
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
                x = linspace(-10.5,10.5,700)';
                y = (-1. / m) * x;  
                % Histogram the points of the line and then get the pixels with the line
                % inside
                h = hist3([x, y], 'Edges', edges);
                matrix1 = h(1:end-1,1:end-1);
                pixels = matrix1 > 1;
                % Evaluate the count belong the line
                scol = sum(double_map_small(pixels));

                % Define line orthogonal to "the polarization line"
                x = linspace(-10.5,10.5,700)';
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
            angle = abs(PAR.POLARIZATION_ANGLES);
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
                x = linspace(-10.5,10.5,700)';
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
                x = linspace(-10.5,10.5,700)';
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
        case 3
            disp('Evaluating Q with method 3 ...');
            angle = 0.5 * ( abs(PAR.POLARIZATION_ANGLES_MIN) +  abs( PAR.POLARIZATION_ANGLES_MAX ) );
            % Loop over different angles
            index = 1;
            for theta = PAR.POLARIZATION_ANGLES_MIN
                atheta = abs(theta);
                mMin = tan( atheta*(pi/180.) );
                if PAR.LOG == 1
                    disp(['Theta min = ',num2str(atheta)]);
                    disp(['m min = ',num2str(mMin)]);
                end
                atheta = abs(PAR.POLARIZATION_ANGLES_MAX(index));
                index = index + 1;
                mMax = tan( atheta*(pi/180.) );
                if PAR.LOG == 1
                    disp(['Theta Max = ',num2str(atheta)]);
                    disp(['m Max = ',num2str(mMax)]);
                end
                % Create a random set of points (x,y) in a thin slice
                % between y1 and y2
                x  = -10.5 + 21. * rand(100000, 1);
                y  = -10.5 + 21. * rand(100000, 1);
                y1 = ( -1. / mMin ) * x;
                y2 = ( -1. / mMax ) * x;
                x = x(y < max(y1, y2) & y > min(y1, y2));
                y = y(y < max(y1, y2) & y > min(y1, y2));
                % The border
                xLin    = linspace(-10.5,10.5,700)';
                yLinMin = (-1. / mMin) * xLin;
                yLinMax = (-1. / mMax) * xLin;
                x = [x' xLin' xLin']';
                y = [y' yLinMin' yLinMax']';
                if 0
                    hold on; axis square;
                    plot(x, y, '.'); 
                    axis([-10.5 10.5 -10.5 10.5]);
                    pause;
                end
                hold off; axis normal;
                % Histogram the points of the line and then get the pixels with the line
                % inside
                h = hist3([x, y], 'Edges', edges);
                matrix1 = h(1:end-1,1:end-1);
                pixels = matrix1 > 1;
                % Evaluate the count belong the line
                scol = sum(double_map_small(pixels));
                % Define line orthogonal to "the polarization line" and
                % create a random set of points (x,y) in a thin slice
                % between yMin and Ymax
                x = -10.5 + 21. * rand(100000, 1);
                y = -10.5 + 21. * rand(100000, 1);
                y1 = mMin * x;
                y2 = mMax * x;
                x = x(y < max(y1, y2) & y > min(y1, y2));
                y = y(y < max(y1, y2) & y > min(y1, y2));
                xLin    = linspace(-10.5,10.5,700)';
                yLinMin = mMin * xLin;
                yLinMax = mMax * xLin;
                x = [x' xLin' xLin']';
                y = [y' yLinMin' yLinMax']';
                if 0
                    hold on; axis square;
                    plot(x, y, '.'); 
                    axis([-10.5 10.5 -10.5 10.5]);
                    pause;
                end
                hold off; axis normal;
                % Histogram the points of the line and then get the pixels with the line
                % inside
                h = hist3([x, y], 'Edges', edges);
                matrix2 = h(1:end-1,1:end-1);
                pixels = matrix2 > 1;
                % Evaluate the count belong the line
                srow = sum(double_map_small(pixels));
                % Estimate the polarization factor
                Q = (srow - scol ) / (srow + scol);
                % Estimate the error
                err1 = sqrt( srow + scol ) / abs(srow - scol);
                err2 = sqrt( srow + scol ) / abs(srow + scol);
                Qerr = abs(Q) * ( err1 + err2 );
                %disp(['alpha (degree) = ', num2str(angle(index-1)), ' Q = ', num2str(Q), ' +- ', num2str(Qerr)]);
                disp([num2str(angle(index-1)), ' ', num2str(Q), ' ', num2str(Qerr)]);
                Q_arr = [Q_arr Q];
                if PAR.LOG == 1
                    disp(['Q = ',num2str(Q)]);
                end
            end
            disp('done.');
    end
end

