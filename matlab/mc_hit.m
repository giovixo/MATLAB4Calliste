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


Apix_new = Apix;
end

