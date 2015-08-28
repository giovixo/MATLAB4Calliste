function [ log_text ] = mc_tools2(Apix, n)
%MC_TOOLS2 Level2 data analysis
%Version 0.1
%
%   This functions takes as input the photon list Apix (run mc_pixelize.m first) 
%   in the pixelated detector and process the data providing some outputs.
%
%   log_text = MC_TOOLS2(Apix, n)
%   Apix is array in workspace that contains the photons history in the
%   pixelated detector.
%   n is an integer used to set the output you wish
%   n is an integer used to set the output you wish
%   n = 1 -> Print some statistics on the events
%   More options are coming ...

    switch n
        case 1
            % Evaluate some statistics
            size = PAR.EVENTS_NUMBER;
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
            disp(['Threshold (keV): ' num2str( 1000*threshold )]);
            disp(['Total events: ' num2str( n_event )]);
            disp(['No detection: ' num2str( null_event )]);
            disp(['Single events: ' num2str( single )]);
            disp(['Double events: ' num2str( double )]);
            disp(['Multiple (>2) events: ' num2str( others )]);
            log_text = '>Processing 1 done.';
        otherwise
            log_text = '>Error: wrong index. Try <help mc_tools2> for help';        
    end

end

