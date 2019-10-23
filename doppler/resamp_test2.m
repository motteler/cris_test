%
% demo of doppler residuals
%

addpath /asl/packages/ccast/source

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
v_test = cris_ugrid(userLW, 2);
r_test = rLW(:, 5, 15, 2);

% generate a shifted grid
dppm = 1.25;            % ppm shift, test value
dsf = (1 + dppm*1e-6);  % shift as a scale factor

% interpolate to the shifted grid
[r_dopp, v_dopp] = finterp(r_test, v_test, dsf * userLW.dv);

% whos r_dopp v_dopp r_test v_test

% match grids and plot the difference
[ix, jx] = seq_match(v_test, v_dopp);
v_test = v_test(ix);
r_test = r_test(ix,:);
v_dopp = v_dopp(jx);
r_dopp = r_dopp(jx,:);

b_test = real(rad2bt(v_test, r_test));
b_dopp = real(rad2bt(v_test, r_dopp));

figure(1); clf
subplot(2,1,1)
plot(v_test, b_test)
axis([650,1100,200,300])
title('test spectra')
xlabel('wavenumber (cm-1)')
ylabel('BT')
grid on

subplot(2,1,2)
plot(v_test, b_dopp - b_test)
axis([650,1100,-0.08,0.08])
title('shift residual')
xlabel('wavenumber (cm-1)')
ylabel('dBT')
grid on

% saveas(gcf, 'j1_sample_doppler_resid', 'png')

