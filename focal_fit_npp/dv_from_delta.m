%
% dv_from_delta - find the freq diff of two ccast granules
%

addpath /home/motteler/cris/ccast/motmsc/utils
addpath /home/motteler/cris/ccast/source
addpath /home/motteler/cris/ccast/test

% reference and shifted ccast SDR files
p1 = '/asl/cris/ccast/sdr45_npp_HR/2019/180';
p2 = '/asl/cris_tmp/NPP_delta/sdr45_npp_HR/2019/180';
  cgran = 'CrIS_SDR_npp_s45_d20190629_t0218080_g024_v20a.mat';
% cgran = 'CrIS_SDR_npp_s45_d20190629_t0106080_g012_v20a.mat';
% cgran = 'CrIS_SDR_npp_s45_d20190629_t0130080_g016_v20a.mat';

d1 = load(fullfile(p1, cgran));
d2 = load(fullfile(p2, cgran));
lat = d1.geo.Latitude(5,15,22);
lon = d1.geo.Longitude(5,15,22);
fprintf(1, 'granule center lat %4.2f lon %4.2f\n', lat, lon)

% LW data
robs1 = double(mean(squeeze(d1.rLW(:, :, 15, :)), 3));
robs2 = double(mean(squeeze(d2.rLW(:, :, 15, :)), 3));
vobs = double(d1.vLW);

% LW shift 
v1 = 700; v2 = 800;
ppmlist = -40e-6 : 0.1e-6 : 10e-6;
[dmin, imin] = find_dv(vobs, robs1, robs2, v1, v2, ppmlist);
dvppmLW = ppmlist(imin) * -1e6;
fprintf(1, 'LW frequency deltas, ppm\n')
rprint(dvppmLW)

% MW data
robs1 = double(mean(squeeze(d1.rMW(:, :, 15, :)), 3));
robs2 = double(mean(squeeze(d2.rMW(:, :, 15, :)), 3));
vobs = double(d1.vMW);

% MW shift span
v1 = 1300; v2 = 1700;
ppmlist = -40e-6 : 0.1e-6 : 10e-6;
[dmin, imin] = find_dv(vobs, robs1, robs2, v1, v2, ppmlist);
dvppmMW = ppmlist(imin) * -1e6;
fprintf(1, 'MW frequency deltas, ppm\n')
rprint(dvppmMW)

% SW data
robs1 = double(mean(squeeze(d1.rSW(:, :, 15, :)), 3));
robs2 = double(mean(squeeze(d2.rSW(:, :, 15, :)), 3));
vobs = double(d1.vSW);

% SW shift span
v1 = 2200; v2 = 2250;
ppmlist = -40e-6 : 0.1e-6 : 10e-6;
[dmin, imin] = find_dv(vobs, robs1, robs2, v1, v2, ppmlist);
dvppmSW = ppmlist(imin) * -1e6;
fprintf(1, 'SW frequency deltas, ppm\n')
rprint(dvppmSW)

save dv_from_delta dvppmLW dvppmMW dvppmSW

return

% check spectral features for shift
v0 = d1.vSW;
r1 = squeeze(d1.rSW(:, 1, 15, :));
b1 = real(rad2bt(v0, r1));
b1 = mean(b1, 2);
plot(v0, b1)
grid on; zoom on

v0 = d1.vMW;
r1 = squeeze(d1.rMW(:, 1, 15, :));
b1 = real(rad2bt(v0, r1));
b1 = mean(b1, 2);
plot(v0, b1)
grid on; zoom on

% shift direction sanity check
v0 = d1.vLW;
r1 = squeeze(d1.rLW(:, 1, 15, :));
r2 = squeeze(d2.rLW(:, 1, 15, :));
[r1, v1] = finterp2(r1, v0, 20);
[r2, v2] = finterp2(r2, v0, 20);
b1 = real(rad2bt(v1, r1));
b2 = real(rad2bt(v2, r2));
b1 = mean(b1, 2);
b2 = mean(b2, 2);
plot(v1, b1, v2, b2)
axis([798, 799, 253, 263])
legend('ref', 'mod')
grid on; zoom on


