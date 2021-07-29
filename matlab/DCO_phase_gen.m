function [phase, vco_freq] = DCO_phase_gen(V_in, Fs_dis, p1, p2, phase, L)
R1 =50;
R2 =50; 
k1 = 1/(1/R1 + 1/R2);
k2 = k1/R1;

%caculate v_crt
y = V_in;
%fft_input_ideal = V_in_sample(10:2057); 
v_crt = -(k1*p1(2) - (k1^2*p1(2)^2 - 4*p1(1)*p1(3)*k1^2 + 2*k1*p1(2) + ...
    4*k2*p1(1)*y*k1 + 1).^(1/2) + 1)/(2*k1*p1(1));      

%caculate freq of VCO (five order)
x = v_crt;
vco_freq = p2(1)*x.^5 + p2(2)*x.^4 + p2(3)*x.^3 + p2(4)*x.^2 + p2(5)*x + p2(6);


%Caculate phase of VCO(CT phase)
delta_phase = vco_freq*(1/Fs_dis);
for i=1:L
    phase(:, i+1) = phase(:,i)+delta_phase(i);
end
end 