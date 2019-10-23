%
% compare resampling with fourier plus linear interpolation
%

addpath /asl/packages/ccast/source
addpath /asl/packages/ccast/motmsc/utils

% sample test data
load /asl/data/cris/ccast/sdr60_hr/2017/091/SDR_d20170401_t1229445.mat

% user grid params
dv = 0.6250;
v1 = vLW(1);
v2 = vLW(end);
j1 = floor(v1/dv);         % v1 index from 0
j2 = floor(v2/dv);         % v2 index from 0
jmid = floor((j1+j2)/2);   % midpoint index from 0
vmid = vLW(jmid-j1+1);     % midpoint frequency

% fake inst params for resampling
% the "instrument grid" is the user grid here
instLWdop.dv = 0.6250;
instLWdop.freq = vLW;
instLWdop.npts = length(vLW);

% resampling setup
% vmid == (dvres * jmid + shift)
shift = vmid * 2e-6;       % 2 ppm at vmid
dvres = dv - shift/jmid;   % resampling dv

% fake user params for resampling
% the "user grid" here is the resampled grid
userLWdop.dv = dvres;
userLWdop.v1 = j1*dvres;
userLWdop.v2 = j2*dvres;

% generate the resampling matrix
[R, vR] = resamp(instLWdop, userLWdop, 4);

% select some sample obs 
robs = squeeze(rLW(:, 5, 15, :));

% resample robs
rres = R * robs;
bres = rad2bt(vR, rres);

% fourier + linear interp
  vtmp2 = (j1:j2) * dvres;  % same as vR
% vtmp2 = vLW - shift;      % linear shift

[rtmp1, vtmp1] = finterp2(robs, vLW, 60);
rtmp2 = interp1(vtmp1, rtmp1, vtmp2, 'linear');
btmp2 = rad2bt(vtmp2, rtmp2);

bdif = bres - btmp2(2:end, :);
% subplot(2,1,2)
plot(vR, bdif)
% axis([650, 1100, -0.04, 0.04])
  axis([750, 850, -0.004, 0.004])
ylabel('dTb, K')
grid on
