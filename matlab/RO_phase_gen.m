function [phase, vco_freq] = RO_phase_gen(val, Fs_dis, func, phase, L)
    switch length(func)
        case 2
            vco_freq = func(1)*val + func(2);
        case 3
            vco_freq = func(1)*val.^2 + func(2)*val + func(3);
        case 4
            vco_freq = func(1)*val.^3 + func(2)*val.^2 + ... 
                func(3)*val+ func(4);
        case 5
            vco_freq = func(1)*val.^4 + func(2)*val.^3 + ... 
                func(3)*val.^2 + func(4)*val +func(5);
    end
    %Caculate phase of VCO(CT phase)
    delta_phase = vco_freq*(1/Fs_dis);
    for i=1:L
        phase(:, i+1) = phase(:,i)+delta_phase(i);
    end
end