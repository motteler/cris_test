%
% mkSArun -- call mkSAinv with typical values
%

more off
addpath ../source

% inst_params options
opts = struct;
opts.version = 'jpss1';
opts.user_res = 'hires';
opts.inst_res = 'hires3';

% newILS options
opts.wrap = 'psinc n';

% nominal wlaser value
wlaser = 773.1307;

[foax, frad] = fp_v33a('LW');
foax(3) = foax(3) * 0.97;
foax(6) = foax(6) * 0.98;
opts.foax = foax; opts.frad = frad;
sfile = 'SAinv_test3_LW.mat';
mkSAinv('LW', wlaser, sfile, opts);

[foax, frad] = fp_v33a('MW');
foax(1) = foax(1) * 0.97;
foax(2) = foax(2) * 0.98;
opts.foax = foax; opts.frad = frad;
sfile = 'SAinv_test3_MW.mat';
mkSAinv('MW', wlaser, sfile, opts);

[foax, frad] = fp_v33a('SW');
foax(7) = foax(7) * 0.98;
foax(4) = foax(4) * 0.99;
opts.foax = foax; opts.frad = frad;
sfile = 'SAinv_test3_SW.mat';
mkSAinv('SW', wlaser, sfile, opts);

