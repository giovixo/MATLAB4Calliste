classdef PAR
    %PAR Some constant used for the data analysis 
    %   Define some parameters, tha can be used into the MATLAB fiunctions 
    
    properties( Constant )
        LOG = 0; % Log level (0: default, 1: verbose)
        DATA_PATH = '/Users/giovannidecesare/Works/Cusp/MATLAB4Cusp/dataset/set02/';
        EVENTS_NUMBER = 500000; % The number of photons 
        HISTORY_LENGTH = 20; % The recorded history for the pixelated detector
        POLARIZATION_ANGLES = [5:10:85 95:10:175 185:10:265 275:10:355];
        POLARIZATION_ANGLES_MIN = [5:10:85 95:10:175 185:10:265 275:10:355]; % Used by 'mc_polarization(,3)'
        POLARIZATION_ANGLES_MAX = [5:10:85 95:10:175 185:10:265 275:10:355] + 0.8;
    end
    
end

