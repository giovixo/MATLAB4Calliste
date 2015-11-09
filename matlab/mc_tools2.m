function mc_tools2(Apix, n)
%MC_TOOLS2 Level2 data analysis
%Version 0.1
%
%   This functions takes as input the photon list Apix (run mc_pixelize.m first) 
%   in the pixelated detector and process the data providing some outputs.
%
%   MC_TOOLS2(Apix, n)
%   Apix is array in workspace that contains the photons history in the
%   pixelated detector.
%   n is an integer used to set the output you wish
%   n is an integer used to set the output you wish
%   n = 1 -> Print some statistics on the events
%   n = 2 -> Evaluate the scattering map for double events
%   n = 3 -> Estimate the polarization factor Q

    switch n
        case 1
            % Evaluate some statistics
            disp('n = 1, evaluating some statistics...');
            size = length(Apix); % PAR.EVENTS_NUMBER;
            n_event = 0;
            null_event = 0;
            single = 0;
            double = 0;
            others = 0;
            threshold = 0.005; 
            for i = 1:size
                n_event = n_event + sum(Apix(:,2,i) < 0); 
                multiplicity = sum(Apix(:,2,i) > threshold);
                switch multiplicity
                    case 0
                        null_event = null_event + 1;
                    case 1
                        single = single + 1;
                    case 2
                        double = double + 1;
                    otherwise
                        others = others + 1;
                end
            end
            disp('Events statistics');
            disp('=================');
            disp(['Threshold (keV): ' num2str( 1000*threshold )]);
            disp(['Total events: ' num2str( n_event )]);
            disp(['Without detection: ' num2str( null_event )]);
            disp(['Single events: ' num2str( single )]);
            disp(['Double events: ' num2str( double )]);
            disp(['Multiple (>2) events: ' num2str( others )]);
        case 2
            % Scattering plot for double events
            disp('n = 2, scatter plot for double events...');
            size = length(Apix); %PAR.EVENTS_NUMBER;
            n_event = 0;
            null_event = 0;
            single = 0;
            double = 0; 
            double_z_const = 0; % Double events with the same z
            others = 0;
            threshold = 0.005;
            % It will contain the scattering map for double events
            double_map = zeros(201);
            double_energy = zeros(size,1);
            double_energy_free = zeros(size,1);
            energy = zeros(size,1); % input energy
            for i = 1:size
                n_event = n_event + sum(Apix(:,2,i) < 0); 
                multiplicity = sum(Apix(:,2,i) > threshold);
                energy(i) = -1000.*Apix(Apix(:,2,i)<0, 2, i);
                %   multiplicity = find(Apix(:,2,i)<0) - 1;
                switch multiplicity
                    case 0
                        null_event = null_event + 1;
                    case 1
                        single = single + 1;
                    case 2
                        double = double + 1;
                        if fix(Apix(1,5,i)) == fix(Apix(2,5,i))
                            first  = randi(2);  % 1 or 2 
                            second = 3 - first; % 2 or 1 
                            ix = Apix(first,3,i) - Apix(second,3,i);
                            iy = Apix(first,4,i) - Apix(second,4,i);
                            double_energy(i) = 1000. * ( double_energy(i) + Apix(first,2,i) + Apix(second,2,i) );
                            if double_energy(i) > 60
                                double_z_const = double_z_const + 1;
                                if PAR.SAME_Z
                                    double_map(ix + 101, iy + 101) = double_map(ix + 101, iy + 101) + 1;
                                end
                            end
                        end
                        double_energy_free(i) = 1000. * ( double_energy_free(i) + Apix(1,2,i) + Apix(2,2,i) );
                        if ~PAR.SAME_Z
                            first  = randi(2);  % 1 or 2
                            second = 3 - first; % 2 or 1
                            ix = Apix(first,3,i) - Apix(second,3,i);
                            iy = Apix(first,4,i) - Apix(second,4,i);
                            double_map(ix + 101, iy + 101) = double_map(ix + 101, iy + 101) + 1;
                        end
                    otherwise
                        others = others + 1;
                end
            end
            disp('Events statistics');
            disp('=================');
            disp(['Threshold (keV): ' num2str( 1000*threshold )]);
            disp(['Total events: ' num2str( n_event )]);
            disp(['Without detection: ' num2str( null_event )]);
            disp(['Single events: ' num2str( single )]);
            disp(['Double events: ' num2str( double )]);
            disp(['Double events with the same z: ' num2str( double_z_const )]);
            disp(['Multiple (>2) events: ' num2str( others )]);
            % Anve and display the double map image
            save('double_map.mat','double_map')
            colormap hot;
            imagesc(log(double_map(80:120,80:120)));
            colorbar;
            disp('>The scatter plot for double events is ready.');
        case 3
            % Estimate Q
            disp('Estimating the polarization factor...');
            load('double_map.mat','double_map')
            iCenter = 101;
            jCenter = 101;
            row = double_map(iCenter,:);  %#ok<NODEF>
            col = double_map(:,jCenter);
            % Filter
            disp(['Xcenter: ' num2str( row(jCenter) ) ] );
            disp(['Ycenter: ' num2str( col(jCenter) ) ]);
            if PAR.FILTER
                disp('Filter 2-5 ON');
                row( jCenter - 1 ) = 0; row( jCenter + 1 ) = 0;
                col( jCenter - 1 ) = 0; col( jCenter + 1 ) = 0;
                row(1: jCenter - 6) = 0; row(jCenter + 6:end) = 0;
                col(1: jCenter - 6) = 0; col(jCenter + 6:end) = 0;
            end
            srow=sum(row);
            scol=sum(col);
            Q = (srow - scol ) / (srow + scol);
            colormap hot;
            imagesc(log(double_map(80:120,80:120)));
            colorbar;
            disp(['Q = ',num2str(Q)])
        otherwise
            disp('>Error: wrong index. Try <help mc_tools2> for help.');        
    end

end

