%
% demo application of resampling for small frequency shifts
%

addpath /asl/packages/ccast/source

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
% the "instrument grid" is just the user grid
instLWdop.dv = 0.6250;
instLWdop.freq = vLW;
instLWdop.npts = length(vLW);

% resampling setup
% vmid == (dvres * jmid + shift)
shift = vmid * 0.2e-6;       % 5 ppm at vmid
dvres = dv - shift/jmid;   % resampling dv

% fake user params for resampling
% the "user grid" here is the resampled grid
userLWdop.dv = dvres;
userLWdop.v1 = j1*dvres;
userLWdop.v2 = j2*dvres;

% generate the resampling matrix
[R, frq2] = resamp(instLWdop, userLWdop, 4);

% plot(R(:, 360))
% axis([355, 364, -0.1, 1])
% axis([355, 364, -0.1, 1])
% grid on
% hold on

% tic
% for i = 1 : 9 * 30
%  [R, frq2] = resamp(instLWdop, userLWdop, 4);
% end
% toc

