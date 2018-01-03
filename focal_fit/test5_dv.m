%
% alternate code to get the test 5 frequency shifts
%

addpath /asl/packages/ccast/source
addpath /asl/packages/ccast/motmsc/utils

% test 5 reference and shifted ccast SDR files
chome = '/asl/data/cris/ccast';
cgran = '2017/231/SDR_d20170819_t1242503.mat';
d1 = load(fullfile(chome, 'sdr60_hr', cgran));
d2 = load(fullfile(chome, 'test5', cgran));

% LW data
robs1 = double(mean(squeeze(d1.rLW(:, :, 15, :)), 3));
robs2 = double(mean(squeeze(d2.rLW(:, :, 15, :)), 3));
vobs = double(d1.vLW);

% LW shift 
v1 = 700; v2 = 800;
ppmlist = -4e-6 : 0.1e-6 : 27e-6;
[dmin, imin] = find_dv(vobs, robs1, robs2, v1, v2, ppmlist);
dvppmLW = ppmlist(imin) * 1e6;
fprintf(1, 'LW frequency deltas, ppm\n')
rprint(dvppmLW)

% MW data
robs1 = double(mean(squeeze(d1.rMW(:, :, 15, :)), 3));
robs2 = double(mean(squeeze(d2.rMW(:, :, 15, :)), 3));
vobs = double(d1.vMW);

% MW shift span
v1 = 1300; v2 = 1700;
ppmlist = -4e-6 : 0.1e-6 : 25e-6;
[dmin, imin] = find_dv(vobs, robs1, robs2, v1, v2, ppmlist);
dvppmMW = ppmlist(imin) * 1e6;
fprintf(1, 'MW frequency deltas, ppm\n')
rprint(dvppmMW)

% SW data
robs1 = double(mean(squeeze(d1.rSW(:, :, 15, :)), 3));
robs2 = double(mean(squeeze(d2.rSW(:, :, 15, :)), 3));
vobs = double(d1.vSW);

% SW shift span
v1 = 2200; v2 = 2500;
ppmlist = -4e-6 : 0.1e-6 : 25e-6;
[dmin, imin] = find_dv(vobs, robs1, robs2, v1, v2, ppmlist);
dvppmSW = ppmlist(imin) * 1e6;
fprintf(1, 'SW frequency deltas, ppm\n')
rprint(dvppmSW)

% off-axis deltas
side = [2 4 6 8];
corn = [1 3 7 9];
dapct = zeros(9, 1);
dapct(side) = -0.067;
dapct(corn) = -0.030;
dapct = dapct * 100;
fprintf(1, 'off-axis angle deltas, pct\n')
rprint(dapct)

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
axis([798, 799, 255, 264])
legend('ref', 'mod')
grid on; zoom on

