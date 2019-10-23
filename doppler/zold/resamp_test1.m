%
% demo application of doppler correction with resampling
%
% Larrabee's doppler function uses RTP fields
%   subpoint lat     p.udef(13,:)
%   descending flag  p.iudef(4,:)
%   sat zenith       p.satzen
%   sat azimuth      p.satazi
%   FOR index        p.xtrack
%

addpath /asl/packages/ccast/source

% sample test data
tdir = '/asl/cris/ccast/sdr45_j01_HR/2019/091';
% gran = 'CrIS_SDR_j01_s45_d20190401_t2006080_g202_v20a.mat';
  gran = 'CrIS_SDR_j01_s45_d20190401_t0442080_g048_v20a.mat';
load(fullfile(tdir,gran));

% user grid (correction target)
vg_user = cris_ugrid(userLW, 2);
dv_user = userLW.dv;

% shifted grid (correction source)
dppm = 1.25;            % ppm shift, test value
dsf = (1 + dppm*1e-6);  % shift as a scale factor
vg_dopp = vg_user * dsf;
dv_dopp = dv_user * dsf;

% fake inst grid for resampling
instR = struct;
instR.freq = vg_user;
instR.dv = dv_user;
instR.npts = length(vg_user);

% fake user grid for resampling
userR = struct;
userR.dv = dv_dopp;

% generate the resampling matrix
[R, frqR] = resamp(instR, userR, 4);

% apply the resampling matrix
r_test = rLW(:, 5, 15, 22);
r_dopp = R * r_test;

% shift to a common grid
dvc = 0.002;
[r_test2, v_test2] = finterp(r_test, vLW, dvc);
[r_dopp2, v_dopp2] = finterp(r_dopp, frqR, dvc);

[ix, jx] = seq_match(v_test2, v_dopp2);
v_test2 = v_test2(ix);
r_test2 = r_test2(ix,:);
v_dopp2 = v_dopp2(jx);
r_dopp2 = r_dopp2(jx,:);

b_test2 = real(rad2bt(v_test2, r_test2));
b_dopp2 = real(rad2bt(v_dopp2, r_dopp2));

plot(v_test2,  b_dopp2 - b_test2)





