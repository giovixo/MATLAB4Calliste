function [ Apix ] = mc_pixelize2( A )
%MC_PIXELIZE2 - Pixelize the detector
%Version: 0.1
%
%   This function takes as argument the array A which contain the photon
%   history in the raw CdTe volume and return Apix, the photon history in 
%   the pixelated detector.
%
%   Apix = MC_PIXELIZE2(A)
%   Input: A is the row 'photons history', i.e. the energy deposits list for
%   each photon.
%   Output: Apix is the pixelated 'photons history' array.
    
    % The detector size (mm)
    X_DET = 200.;
    Y_DET = 200.;
    Z_DET = 20.;
    % The voxel size (mm)
    X_VOXEL = 2.;
    Y_VOXEL = 2.;
    Z_VOXEL = 2.;
    
    eventsWithInteraction    = 0;
    eventsWithoutInteraction = 0;
    
    % The number of input photons
    sizeOfA = length( A ); 
    % The data matrix containing the pixelated array
    Apix = zeros(20, 5, sizeOfA);
    % voxel is the matrix containg the energy in each detector voxel 
    h = waitbar(0,'Please wait...');
    for i = 1:sizeOfA  % Loop over the photons
        if mod(i,fix(sizeOfA/50)) == 0 
            waitbar(i / sizeOfA);
        end
        % Check if the event "i" is empty (without interaction)
        noInt = ( sum ( A(:, 1 , i) ~= 0 ) ) - 1;
        isEmpty = (noInt == 0);
        % If the event is NOT then empty pixelize and store the event in Apix
        if ~isEmpty
            eventsWithInteraction = eventsWithInteraction + 1;
            % Evaluate the voxel x, y, z (the value of the voxel(i,j,k) is its energy 
            % Example: voxel = zeros(100, 100, 10);
            voxel = zeros( fix(X_DET / X_VOXEL), fix(Y_DET / Y_VOXEL), fix(Z_DET / Z_VOXEL) );
            for j = 1:noInt
                ivox = fix( ( A(j, 3:5, i) + [X_DET / 2. - 1.e-9, Y_DET / 2. - 1.e-9, Z_DET / 2. - 1.e-9] ) / 2 ) + 1;
                % Increment the energy inside the given voxel
                voxel(ivox(1), ivox(2), ivox(3)) = voxel(ivox(1), ivox(2), ivox(3)) + A(j, 2, i);
            end
            % Find the Voxels with positive energy
            [I, J, K] = ind2sub(size(voxel), find(voxel) );       
            % Store in Apix the events (TBT)
            noDetections = length(I);
            Apix(1:noDetections,1,i) = A(1,1,i);  % Index of the the photon
            for iEvent=1:noDetections             
                Apix(iEvent,2,i) = voxel(I(iEvent), J(iEvent), K(iEvent));  % Energy (MeV)
            end
            Apix(1:noDetections,3,i) = I; 
            Apix(1:noDetections,4,i) = J; 
            Apix(1:noDetections,5,i) = K; 
        else
            eventsWithoutInteraction = eventsWithoutInteraction + 1;
            noDetections = 0;
        end
        % Store in Apix the "input energy event" (without any pixelation)
        Apix(noDetections+1, :, i) = A(noInt+1, :, i);
    end % end of the loop
    close(h);
    disp(['No. events with interaction: ' num2str( eventsWithInteraction ) ]);
    disp(['No. events without interaction: ' num2str( eventsWithoutInteraction )]);
end

