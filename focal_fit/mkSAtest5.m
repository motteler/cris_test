%
% mkSAtest5 - apply off-axis deltas to all FOVs except FOV 5
%
% The delta is -6.7 pct for side and -3 pct for corner FOVs.
%
%  FOV
% 7 4 1
% 8 5 2
% 9 6 3
%

more off
addpath /asl/packages/ccast/source

% inst_params options
opts = struct;
opts.version = 'snpp';
opts.user_res = 'hires';
opts.inst_res = 'hires3';

% newILS options
opts.wrap = 'psinc n';

% nominal wlaser value
wlaser = 773.1307;

side = [2 4 6 8];
corn = [1 3 7 9];

[foax, frad] = fp_v33a('LW');
foax(corn) = foax(corn) * (1 - 0.03);
foax(side) = foax(side) * (1 - 0.067);
opts.foax = foax; opts.frad = frad;
sfile = 'SAinv_test5_LW.mat';
mkSAinv('LW', wlaser, sfile, opts);

[foax, frad] = fp_v33a('MW');
foax(corn) = foax(corn) * (1 - 0.03);
foax(side) = foax(side) * (1 - 0.067);
opts.foax = foax; opts.frad = frad;
sfile = 'SAinv_test5_MW.mat';
mkSAinv('MW', wlaser, sfile, opts);

[foax, frad] = fp_v33a('SW');
foax(corn) = foax(corn) * (1 - 0.03);
foax(side) = foax(side) * (1 - 0.067);
opts.foax = foax; opts.frad = frad;
sfile = 'SAinv_test5_SW.mat';
mkSAinv('SW', wlaser, sfile, opts);

