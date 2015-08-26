function [ data ] = mc_read( fileName )
%MC_READ Read the Monte Carlo data file
%Version:  0.1
%   Usage:
%   mc_read(file_name)
%   Input: file_mame (ascii) The file name
%   Output: A data array filled with data contained in file_name

    % Constants
    PATH = '/Users/giovannidecesare/Works/Cusp/mc-simulation/matlab-for-cusp-detector-mc/dataset/set01/';
    MAX_EVENTS = 500; % for testing
    HISTORY_LEN = 51;
    
    % Display the log message
    disp('Reading the data file ...') 

    % Open the Monte Carlo data file
    [fileID, errMsg] = fopen([PATH fileName],'r');
    if ~strcmp(errMsg,'')
        disp([ errMsg ': ' fileName]);
        data = 0;
        return;
    end
    
    % Skip the header
    disp( fgetl(fileID) );
    disp( fgetl(fileID) );
    disp( fgetl(fileID) );
    disp( fgetl(fileID) );
    % Read the raw data into 'A'
    formatSpec = '%d %f %f %f %f';
    ticID = tic; A = fscanf(fileID, formatSpec, [5 inf]); toc(ticID);
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
        % Event (B) processing here ...
        %disp (['Event number: ' num2str(ievent) '   Number of interactions: ' num2str(k)]); % Debug 
        %disp(B(1:k+1,:, ievent));                                                           % Debug         
        % Update the index of the row. By +1 if there are not interactions.
        i = i + 1 + k;   
    end
    
    % Close the data file
    if fileID
        fclose(fileID);
    end

end

