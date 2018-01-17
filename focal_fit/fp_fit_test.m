%
% get dx,dy shifts and scaling factor s from foax
%

addpath /home/motteler/cris/ccast/inst_data

% get the target off-axis angles
  d1 = load('SAinv_testB_HR4_SW.mat');
  t = d1.inst.foax * 1e6;  % off-axis angles to fit
% fx = get_fp5('LW', 'j1v2');
% t = fx.foax * 1e6; 

% get an initial focal plane for fitting
  fp = fp_default;
% d2 = load('j1_eng_v112');
% fp = fp_from_eng(d2.eng);

b = 1;                  % set the band for fp
x = fp(b).pos(:, 1);    % focal plane x coord's
y = fp(b).pos(:, 2);    % focal plane y coord's
  v0 = fp(b).dxy;       % dx,dy search start
% v0 = [fp(b).dxy; 1] ; % dx,dy,s search start

% find dx, dy, and s to minimize fp_cost
  [v2,rn,r] = lsqnonlin(@(v1) fp_cost(v1, x, y, t), v0);
% [v2,rn,r] = lsqnonlin(@(v1) fp_cost2(v1, x, y, t), v0);

% show the shift
% dx = v2(1); dy = v2(2); s = v2(3);
% fprintf(1, 'dx = %.2f, dy = %.2f, s = %.4f\n', dx, dy, s)
dx = v2(1); dy = v2(2);
fprintf(1, 'dx = %.2f, dy = %.2f\n', dx, dy)

  t2 = sqrt((x + dx).^2 + (y + dy).^2);
% t2 = sqrt((s*x + dx).^2 + (s*y + dy).^2);

% compare updated and initial angles
fprintf(1, 'fitting residual, pct\n')
t3 = (t2 - t) ./ t;
t3 = t3 * 100;
rprint(t3)

% get da and dv
d1 = load('testA_dv');
da2dvLW = d1.dvppmLW(:) ./ d1.dapct(:);
da2dvMW = d1.dvppmMW(:) ./ d1.dapct(:);
da2dvSW = d1.dvppmSW(:) ./ d1.dapct(:);

fprintf(1, 'fitting residual, ppm\n')
rprint(da2dvLW .* t3)
