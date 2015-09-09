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
%   n is an integer used to set the output you wish
%   n = 1 -> Plot the input spectrum
%   n = 2 -> Plot the detected spectrum

    size = PAR.EVENTS_NUMBER;
 
    % Read the input energy
    e_inp = zeros(size,1);
    for i = 1:size
        e_inp(i) = -1000. * A(A(:,2,i) < 0, 2, i);
    end
    [spec, xout]=hist(e_inp,100);
    
    % Read the detected energy 
    e_det = zeros(size,1);
    for i = 1:size
        e_det(i) = 1000. * sum( A(A(:,2,i) > 0,2,i) );
    end
    
    switch n
        case 1
            loglog(xout, spec,'b');
            grid on;
            xlabel('Energy (keV)','fontsize',14);
            ylabel('Photons','fontsize',14);
            log_text = '> The input spectrum (blue line) is ready.';
        case 2
            spec=histc(e_det,xout);
            loglog(xout, spec,'r');
            grid on;
            xlabel('Energy (keV)','fontsize',14);
            ylabel('Photons','fontsize',14);
            log_text = '> The detected spectrum (red line) is ready.';
        otherwise
            log_text = '> Error: wrong index. Try <help mc_tools1> for help';
    end
    
end

