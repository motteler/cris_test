%
% test 4: overall x-y and an individual FOV shift
% read cris-1 focal plane specs from the eng packet
%

load /asl/data/cris/ccast/sdr60/2017/091/SDR_d20170401_t1229445.mat
% load j1_eng

% x-y FOV positions
posLW = NaN(9, 2);
posMW = NaN(9, 2);
posSW = NaN(9, 2);

% FOV radii
radLW = NaN(9, 1);
radMW = NaN(9, 1);
radSW = NaN(9, 1);

% x-y common offset
dxyLW = NaN(1, 2);
dxyMW = NaN(1, 2);
dxySW = NaN(1, 2);

for i = 1 : 9
 radLW(i) = eng.ILS_Param.Band(1).FOV(i).FOV_Size;
 radMW(i) = eng.ILS_Param.Band(2).FOV(i).FOV_Size;
 radSW(i) = eng.ILS_Param.Band(3).FOV(i).FOV_Size;

 fovLW(i,1) = eng.ILS_Param.Band(1).FOV(i).CrTrkOffset;
 fovLW(i,2) = eng.ILS_Param.Band(1).FOV(i).InTrkOffset;
 fovMW(i,1) = eng.ILS_Param.Band(2).FOV(i).CrTrkOffset;
 fovMW(i,2) = eng.ILS_Param.Band(2).FOV(i).InTrkOffset;
 fovSW(i,1) = eng.ILS_Param.Band(3).FOV(i).CrTrkOffset;
 fovSW(i,2) = eng.ILS_Param.Band(3).FOV(i).InTrkOffset;
end

dxyLW(1) = eng.ILS_Param.Band(1).FOV5_CrTrkMisalignment;
dxyLW(2) = eng.ILS_Param.Band(1).FOV5_InTrkMisalignment;
dxyMW(1) = eng.ILS_Param.Band(2).FOV5_CrTrkMisalignment;
dxyMW(2) = eng.ILS_Param.Band(2).FOV5_InTrkMisalignment;
dxySW(1) = eng.ILS_Param.Band(3).FOV5_CrTrkMisalignment;
dxySW(2) = eng.ILS_Param.Band(3).FOV5_InTrkMisalignment;

foaxLW1 = sqrt((fovLW(:,1) + dxyLW(1)).^2 + (fovLW(:,2) + dxyLW(2)).^2) / 1e6;
foaxMW1 = sqrt((fovMW(:,1) + dxyMW(1)).^2 + (fovMW(:,2) + dxyMW(2)).^2) / 1e6;
foaxSW1 = sqrt((fovSW(:,1) + dxySW(1)).^2 + (fovSW(:,2) + dxySW(2)).^2) / 1e6;

fradLW = radLW / 2e6;
fradMW = radMW / 2e6;
fradSW = radSW / 2e6;

% x-y shift
[dxyLW, dxyMW, dxySW]
s1LW = [0.96, 1.08];
s1MW = [0.94, 1.06];
s1SW = [0.94, 1.04];
dxyLW = dxyLW .* s1LW;
dxyMW = dxyMW .* s1MW;
dxySW = dxySW .* s1SW;
round([dxyLW, dxyMW, dxySW])

% single FOV shift
s2LW = [0.96, 0.98]; jLW = 3;
s2MW = [1.04, 0.98]; jMW = 6;
s2SW = [0.92, 1.10]; jSW = 7;
fovLW(jLW,:) = fovLW(jLW,:) .* s2LW;
fovMW(jMW,:) = fovMW(jMW,:) .* s2MW;
fovSW(jSW,:) = fovSW(jSW,:) .* s2SW;

foaxLW2 = sqrt((fovLW(:,1) + dxyLW(1)).^2 + (fovLW(:,2) + dxyLW(2)).^2) / 1e6;
foaxMW2 = sqrt((fovMW(:,1) + dxyMW(1)).^2 + (fovMW(:,2) + dxyMW(2)).^2) / 1e6;
foaxSW2 = sqrt((fovSW(:,1) + dxySW(1)).^2 + (fovSW(:,2) + dxySW(2)).^2) / 1e6;

(foaxLW2 - foaxLW1) ./ foaxLW1
(foaxMW2 - foaxMW1) ./ foaxMW1
(foaxSW2 - foaxSW1) ./ foaxSW1

save fp_test4 fradLW fradMW fradSW foaxLW2 foaxMW2 foaxSW2

% % compare eng with v33a
% [foax, frad] = fp_v33a('LW');
% c1 = (foaxLW1 - foax) ./ foax;
% [foax, frad] = fp_v33a('MW');
% c2 = (foaxMW1 - foax) ./ foax;
% [foax, frad] = fp_v33a('SW');
% c3 = (foaxSW1 - foax) ./ foax;
% [c1, c2, c3]

