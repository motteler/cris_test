%
% demo of doppler residuals for all 3 bands
%

addpath /asl/packages/ccast/source
addpath /asl/packages/airs_decon/source

% sample test data
tdir = '/asl/cris/ccast/sdr45_j01_HR/2019/091';
% gran = 'CrIS_SDR_j01_s45_d20190401_t0442080_g048_v20a.mat';
% gran = 'CrIS_SDR_j01_s45_d20190401_t0454080_g050_v20a.mat';
% gran = 'CrIS_SDR_j01_s45_d20190401_t0500080_g051_v20a.mat';
  gran = 'CrIS_SDR_j01_s45_d20190401_t0506080_g052_v20a.mat'; % warm
% gran = 'CrIS_SDR_j01_s45_d20190401_t0512080_g053_v20a.mat';
% gran = 'CrIS_SDR_j01_s45_d20190401_t2006080_g202_v20a.mat';

load(fullfile(tdir,gran));
[geo.Latitude(5,15,2), geo.Longitude(5,15,2)]

% choose a test subset
v_testLW = cris_ugrid(userLW, 2)';
v_testMW = cris_ugrid(userMW, 2)';
v_testSW = cris_ugrid(userSW, 2)';

r_testLW = double(rLW(:, 5, 15, 2));
r_testMW = double(rMW(:, 5, 15, 2));
r_testSW = double(rSW(:, 5, 15, 2));

% generate a shifted grid
dppm = 1.25;            % ppm shift, test value
dsf = (1 + dppm*1e-6);  % shift as a scale factor

% interpolate to the shifted grid
[r_doppLW, v_doppLW] = finterp(r_testLW, v_testLW, dsf * userLW.dv);
[r_doppMW, v_doppMW] = finterp(r_testMW, v_testMW, dsf * userMW.dv);
[r_doppSW, v_doppSW] = finterp(r_testSW, v_testSW, dsf * userSW.dv);

% match grids and plot the difference
[ix, jx] = seq_match(v_testLW, v_doppLW);
v_testLW = v_testLW(ix);  r_testLW = r_testLW(ix,:);
v_doppLW = v_doppLW(jx);  r_doppLW = r_doppLW(jx,:);

[ix, jx] = seq_match(v_testMW, v_doppMW);
v_testMW = v_testMW(ix);  r_testMW = r_testMW(ix,:);
v_doppMW = v_doppMW(jx);  r_doppMW = r_doppMW(jx,:);

[ix, jx] = seq_match(v_testSW, v_doppSW);
v_testSW = v_testSW(ix);  r_testSW = r_testSW(ix,:);
v_doppSW = v_doppSW(jx);  r_doppSW = r_doppSW(jx,:);

% add apodization
r_testLWa = hamm_app(r_testLW);
r_doppLWa = hamm_app(r_doppLW);
r_testMWa = hamm_app(r_testMW);
r_doppMWa = hamm_app(r_doppMW);
r_testSWa = hamm_app(r_testSW);
r_doppSWa = hamm_app(r_doppSW);

% concatenate bands
v_test  = [v_testLW;  v_testMW;  v_testSW];
r_test  = [r_testLW;  r_testMW;  r_testSW];
r_testa = [r_testLWa; r_testMWa; r_testSWa];
v_dopp  = [v_doppLW;  v_doppMW;  v_doppSW];
r_dopp  = [r_doppLW;  r_doppMW;  r_doppSW];
r_doppa = [r_doppLWa; r_doppMWa; r_doppSWa];

% get brightness temps
b_test  = real(rad2bt(v_test, r_test));
b_testa = real(rad2bt(v_test, r_testa));
b_dopp  = real(rad2bt(v_test, r_dopp));
b_doppa = real(rad2bt(v_test, r_doppa));

figure(1); clf
subplot(2,1,1)
plot(v_test, b_test)
axis([600,2600,200,300])
title('unapodized test spectra')
xlabel('wavenumber (cm-1)')
ylabel('BT (K)')
grid on

subplot(2,1,2)
plot(v_test, b_dopp - b_test)
axis([600,2600,-0.2,0.2])
title('unapodized +1.25 ppm shift residual')
xlabel('wavenumber (cm-1)')
ylabel('dBT (K)')
grid on
% saveas(gcf, 'j1_1p25_sinc_doppler_resid', 'png')
% saveas(gcf, 'j1_1p25_sinc_doppler_resid', 'fig')

figure(2); clf
subplot(2,1,1)
plot(v_test, b_testa)
axis([600,2600,200,300])
title('apodized test spectra')
xlabel('wavenumber (cm-1)')
ylabel('BT (K)')
grid on

subplot(2,1,2)
plot(v_test, b_doppa - b_testa)
axis([600,2600,-0.05,0.05])
title('apodized +1.25 ppm shift residual')
xlabel('wavenumber (cm-1)')
ylabel('dBT (K)')
grid on
% saveas(gcf, 'j1_1p25_apod_doppler_resid', 'png')
% saveas(gcf, 'j1_1p25_apod_doppler_resid', 'fig')

