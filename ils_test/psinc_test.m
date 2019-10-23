%
% psinc_demo - sinc and psinc integrated and single-ray ILS
%

addpath /home/motteler/cris/ccast/source
addpath /home/motteler/cris/ccast/motmsc/utils

% inst parameters
band = 'LW';
wlaser = 773.1301;
opts = struct;
opts.user_res = 'hires';
opts.inst_res = 'hires3';
[foax, frad] = fp_v33a(band);
opts.foax = foax;
opts.frad = frad;
[inst, user] = inst_params(band, wlaser, opts);

% demo parameters
ifov = 1;
vref = user.v1 + 0.4 * (user.v2 - user.v1);
vgrid = inst.freq;
theta = opts.foax(ifov);
opd = inst.opd;
N = inst.npts;
pv1 = 10 * round(vgrid(1)/10);
pv2 = 10 * round(vgrid(end)/10);

% regular sinc integrated ILS
opts.narc = 1000;
opts.wrap = 'sinc';
srf1 = newILS(ifov, inst, vref, vgrid, opts);

% periodic sinc integrated ILS
opts.wrap = 'psinc n';
srf2 = newILS(ifov, inst, vref, vgrid, opts);

ddv = inst.dv / inst.df;
vgrid = vgrid(1) : ddv : vgrid(end);

% regular sinc single-ray ILS
srf3 = rsinc(2*(vgrid - vref*cos(theta))*opd);
srf3 = srf3 / sum(srf3);

% periodic sinc single-ray ILS
srf4 = psinc(2*(vgrid - vref*cos(theta))*opd, N*inst.df);
srf4 = srf4 / sum(srf4);


plot(vgrid, srf3 - srf4)


return


% single-ray and ILS plots
figure(2); clf
plot(vgrid, srf1, vgrid, srf2, vgrid, srf3, vgrid, srf4)
axis([pv1, pv2, -0.2, 0.8])
title(sprintf('FOV %d single-ray and ILS comparison', ifov))
legend('sinc ILS', 'psinc ILS', 'sinc ray', 'psinc ray')
xlabel('wavenumber')
ylabel('normalized weight')
grid on; zoom on

% extended periodic sinc
figure(3); clf
plot(frq5, srf5)
title('periodic sinc with wraps')
xlabel('wavenumber')
ylabel('not normalized')
grid on; zoom on

% check subinterval sums
m = numel(srf5) - N;
t1 = zeros(m,1);
for i = 1 : m
  t1(i) = sum(srf5(i : i + N -1));
end

figure(4); clf
plot(t1)
title('N point sums')
xlabel('starting index')
ylabel('sum')
grid on; zoom on

