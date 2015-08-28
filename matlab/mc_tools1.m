function [ log_text ] = mc_tools1(A, n)
%MC_TOOLS1 Level 1 data analysis 
%Version: 0.1
%
%   This functions takes as input the photon list array A (run mc_read.m first)
%   and process the data providing some outputs.
%
%   log_text = MC_TOOLS1(A, n)
%   Input:
%   A is array in workspace that contains the row photons history
%   n is an integer to set the output you wish
%   n = 1 -> Input spectrum
%   n = 2 -> Detected spectrum

    switch n
        case 1
            % Read the input energy
            size = PAR.EVENTS_NUMBER; 
            e_inp = zeros(size,1);
            for i = 1:size
                e_inp(i) = -1000. * A(A(:,2,i) < 0, 2, i);
            end
            % and plot the spectrum
            [spec, xout]=hist(e_inp,10);
            loglog(xout, spec);
            grid on;
            title('Input spectrum');
            xlabel('Energy (keV)','fontsize',14);
            ylabel('Photons','fontsize',14);
            log_text = '> The input spectrum is ready.';
        case 2
            % Read the detected energy
            size = PAR.EVENTS_NUMBER; 
            e_det = zeros(size,1);
            for i = 1:size
                e_det(i) = 1000. * sum( A(A(:,2,i) > 0,2,i) );
            end
            % and plot the spectrum
            [spec, xout]=hist(e_det,100);
            loglog(xout, spec,'r');
            grid on;
            title('Detected spectrum');
            xlabel('Energy (keV)','fontsize',14);
            ylabel('Photons','fontsize',14);
            log_text = '> The detected spectrum is ready.';
        otherwise
            log_text = '> Error: the index is not valid. Try <help mc_tools1> for help';
    end
    
end

