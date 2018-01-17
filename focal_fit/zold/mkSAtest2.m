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
foax(9) = foax(9) * 0.97;
foax(8) = foax(8) * 0.98;
opts.foax = foax; opts.frad = frad;
sfile = 'SAinv_test2_LW.mat';
mkSAinv('LW', wlaser, sfile, opts);

[foax, frad] = fp_v33a('MW');
foax(7) = foax(7) * 0.96;
foax(4) = foax(4) * 0.97;
opts.foax = foax; opts.frad = frad;
sfile = 'SAinv_test2_MW.mat';
mkSAinv('MW', wlaser, sfile, opts);

[foax, frad] = fp_v33a('SW');
foax(1) = foax(1) * 0.97;
foax(4) = foax(4) * 0.98;
opts.foax = foax; opts.frad = frad;
sfile = 'SAinv_test2_SW.mat';
mkSAinv('SW', wlaser, sfile, opts);

