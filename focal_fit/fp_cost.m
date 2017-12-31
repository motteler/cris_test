%
% fp_cost - focal plane fitting cost function
% 

function z = focalfnx(dxy, x, y, t)

x = x(:); y = y(:); t = t(:);

z = (x + dxy(1)).^2 + (y + dxy(2)).^2 - t.^2;

