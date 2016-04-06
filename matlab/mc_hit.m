function [ Apix_new ] = mc_hit ( Apix, threshold )
%MC_HIT(Apix) Return the measured energy
%
%Usage Apix_new = MC_HIT(Apix, threshold)
%
%Where:
%Apix is the pixelated event list Apix = Apix(i, j, n) 
%n is the main event number
%i is the index of the interaction
%j gives the dectection hit (index, energy, x, y, z)
%
%'Apix_new' is the pixelated event list where the energy is convolved with 
%the detector resolution.
%'threshold' is the detection threshold in keV

% Loop over the interactions
for i = 1:20
    % Find the elements with positive energy and apply a normal
    % distribution
    realDetection = ( Apix(i, 2, :) > eps );
    sigma = 0.1 * Apix(i, 2, realDetection); % Delta_E / E = 10 %
    Apix(i, 2, realDetection) = normrnd(Apix(i, 2, realDetection), sigma);
    % Find the elements with energy under the threshold and tag them
    underThreshold = ( ( Apix(i, 2, :) < threshold ) & ( Apix(i, 2, :) > eps ) );
    Apix(i, 1, underThreshold) = - Apix(i, 1, underThreshold);
end

Apix_new = Apix;
end

