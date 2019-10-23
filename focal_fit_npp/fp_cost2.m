%
% fp_cost - focal plane fitting cost function
% 

function z = fp_cost3(w, x, y, dx, dy, t)

x = x(:); 
y = y(:); 
t = t(:);

x = x + w(1:9);
y = y + w(10:18);

z = (x + dx).^2 + (y + dy).^2 - t.^2;

