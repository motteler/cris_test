%
% fp_cost - focal plane fitting cost function
% 

function z = focalfnx(v, x, y, t)

x = x(:);
y = y(:);  
t = t(:);

dx = v(1);  
dy = v(2);
s  = v(3);

z = (s*x + dx).^2 + (s*y + dy).^2 - t.^2;

% z = (s*(x + dx)).^2 + (s*(y + dy)).^2 - t.^2;

