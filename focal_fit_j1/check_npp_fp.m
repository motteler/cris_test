%
% compare npp eng focal plane with get_fp and fp_v33a
%

addpath /asl/packages/ccast/source

% get an eng packet
load /asl/data/cris/ccast/sdr60/2017/091/SDR_d20170401_t1229445.mat
% load j1_eng

% get focal plane from eng
fp1 = fp_from_eng(eng);

% use get_fp for npp focal planes 
  name = 'npp';
% name = 'exelis';
band = {'LW', 'MW', 'SW'};
foax2 = NaN(9,3);
frad2 = NaN(9,3);
for i = 1 : 3
  fp = get_fp(band{i}, name);
  s = fp.s; d = fp.d;
  foax2(:,i) = sqrt((s(:,2) + d(1)).^2 + (s(:,3) + d(2)).^2) ./ 1e6;
  frad2(:,i) = ones(9,1) *  16808 / 2e6;
end

dLW = (foax2(:,1) - fp1.foax(:,1)) ./ fp1.foax(:,1);
dMW = (foax2(:,2) - fp1.foax(:,2)) ./ fp1.foax(:,2);
dSW = (foax2(:,3) - fp1.foax(:,3)) ./ fp1.foax(:,3);

fprintf(1, '---- get_fp npp vs npp eng, pct ----\n')
fprintf(1, 'LW pct diff\n'); rprint(dLW*100)
fprintf(1, 'MW pct diff\n'); rprint(dMW*100)
fprintf(1, 'SW pct diff\n'); rprint(dSW*100)

% use fp_v33a for npp focal plane
fp2LW = fp_v33a('LW');
fp2MW = fp_v33a('MW');
fp2SW = fp_v33a('SW');

dLW = (fp2LW - fp1.foax(:,1)) ./ fp1.foax(:,1);
dMW = (fp2MW - fp1.foax(:,2)) ./ fp1.foax(:,2);
dSW = (fp2SW - fp1.foax(:,3)) ./ fp1.foax(:,3);

fprintf(1, '---- fp_v33a vs npp eng, pct ----\n')
fprintf(1, 'LW pct diff\n'); rprint(dLW*100)
fprintf(1, 'MW pct diff\n'); rprint(dMW*100)
fprintf(1, 'SW pct diff\n'); rprint(dSW*100)

