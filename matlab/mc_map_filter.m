function [ output_map ] = mc_map_filter( input_map, dMin, dMax )
%MC_MAP_FILTER Scattering map filtering 
%   
%  newMap = mac_map_filter(double_map, d_min, d_max)
%
%  double map is the double event scattering map.
%  In the newMap the matrix element external to [d_min, dmax] are setted to zero.
%  d_min = 1 No internal filtering
%  d_max = 5 Distances 6, 7, 8, ecc... are setted to zero

    output_map = input_map; 
    origin = 101;
    % Clear the internal part
    dMin = dMin - 1;
    output_map( origin - dMin: origin + dMin, origin - dMin : origin + dMin ) = 0;
    % Clear the external part
    output_map( origin + (dMax+1) : end , : ) = 0;
    output_map( 1: origin - (dMax+1), : ) = 0;
    output_map( :, origin + (dMax+1) : end ) = 0;
    output_map( :, 1 : origin - (dMax+1) ) = 0;
end

