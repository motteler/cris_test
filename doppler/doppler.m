function dnu_ppm = doppler(p);

% Compute Doppler shift of spectrum
%
% ASSUMES p.rlat is the satellite subpoint latitude, it is NOT
% SO: Replace p.rlat with the proper latitude

omega = 7.292E-5;  % radians/sec, earth's rotational velocity
Re = 6.3781E8;     % cm, earth radius
c = 2.99792E10;    % cm/sec, speed of light

% For now use obs lat for satellite lat...  best I can do with random

idesc = find(p.iudef(4,:)) == 0;

dnu_ppm = 1E6*((omega*Re)/c).*sin(deg2rad(p.satzen)).*cos(p.rlat).*abs(sin(deg2rad(p.satazi)));

dnu_ppm(idesc) = -dnu_ppm(idesc);

