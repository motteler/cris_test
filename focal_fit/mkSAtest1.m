%
% mkSArun -- call mkSAinv with typical values
%

more off
addpath ../source

% default FOV off-axis angles
foax = [ 
   0.027150951288746
   0.019198621771938
   0.027150951288746
   0.019198621771938
                   0
   0.019198621771938
   0.027150951288746
   0.019198621771938
   0.027150951288746 ];

% default FOV radius
frad = ones(9,1) * 0.008403361344538;

% inst_params options
opts = struct;
opts.version = 'jpss1';
opts.user_res = 'hires';
opts.inst_res = 'hires3';

% newILS options
opts.wrap = 'psinc n';

% nominal wlaser value
wlaser = 773.1307;

opts.foax = foax; opts.frad = frad;

sfile = 'SAinv_test1_LW.mat';
mkSAinv('LW', wlaser, sfile, opts);

sfile = 'SAinv_test1_MW.mat';
mkSAinv('MW', wlaser, sfile, opts);

sfile = 'SAinv_test1_SW.mat';
mkSAinv('SW', wlaser, sfile, opts);

