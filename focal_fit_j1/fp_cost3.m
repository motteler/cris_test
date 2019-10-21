%
% fp_cost - focal plane fitting cost function
% 

function z = fp_cost3(w, x, y, dx, dy, t)

x = x(:); 
y = y(:); 
t = t(:);

x = x + cos(w);
y = y + sin(w);

z = (x + dx).^2 + (y + dy).^2 - t.^2;

