classdef PAR
    %PAR Some constant used for the data analysis 
    %   Define some parameters, that can be used into the MATLAB functions 
    properties( Constant )
        LOG = 0; % Log level (0: default, 1: verbose)
        DATA_PATH = '/Users/giovannidecesare/Works/Cusp/MATLAB4Cusp/dataset/set02/';
        % The detector size (mm)
        X_DET = 200.;
        Y_DET = 200.;
        Z_DET = 20.;
        % The voxel size (mm)
        X_VOXEL = 2.;
        Y_VOXEL = 2.;
        Z_VOXEL = 2.;
        SAME_Z = true; % true if the double events have the same z
        EVENTS_NUMBER = 500000; % The number of photons 
        HISTORY_LENGTH = 20; % The recorded history for the pixelated detector
        POLARIZATION_ANGLES = [5:10:85 95:10:175 185:10:265 275:10:355];
        POLARIZATION_ANGLES_MIN = [5:10:85 95:10:175 185:10:265 275:10:355]; % Used by 'mc_polarization(,3)'
        POLARIZATION_ANGLES_MAX = [5:10:85 95:10:175 185:10:265 275:10:355] + 0.2;
        FILTER = true; % Filter 2-5 on the "linear" Q estimation
    end
end

