classdef PAR
    %PAR Some constant used for the data analysis 
    %   Define some parameters, tha can be used into the MATLAB fiunctions 
    
    properties( Constant )
        DATA_PATH = '/Users/giovannidecesare/Works/Cusp/MATLAB4Cusp/dataset/set02/';
        EVENTS_NUMBER = 500000; % The numeber of photons 
        HISTORY_LENGTH = 20; % The recorded history for the pixelated detector
        POLARIZATION_ANGLES = [0, 10, 20, 30, 40, 45, 50, 60, 70, 80 90];
    end
    
end

