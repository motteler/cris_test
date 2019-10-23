function dnu_ppm = doppler(p);
% Compute Doppler shift of spectrum
%
% ASSUMES p.udef(13,:) is the satellite subpoint latitude, idesc is p.iudef(4,:)

omega = 7.292E-5;  % radians/sec, earth's rotational velocity
Re = 6.3781E8;     % cm, earth radius
c = 2.99792E10;    % cm/sec, speed of light

% satzen must have a sign, set negative for RHS when looking in direction of motion
k = find(p.xtrack >= 16);
p.satzen(k) = -p.satzen(k);

% Doppler shift
dnu_ppm = 1E6*((omega*Re)/c).*sin(deg2rad(p.satzen)).*cos(deg2rad(p.udef(13,:))).*abs(sin(deg2rad(p.satazi)));

% Sign change for descending
idesc = find(p.iudef(4,:)) == 1;
dnu_ppm(idesc) = -dnu_ppm(idesc);

