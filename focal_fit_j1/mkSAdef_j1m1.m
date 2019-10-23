%
% mkSAumbc - make umbc SA matrices
%

addpath ../source

% call get_fp for the focal planes 
name = 'default_j1m1';
band = {'LW', 'MW', 'SW'};
foax = NaN(9,3);
frad = NaN(9,3);
for i = 1
  fp = get_fp7(band{i}, name);
% s = fp.s; d = fp.d;
% foax(:,i) = sqrt((s(:,2) + d(1)).^2 + (s(:,3) + d(2)).^2) ./ 1e6;
  foax(:,i) = fp.foax;
  frad(:,i) = ones(9,1) *  16808 / 2e6;
end

% inst_params options
opts = struct;
opts.version = 'j01';
opts.user_res = 'hires';
opts.inst_res = 'hires4';
opts.wrap = 'psinc n';

% nominal wlaser value
wlaser = 773.1307;

% build the SA inverse matrices
opts.frad = frad(:,1);
opts.foax = foax(:,1);
sfile = 'SAinv_def_j1m1_LW.mat';
mkSAinv('LW', wlaser, sfile, opts);

