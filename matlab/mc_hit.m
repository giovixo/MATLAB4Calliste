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
%Apix_new the energy is convolved with the detector resolution
%threshold is the detection threshold in keV

% Loop over the interactions
for i = 1:20
    % Get the element with energy under the threshold
    underThreshold = ( Apix(i, 2, :) < threshold ) & ( Apix(i, 2, :) > eps );
    Apix(i, 2, underThreshold) = 0;
    % As an example, set the the detector energy resoluton to 10 %
end

Apix_new = Apix;
end

