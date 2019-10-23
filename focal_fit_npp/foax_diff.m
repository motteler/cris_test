
addpath ../source
addpath /home/motteler/cris/cris_test/focal_fit

% call get_fp for the focal planes 
name = 'j1v3';
band = {'LW', 'MW', 'SW'};
foax1 = NaN(9,3);
frad1 = NaN(9,3);
for i = 1 : 3
  fp = get_fp6(band{i}, name);
% s = fp.s; d = fp.d;
% foax1(:,i) = sqrt((s(:,2) + d(1)).^2 + (s(:,3) + d(2)).^2) ./ 1e6;
  foax1(:,i) = fp.foax;
  frad1(:,i) = ones(9,1) *  16808 / 2e6;
end

% call get_fp for the focal planes 
% name = 'umbc2';
  name = 'exelis';
band = {'LW', 'MW', 'SW'};
foax2 = NaN(9,3);
frad2 = NaN(9,3);
for i = 1 : 3
  fp = get_fp1(band{i}, name);
  s = fp.s; d = fp.d;
  foax2(:,i) = sqrt((s(:,2) + d(1)).^2 + (s(:,3) + d(2)).^2) ./ 1e6;
  frad2(:,i) = ones(9,1) *  16808 / 2e6;
end

da = 100 * (foax1 - foax2) ./ foax2

