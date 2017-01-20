classdef PAR
    %PAR Some constant used for the data analysis 
    %   Define some parameters, that can be used into the MATLAB functions 
    properties( Constant )
        LOG = 0; % Log level (0: default, 1: verbose)
        %DATA_PATH = '/Users/giovanni/Works/Cusp/MATLAB4Cusp/dataset/set02/';
        %%DATA_PATH = '/Users/giovanni/Works/Cusp/MATLAB4Cusp_calliste/dataset/calliste/';
        DATA_PATH = '/Users/giovanni/Works/Cusp/MATLAB4Cusp_calliste/dataset/calliste_20170104/';
        % The detector threshold (in MeV)
        THRESHOLD = 0.001;
        % => Calliste detector
        % The detector size (mm)
        X_DET = 10.;
        Y_DET = 10.;
        Z_DET = 2.;
        % The Voxel size
        X_VOXEL = 0.625;
        Y_VOXEL = 0.625;
        Z_VOXEL = 2.;
        
        SAME_Z = true; % true if the double events have the same z
        FILTER = true; % Filter 2-5 on the "linear" Q estimation
        EVENTS_NUMBER = 500000; % The number of photons 
        HISTORY_LENGTH = 20; % The recorded history for the pixelated detector
        POLARIZATION_ANGLES = [5:10:85 95:10:175 185:10:265 275:10:355];
        %POLARIZATION_ANGLES_MIN = [5:10:85 95:10:175 185:10:265 275:10:355]; % Used by 'mc_polarization(,3)'
        %POLARIZATION_ANGLES_MAX = [5:10:85 95:10:175 185:10:265 275:10:355] + 0.2;
        %%POLARIZATION_ANGLES_MIN = ([9:12:81 87:12:171 177:12:261 267:12:351]) - 1.; % Used by 'mc_polarization(,3)'
        %%POLARIZATION_ANGLES_MAX = ([9:12:81 87:12:171 177:12:261 267:12:351]) + 1.;
        %%%POLARIZATION_ANGLES_MIN = ([9:15:84 87:15:177 177:15:267 267:15:357]) - 7.5; % Used by 'mc_polarization(,3)'
        %%%POLARIZATION_ANGLES_MAX = ([9:15:84 87:15:177 177:15:267 267:15:357]) + 7.5;
        POLARIZATION_ANGLES_MIN = (0:15:345) - 7.5;
        POLARIZATION_ANGLES_MAX = (0:15:345) + 7.5;
    end
end
