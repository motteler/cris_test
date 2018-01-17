%
% test 4: overall x-y and an individual FOV shift
% read cris-1 focal plane specs from the eng packet
%

% get an eng packet
load /asl/data/cris/ccast/sdr60/2017/091/SDR_d20170401_t1229445.mat
% load j1_eng

% get the focal plane
fp = fp_from_eng(eng);
dxy = fp.dxy;
pos = fp.pos;
frad = fp.frad;

% x-y shift
round([dxy(:,1), dxy(:,2), dxy(:,3)]')
dxy(:,1) = dxy(:,1) .* [0.96, 1.08]';
dxy(:,2) = dxy(:,2) .* [0.94, 1.06]';
dxy(:,3) = dxy(:,3) .* [0.94, 1.04]';
round([dxy(:,1), dxy(:,2), dxy(:,3)]')

% single FOV shift
pos(3,:,1) = pos(3,:,1) .* [0.96, 0.98]; 
pos(6,:,2) = pos(6,:,2) .* [1.04, 0.98]; 
pos(7,:,3) = pos(7,:,3) .* [0.92, 1.10]; 

for b = 1 : 3
  foax(:,b) = sqrt((pos(:,1,b) + dxy(1,b)).^2 + (pos(:,2,b) + dxy(2,b)).^2);
end
foax = foax * 1e-6;

for b = 1 : 3
  (foax(:,b) - fp.foax(:,b)) ./ fp.foax(:,b)
end

save fp_test4 frad foax

