
% call get_fp for the focal planes 
name = 'j1v3';
band = {'LW', 'MW', 'SW'};
foax1 = NaN(9,3);
foax2 = NaN(9,3);
frad = NaN(9,3);
for i = 1 : 3
  fp = get_fp6(band{i}, name);
  s = fp.s; d = fp.d;
  foax1(:,i) = sqrt((s(:,2) + d(1)).^2 + (s(:,3) + d(2)).^2) ./ 1e6;
  foax2(:,i) = fp.foax;
  frad(:,i) = ones(9,1) *  16808 / 2e6;
end

