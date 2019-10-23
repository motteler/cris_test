%
% get dx,dy shifts and scaling factor s from foax
%
% start with the off-axis angles (foax) from f1, and fit for those
% angles using f0 as the search start.  f2 is the result of the fit.
% compare f2 with f1.

addpath /home/motteler/cris/ccast/inst_data

% target off-axis angles are from f1
f1 = get_fp('LW', 'npp2');
t = f1.foax * 1e6; 

% f0 is the initial focal plane, for fitting
d2 = load('npp_eng_v39');
f0 = fp_from_eng(d2.eng);
% f0 = fp_default;

b = 1;                  % choose band for fit
x = f0(b).pos(:, 1);    % f0 x coord's
y = f0(b).pos(:, 2);    % f0 y coord's
% v0 = f0(b).dxy;       % f0 dx,dy search start
  v0 = [f0(b).dxy; 1] ; % f0 dx,dy,s search start

% find dx, dy, and s to minimize fp_cost
% [v2,rn,r] = lsqnonlin(@(v1) fp_costA(v1, x, y, t), v0);
  [v2,rn,r] = lsqnonlin(@(v1) fp_costB(v1, x, y, t), v0);

% show the shift
dx = v2(1); dy = v2(2); s = v2(3);
fprintf(1, 'dx = %.2f, dy = %.2f, s = %.4f\n', dx, dy, s)
% dx = v2(1); dy = v2(2);
% fprintf(1, 'dx = %.2f, dy = %.2f\n', dx, dy)

% t2 = sqrt((x + dx).^2 + (y + dy).^2);
  t2 = sqrt((s*x + dx).^2 + (s*y + dy).^2);

% compare updated and initial angles
fprintf(1, 'fitting residual, pct\n')
t3 = (t2 - t) ./ t;
t3 = t3 * 100;
rprint(t3)

% f2 is the updated f0 x and y positions
% x2 = s*x + dx; y2 = s*y + dy;
x2 = s*x; y2 = s*y;

% f1 x and y positions
x1 = f1.s(:,2); y1 = f1.s(:,3);
[x2-x1, y2-y1]
