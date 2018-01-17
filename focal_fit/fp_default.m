%
% fp_default - default CrIS focal plane
%
% SYNOPSIS
%   fp = fp_default
%
% OUTPUT
%   fp  - 1 x 3 struct array with fields
%     rad   - 9 x 1 FOV radii, urad
%     pos   - 9 x 2 FOV x-y position, urad
%     dxy   - 2 x 1 focal plane x-y shift, urad
%     foax  - 9 x 1 FOV off-axis angles, rad
%     frad  - 9 x 1 FOV radii, rad
%
% note: rad, pos, and dxy are in microradians, while foax and frad
% are in radians.
%

function fp = fp_default;

% pos, dxy, and rad in urad
pos = [     
   19198.62   19198.62
          0   19198.62
  -19198.62   19198.62
   19198.62          0
          0          0
  -19198.62          0
   19198.62  -19198.62
          0  -19198.62
  -19198.62  -19198.62 ];

dxy = zeros(2, 1);
rad = ones(9, 1) * 8404;

% foax and frad, in radians
foax = sqrt(pos(:,1).^2 + pos(:,2).^2) * 1e-6;
frad = rad * 1e-6;

% copy values to fp
fp = struct([]);
for i = 1 : 3
  fp(i).rad = rad;
  fp(i).pos = pos;
  fp(i).dxy = dxy;
  fp(i).frad = rad;
  fp(i).foax = foax;
end

