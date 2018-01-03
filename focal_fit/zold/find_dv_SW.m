%
% find shift for reference and shifted SDR calcs
%

addpath /asl/packages/ccast/source
addpath /asl/packages/ccast/motmsc/utils

% reference and shifted ccast SDR files
chome = '/asl/data/cris/ccast';
cgran = '2017/231/SDR_d20170819_t1242503.mat';
d1 = load(fullfile(chome, 'sdr60_hr', cgran));
d2 = load(fullfile(chome, 'test5', cgran));

ix = find(2200 <= d1.vSW & d1.vSW <= 2500);

ppmlist = -4e-6 : 0.2e-6 : 24e-6;

dmin = ones(9, 1) * 1e9;
imin = nan(9, 1);
iFOR = 15;

% loop on FOVs
for j = 1 : 9
  robs1 = mean(squeeze(d1.rSW(:, j, iFOR, :)), 2);
  robs2 = mean(squeeze(d2.rSW(:, j, iFOR, :)), 2);

  % loop on dv ppm steps
  for i = 1 : length(ppmlist)
    dvppm = ppmlist(i);
    vtmp2 = d1.vSW * (1 + dvppm);
    [rtmp1, vtmp1] = finterp2(robs1, d1.vSW, 60);
    rtmp2 = interp1(vtmp1, rtmp1, vtmp2, 'linear');
    btmp2 = rad2bt(vtmp2, rtmp2);
    bobs2 = rad2bt(d2.vSW, robs2);
    bdif = btmp2 - bobs2;
%   dtmp = mean(rms(bdif(ix,:)));
    dtmp = rms(bdif(ix,:));
    if dtmp < dmin(j), 
      dmin(j) = dtmp; 
      imin(j) = i;
    end
  end
end

dvppmSW = ppmlist(imin) * 1e6;
fprintf(1, '      frequency deltas, ppm\n')
rprint(dvppmSW)

% side = [2 4 6 8];
% corn = [1 3 7 9];
% dapct = zeros(9, 1);
% dapct(side) = -0.067;
% dapct(corn) = -0.030;
% dapct = dapct * 100;
% fprintf(1, '        angle deltas, pct\n')
% rprint(dapct)

% plot(d2.vSW, bdif)
% axis([650, 1100, -0.5, 0.5])
% ylabel('dTb, K')
% grid on

