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

opts.foax = d1.foaxLW2; opts.frad = d1.fradLW;
sfile = 'SAinv_test4_LW.mat';
mkSAinv('LW', wlaser, sfile, opts);

opts.foax = d1.foaxMW2; opts.frad = d1.fradMW;
sfile = 'SAinv_test4_MW.mat';
mkSAinv('MW', wlaser, sfile, opts);

opts.foax = d1.foaxSW2; opts.frad = d1.fradSW;
sfile = 'SAinv_test4_SW.mat';
mkSAinv('SW', wlaser, sfile, opts);

