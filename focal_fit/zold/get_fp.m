function [fp] = get_fp(band,srf_name);

sdef = [     
   1      19198.62      19198.62
   2             0      19198.62
   3     -19198.62      19198.62
   4      19198.62             0
   5             0             0
   6     -19198.62             0
   7      19198.62     -19198.62
   8             0     -19198.62
   9     -19198.62     -19198.62 ];

% Needed for running res_all, produces error for fit_run.m 
%   if srf_name == 'umbc2_sdir1'
%      srf_name = 'umbc2';
%   end

switch srf_name
%--------------------------------------------------------------    
  case 'default'
    switch band
      case 'LW'
        fp.s = sdef;
        fp.d = [0 0];
      case 'MW'
        fp.s = sdef;
        fp.d = [0 0];
      case 'SW'
        fp.s = sdef;
        fp.d = [0 0];
    end
%--------------------------------------------------------------  
  case 'umbc1'
    switch band
      case 'LW'
        fp.s = sdef;
        fp.d = [-606 -31];
        fp.ppm = [0 0 0 0 0 0 0 0 0];
      case 'MW'
        fp.s = sdef;
        fp.d = [-658 -32];
        fp.ppm = [0 0 0 0 0 0 0 0 0];
      case 'SW'
        fp.s = sdef;
        fp.d = [-614 -10];
        fp.ppm = [0 0 0 0 0 0 0 0 0];
    end
%--------------------------------------------------------------  
  case 'umbc2'
    switch band
      case 'LW'
         fp.s = sdef;
         dnew = [5 9 99];  % add these to umbc1
         % From umbc1 MN LW (after r fit)
         fp.ppm = [0.4 0.8 -1.0 -1.0 0 -0.5 1.0 -2.8 2.0];
         fp.d = [-606 -31 0] + dnew;
         fp = mod_fp(fp);
      case 'MW'
        fp.s = sdef;
        dnew = [0 22 -25];
        fp.ppm = [-0.3 0.6 0 0 0 -0.6 0.1 -0.1 0.3];
        fp.d = [-658 -32 0] + dnew;
        fp = mod_fp(fp);
      case 'SW'
        fp.s = sdef;
        dnew = [9 16 -63];
        fp.d = [-614 -10 0] + dnew;
        fp.ppm = [-1.1 1.4 -0.5 0.8 0 0.6 -0.2 0.7 -0.7];
        fp = mod_fp(fp);
    end
%--------------------------------------------------------------  
  case 'exelis'
    switch band
      case 'LW'
        fp.s = [
           1    19193    19193
           2        0    19283
           3   -19173    19173
           4    19256        0
           5       0         0
           6   -19256        0
           7    19342   -19342
           8        0   -19283
           9   -19354   -19354];
        fp.d = [-516  91];
      case 'MW'
        fp.s = [
           1    19176    19176
           2        0    19211
           3   -19184    19184
           4    19194        0
           5       0         0
           6   -19194        0
           7    19199   -19199
           8        0   -19211
           9   -19210   -19210
               ];
        fp.d = [-582  0];
      case 'SW'
        fp.s = [
           1    19125    19125
           2        0    19182
           3   -19136    19136
           4    19194        0
           5       0         0
           6   -19168        0
           7    19164   -19164
           8        0   -19182
           9   -19156   -19156
               ];
        fp.d = [-578  13];
    end
%--------------------------------------------------------------  
end
end
%--------------------------------------------------------------  
function fp = mod_fp(fp);

dr = fp.d(3);
% s(:,2) == y
% s(:,3) == x
fpang = atan2(fp.s(:,2),fp.s(:,3));
id = [1:4 6:9];  % FOV5 angle no good and not needed
fp.s(id,3) = fp.s(id,3) + dr.*cos(fpang(id));
fp.s(id,2) = fp.s(id,2) + dr.*sin(fpang(id));
% Now have to add in FOV by FOV changes that a single dr can't fix
c     = -1/36.8;
s     = -1/52.2;
alpha = [ c s c s 0 s c s c];
% This is individual dr, starting with fp.ppm (ppm units)
dr = -(fp.ppm./alpha)'; % Got the minus wrong for a long time!!
dr(5) = 0;  % So, no id needed here
fp.s(:,3) = fp.s(:,3) + dr.*cos(fpang(:));
fp.s(:,2) = fp.s(:,2) + dr.*sin(fpang(:));

end
%--------------------------------------------------------------  
