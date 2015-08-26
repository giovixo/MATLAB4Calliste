function [ Apix ] = mc_pixelize( A )
%MC_PIXELIZE - Pixelize the detector
%
%   This function takes as argument the array A which contain the photon
%   history in the row CdTe volume and return Apix, the photon history in 
%   the pixelated detector.
%
% Apix = MC_PIXELIZE(A)
% Input: A is the row 'photons history', i.e. the energy deposits list for
% each photon.
% Output: Apix is the pixelated 'photons history' array.

    % The number of input photons
    size = 500; 
    % The data matrix containing the pixelated array
    Apix = zeros(20, 5, size);
    % voxel is the matrix containg the energy in each detector voxel 
    for i = 1:size
        voxel = zeros(100, 100, 10);
        for j = 1:sum(A(:,2,i)>0)
            % Evaluate and display the index
            ivox = fix( ( A(j, 3:5, i) + [99.99999,99.99999, 9.99999] ) / 2 ) + 1;
            % Increment the voxel value
            voxel(ivox(1), ivox(2), ivox(3)) = voxel(ivox(1), ivox(2), ivox(3)) + A(j, 2, i);
        end
        % Print the voxels indexes with values > 0
        n  = find(voxel); % The linear index array
        % Convert 'n' into (ii, jj, kk) index
        kk  = 1 + fix(n/1.e4);
        nn = mod(n, 1.e4);
        jj  = 1 + fix(nn/100);
        ii = mod(nn, 100);
        %index = [voxel(voxel > 0), ii, jj, kk];
        %disp(i);
        %disp( index );
        % Fill the pixelated photon list
        n_int = length(voxel(voxel > 0)); %length(index(:,1));
        detection = [ones(n_int,1)*i, voxel(voxel > 0), ii, jj, kk];
        %disp(detection);
        % Print the incident voxel
        %index2 = [A(j+1, 2, i), ivox];
        %disp(index2);
        if j >= 1
            % ivox = fix( ( A(j+1, 3:5, i) + 100. ) / 2 + 1);
            ivox = fix( ( A(j+1, 3:5, i) + [99.999,99.999, 9.999] ) / 2 ) + 1;
            photon = [i, A(j+1, 2, i), ivox];
        else
%        ivox = fix( ( A(1, 3:5, i) + 100. ) / 2 + 1);
            ivox = fix( ( A(1, 3:5, i) + [99.999,99.999, 9.999] ) / 2 ) + 1;
            photon = [i, A(1, 2, i), ivox];
        end
        %disp(photon);
        event = vertcat(detection, photon);
        %disp(event);
        % It fills the Apix pixelated events data array
        Apix(1:length(event(:,1)),:,i) = event;
    end
end

