%{
close all;
% set upper bound and lower bound of signal iterior
ub=46;    lb=1;
n_order=4;
% excute function K_VCO finding and find accurancy(acc) of K_VCO
[K_VCO, freq_cal, acc] = vco_calib(n_order, VCO.Vin, VCO.freq, ub, lb);
% Check accuracy of KVCO
figure (1);
subplot ( 1, 2, 1);
hold on; grid on;
scatter (VCO.Vin, VCO.freq);
plot (VCO.Vin, freq_cal);
subplot ( 1, 2, 2);
plot (VCO.Vin(lb:ub), acc(lb:ub));

% set upper bound and lower bound of signal iterior
    ub = 46;    lb = 1;
% excute function K_VCO finding and find accurancy(acc) of K_VCO
[K_VCO_r100, freq_cal, acc] = vco_calib(n_order, VCO_r100.Vin, VCO.freq, ub, lb);
% Check linearity of VCO and accuracy of KVCO
figure (2);
subplot ( 1, 2, 1);
hold on; grid on;
scatter (VCO_r100.Vin, VCO_r100.freq);
plot (VCO_r100.Vin, freq_cal);
subplot ( 1, 2, 2);
plot (VCO_r100.Vin(lb:ub), acc(lb:ub));
%}
%%
K_VCO_w6 = [];
n_order = 4;
% set upper bound and lower bound of signal iterior
ub = 46;    lb = 1;
% excute function K_VCO finding and find accurancy(acc) of K_VCO
[K_VCO_w6, freq_cal, acc] = vco_calib (n_order, VCO_w6.Vin, VCO_w6.freq, ub, lb);
% Check linearity of VCO and accuracy of KVCO
figure (1);
subplot ( 1, 2, 1);
scatter (VCO_w6.Vin, VCO_w6.freq);
plot (VCO_w6.Vin(lb:ub), freq_cal(lb:ub));
subplot ( 1, 2, 2);
plot (VCO_w6.Vin(lb:ub), acc(lb:ub));

function [kvco, y, diff_freq] = vco_calib(n_order, vol, freq, ub, lb)
    kvco = polyfit(vol(lb:ub), freq(lb:ub), n_order);
    x = vol;
    switch n_order
        case 1
            y = kvco(1)*x + kvco(2);
        case 2    
            y = kvco(1)*x.^2 + kvco(2)*x + kvco(3);
        case 3
            y = kvco(1)*x.^3 + kvco(2)*x.^2 + kvco(3)*x + kvco(4);
        case 4
            y = kvco(1)*x.^4 + kvco(2)*x.^3 + kvco(3)*x.^2 + kvco(4)*x + kvco(5);
        case 5
            y = kvco(1)*x.^5 + kvco(2)*x.^4 + kvco(3)*x.^3 + kvco(4)*x.^2 + kvco(5)*x + kvco(6);
    end
diff_freq =  y - freq;
end