%
% try lsqnonlin to find an x-y shift
%
% from the FM2008 functions fp_dxyfit and focalfnx.m
%

% get an eng packet
load /asl/data/cris/ccast/sdr60/2017/091/SDR_d20170401_t1229445.mat
% load j1_eng

% get the focal plane
fp = fp_from_eng(eng);

% x-y shifts
dxy(:,1) = fp.dxy(:,1) .* [0.96, 1.08]';
dxy(:,2) = fp.dxy(:,2) .* [0.94, 1.06]';
dxy(:,3) = fp.dxy(:,3) .* [0.94, 1.04]';

% single FOV shifts
% pos(3,:,1) = fp.pos(3,:,1) .* [0.96, 0.98]; 
% pos(6,:,2) = fp.pos(6,:,2) .* [1.04, 0.98]; 
% pos(7,:,3) = fp.pos(7,:,3) .* [0.92, 1.10]; 
  pos = fp.pos;

% off-axis angles with shift
for b = 1 : 3
  foax(:,b) = sqrt((pos(:,1,b) + dxy(1,b)).^2 + (pos(:,2,b) + dxy(2,b)).^2);
end

% try the FM2008 fitting code
b = 3;               % set the band
x = pos(:, 1, b);    % focal plane x coord's
y = pos(:, 2, b);    % focal plane y coord's
t = foax(:, b);      % off-axis angles to fit
dxy0 = fp.dxy(:,b);  % dx,dy search start

% find dx,dy shifts to match the measured off-axis angles
[dxy2,rn,r] = lsqnonlin(@(dxy1) fp_cost(dxy1, x, y, t), dxy0);

% show the defined shift
dxy(:,b) - fp.dxy(:,b)

% show fitted shift
dxy2 - dxy0

% plug dx and dy back into focal plane model
dx = dxy2(1); dy = dxy2(2);
t2 = sqrt((x + dx).^2 + (y + dy).^2);
t2(5) = NaN;

% compare updated and initial angles
fprintf(1, 'error of focal plane fit\n')
t3 = t2 - t;
rprint(t3)


