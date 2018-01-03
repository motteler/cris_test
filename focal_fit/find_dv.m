%
% find dv for reference and shifted SDR calcs
%
% robs1 reference obs
% robs2 shifted obs
% shift is in ppm

function [dmin, imin] = find_dv(vobs, robs1, robs2, v1, v2, ppmlist)

ix = find(v1 <= vobs & vobs <= v2);

bobs1 = rad2bt(vobs, robs1);

dmin = ones(9, 1) * 1e9;
imin = NaN(9, 1);

% loop on FOVs
for j = 1 : 9

  % loop on dv ppm steps
  for i = 1 : length(ppmlist)

    dvppm = ppmlist(i);

    % Suppose robs2 would be correctly sampled at vshift.
    % Interpolate robs2 to vobs as follows (1) subdivide robs2 
    % (with finterp2) and then (2) do linear interpolation to 
    % the vobs grid.

    vshift = vobs * (1 + dvppm);
    [rtmp2, vtmp2] = finterp2(robs2(:,j), vshift, 60);
    vtmp2 = vtmp2';

    rshift = interp1(vtmp2, rtmp2, vobs, 'linear', 'extrap');
    bshift = rad2bt(vobs, rshift);
    dtmp = rms(bshift(ix) - bobs1(ix, j));
    if dtmp < dmin(j), 
      dmin(j) = dtmp; 
      imin(j) = i;
    end
  end
end

