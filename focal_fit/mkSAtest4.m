%
% mkSArun -- call mkSAinv with typical values
%

more off
addpath /asl/packages/ccast/source

% load the test 4 focal plane
d1 = load('fp_test4');

% inst_params options
opts = struct;
opts.version = 'jpss1';
opts.user_res = 'hires';
opts.inst_res = 'hires3';

% newILS options
opts.wrap = 'psinc n';

% nominal wlaser value
wlaser = 773.1307;

opts.foax = d1.foax(:,1); opts.frad = d1.frad(:,1);
sfile = 'SAinv_test4_LW.mat';
mkSAinv('LW', wlaser, sfile, opts);

opts.foax = d1.foax(:,2); opts.frad = d1.frad(:,2);
sfile = 'SAinv_test4_MW.mat';
mkSAinv('MW', wlaser, sfile, opts);

opts.foax = d1.foax(:,3); opts.frad = d1.frad(:,3);
sfile = 'SAinv_test4_SW.mat';
mkSAinv('SW', wlaser, sfile, opts);

