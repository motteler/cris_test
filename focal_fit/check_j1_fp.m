%
% compare j1 eng focal plane with get_fp 'exelis'
%

% call fp_from_eng
load j1_eng
fp = fp_from_eng(eng);
frad1 = fp.frad;
foax1 = fp.foax;

% call get_fp for UMBC focal planes 
% (from CrIS_FM2/source/mkSAumbc.m)
% name = 'umbc2';
  name = 'exelis';
band = {'LW', 'MW', 'SW'};
foax2 = NaN(9,3);
frad2 = NaN(9,3);
for i = 1 : 3
  fp = get_fp(band{i}, name);
  s = fp.s; d = fp.d;
% foax2(:,i) = sqrt((s(:,2) - d(1)).^2 + (s(:,3) - d(2)).^2) ./ 1e6;
  foax2(:,i) = sqrt((s(:,2) + d(1)).^2 + (s(:,3) + d(2)).^2) ./ 1e6;
  frad2(:,i) = ones(9,1) *  16808 / 2e6;
end

% compare
fprintf(1, '      ------ %s -----\n', name)
reldif = nan(9,3);
for i = 1 : 3
% reldif(:,i) = ((frad2(:,i) - frad1(:,i)) ./ frad1(:,i));
  reldif(:,i) = ((foax2(:,i) - foax1(:,i)) ./ foax1(:,i));

  fprintf(1, '     %s (umbc - eng)/eng pct\n', band{i})
  rprint(reldif(:,i) * 100)
end

