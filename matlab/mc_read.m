function [ data ] = mc_read( fileName )
%MC_READ - Read the Monte Carlo data file
%Version:  0.1
%
%   This function read a .dat file and return an array wich contains the 
%   photon history (ie. the energy deposit for each photon).    
%
%   A = MC_READ(file_name)
%   Input: the file name
%   A: data array filled with data contained in file_name

    % Constants
    LOG = false;
    PATH = '/Users/giovannidecesare/Works/Cusp/MATLAB4Cusp/dataset/set01/';
    MAX_EVENTS = 500; 
    HISTORY_LEN = 51;
    
    % Display a log message
    if LOG 
        disp('Reading the data file...'); 
    end

    % Open the Monte Carlo data file
    [fileID, errMsg] = fopen([PATH fileName],'r');
    if ~strcmp(errMsg,'')
        disp([ errMsg ': ' fileName]);
        data = 0;
        return;
    end
    
    % Skip the header
    h1 = fgetl(fileID);
    h2 = fgetl(fileID);
    h3 = fgetl(fileID);
    h4 = fgetl(fileID);
    if LOG
        disp(h1);
        disp(h2);
        disp(h3);
        disp(h4);
    end
    % Read the raw data into 'A'
    formatSpec = '%d %f %f %f %f';
    if LOG
        ticID = tic; A = fscanf(fileID, formatSpec, [5 inf]); toc(ticID);
    else
        A = fscanf(fileID, formatSpec, [5 inf]);
    end
        
    A = A';
    % Prepare fixed format data(i, j, k) to store the event
    % -----------------------------------------------------
    % i: maximum length of the interaction buffer
    % j: number of column of each record
    % k: maximum number of events 
    data = zeros(HISTORY_LEN, 5, MAX_EVENTS);
    % Process and write
    % -------------------
    % i: index of the row
    % ievent: index of the event
    % k: number of interactions per event
    i = 1;
    ievent = 0;
    while ievent <  500
        % Update the index of the event
        ievent = ievent + 1;
        % Set to zero the number of interactions k
        k = 0;
        % Assign the first record of the event
        data(k+1,:, ievent) = A(i,:);
        % If the record is not empty go throw the interactions
        while A(i+k,2) >= -0.001  % && A(i+k,5) > -20       
            k = k + 1;
            % Assign the record to the current event
            data(k+1,:, ievent) = A(i+k,:);
        end
        i = i + 1 + k;   
    end
    
    % Close the data file
    if fileID
        fclose(fileID);
    end

end

