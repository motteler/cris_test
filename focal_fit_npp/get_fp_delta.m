
% get reference focal plane for deltas
d2 = load('npp_eng_v39');
fp1 = fp_from_eng(d2.eng);

fp2 = fp1;
for b = 1 : 3
  fp2(b).foax = fp1(b).foax * 1.05;
end

