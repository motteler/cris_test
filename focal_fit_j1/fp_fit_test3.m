%
% fp_fit_test2 -- 2-stage fit, dxy and position
%

addpath /home/motteler/cris/ccast/inst_data

% get the target off-axis angles
% d1 = load('SAinv_testB_HR4_SW.mat');
% t = d1.inst.foax * 1e6;  % off-axis angles to fit
  fx = get_fp5('LW', 'j1v2');
  t = fx.foax * 1e6; 

% get an initial focal plane for fitting
  fp = fp_default;
% d2 = load('j1_eng_v112');
% fp = fp_from_eng(d2.eng);

b = 1;                % set the band for fp
x = fp(b).pos(:, 1);  % focal plane x coord's
y = fp(b).pos(:, 2);  % focal plane y coord's
v0 = fp(b).dxy;       % dx,dy search start

% find dx, dy, and s to minimize fp_cost
[v2,rn,r] = lsqnonlin(@(v1) fp_costA(v1, x, y, t), v0);

% show the dxy shift
dx = v2(1); dy = v2(2);
fprintf(1, 'dx = %.2f, dy = %.2f\n', dx, dy)

% compare updated and initial angles
t2 = sqrt((x + dx).^2 + (y + dy).^2);
t3 = (t2 - t) ./ t;
t3 = t3 * 100;
fprintf(1, 'stage 1 fitting residual, pct\n')
rprint(t3)

% now fit x and y deltas for every fov
w0 = zeros(9, 1);    
[w2,rn,r] = lsqnonlin(@(w1) fp_cost3(w1, x, y, dx, dy, t), w0);

t4 = sqrt((x + cos(w2) + dx).^2 + (y + sin(w2) + dy).^2);
t5 = (t4 - t) ./ t;
t5 = t5 * 100;
fprintf(1, 'stage 2 fitting residual, pct\n')
rprint(t5)

w2

return

% get da and dv
d1 = load('testA_dv');
da2dvLW = d1.dvppmLW(:) ./ d1.dapct(:);
da2dvMW = d1.dvppmMW(:) ./ d1.dapct(:);
da2dvSW = d1.dvppmSW(:) ./ d1.dapct(:);

fprintf(1, 'fitting residual, ppm\n')
rprint(da2dvLW .* t3)
