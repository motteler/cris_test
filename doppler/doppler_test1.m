%
% test calls of Larrabee's doppler function
%

% sample test data
tdir = '/asl/cris/ccast/sdr45_j01_HR/2019/091';
  gran = 'CrIS_SDR_j01_s45_d20190401_t2006080_g202_v20a.mat';
% gran = 'CrIS_SDR_j01_s45_d20190401_t0442080_g048_v20a.mat';
load(fullfile(tdir,gran));

% new function test
iFOR = 1;
iFOV = 5;
idesc = geo.Asc_Desc_Flag';
satzen = squeeze(geo.SatelliteZenithAngle(iFOV, iFOR, :))';
satazi = squeeze(geo.SatelliteAzimuthAngle(iFOV, iFOR, :))';
xtrack = ones(1,nscan) * iFOR;
sat_lat = squeeze(geo.Latitude(5, 15, :))';  % approx sat subpoint

dnu_ppm = doppler_cris_approx(idesc, xtrack, satzen, satazi, sat_lat);

dnu_ppm

return

% fake RTP struct for old doppler function
iFOR = 1;
iFOV = 5;
nscan = 45;
p = struct;

% copy one FOR, all atrack (scan) indices
p.udef = zeros(20,nscan);
p.iudef = zeros(10,nscan);
p.satzen = squeeze(geo.SatelliteZenithAngle(iFOV, iFOR, :))';
p.satazi = squeeze(geo.SatelliteAzimuthAngle(iFOV, iFOR, :))';
p.xtrack = ones(1,nscan) * iFOR;
p.ifov = ones(1,nscan) * iFOV;
p.udef(13,:) = geo.Latitude(5, 15, :);  % approx sat subpoint
p.iudef(4,:) = geo.Asc_Desc_Flag;
dnu_ppm = doppler(p);

j = 1:2;
q = struct;
q.udef = p.udef(:,j);
q.iudef = p.iudef(:,j);
q.satzen = p.satzen(j);
q.satazi = p.satazi(j);
q.xtrack = p.xtrack(j);
q.ifov = p.ifov(j);

doppler_cris_approx(q.iudef(4,:), q.xtrack, ...
                    q.satzen, q.satazi, q.udef(13,:))

