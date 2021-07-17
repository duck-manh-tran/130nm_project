function [phase, vco_freq] = RO_phase_gen(val, Fs_dis, func, phase, L)
    vco_freq = func(1)*val.^4 + func(2)*val.^3 + ... 
                func(3)*val.^2 + func(4)*val +func(5);

    %Caculate phase of VCO(CT phase)
    delta_phase = vco_freq*(1/Fs_dis);
    for i=1:L
        phase(:, i+1) = phase(:,i)+delta_phase(i);
    end
end