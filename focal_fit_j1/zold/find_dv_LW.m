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

ix = find(700 <= d1.vLW & d1.vLW <= 800);

ppmlist = 17e-6 : 0.2e-6 : 27e-6;

dmin = ones(9, 1) * 1e9;
imin = nan(9, 1);
iFOR = 17;

% loop on FOVs
for j = 1 : 9
  robs1 = squeeze(d1.rLW(:, j, iFOR, :));
  robs2 = squeeze(d2.rLW(:, j, iFOR, :));

  % loop on dv ppm steps
  for i = 1 : length(ppmlist)
    dvppm = ppmlist(i);
    vtmp2 = d1.vLW * (1 + dvppm);
    [rtmp1, vtmp1] = finterp2(robs1, d1.vLW, 60);
    rtmp2 = interp1(vtmp1, rtmp1, vtmp2, 'linear');
    btmp2 = rad2bt(vtmp2, rtmp2);
    bobs2 = rad2bt(d2.vLW, robs2);
    bdif = btmp2 - bobs2;
    dtmp = mean(rms(bdif(ix,:)));
    if dtmp < dmin(j), 
      dmin(j) = dtmp; 
      imin(j) = i;
    end
  end
end

dvppmLW = ppmlist(imin) * 1e6;
dvppmLW(5) = 0;
fprintf(1, '      frequency deltas, ppm\n')
rprint(dvppmLW)

side = [2 4 6 8];
corn = [1 3 7 9];
dapct = zeros(9, 1);
dapct(side) = -0.067;
dapct(corn) = -0.030;
dapct = dapct * 100;
fprintf(1, '        angle deltas, pct\n')
rprint(dapct)

% save find_dv_LW dvppmLW dapct

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
legend('1', '2')
grid on; zoom on

