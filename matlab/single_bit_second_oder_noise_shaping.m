close all;
%clear all;

%% ----------------- Overall system ----------------
trans_time = 5e-6;     %100ns         %transient time of simulation
Fs = 48000*512;                          %Over sampling frequency of ADC
t_s = 0:(1/Fs):(trans_time);            %discrete time
div = 100;                                %time division
Fs_dis = Fs*div;                         %sample rate for display
t = 0:(1/Fs_dis):trans_time;            %display continious time range of sumlation
ovs = 512;                                %over sampling gap

%%  -----------------Input signal Block--------------
%set up spectrum of input signal
f1 = 4*10^3;      %Hz
V_ip = 0.5*cos(2*pi*f1*t)+0.1;
V_in =-0.5*cos(2*pi*f1*t)+0.1;
%V_in = in_sig_gen(t);      %input signal genarator random signals

%% --- Init VCO, DCO phase, voltage, ... -----------
nop = 1;        % number of phases (nop)
init_val = zeros(nop,1);    % Create init value by zeros matrix
i = 1:1:nop;    
phase_init(i) = 0:-1/nop:-(nop-1)/nop;  % Initiate phase value of $nop phases;
if (nop>3)
    i = 2:2:nop-1;
    phase_init(i) = phase_init(i)-1;
    % initiate phase value of even phases;
end
% init phase values
phase_init = phase_init + 2;    % Phase_init + 2*pi (make all phase value greater than 0)
phase_v1 = phase_init;          % Initate phase_v1 (phases of VCO1)
phase_d2 = phase_init;          % Initate phase_v1 (phases of DCO2)
% init counter values
counter1 = zeros(nop,div+1);
counter2 = zeros(nop,div+1);
% initate quantizer(qtz) values
qtz = zeros(nop,1);
% initate idac
V_bs2 = 1.0;
V_os2 = 0.1;
%% Second order noise shapping

for i = 1:length(t_s)-1
    t_i = (i-1)*div+1:i*div+1;      % time between two loops
    
    % generate phase values of VCO_1
    [phase_v1(:,t_i), freq_v1(t_i)] = RO_phase_gen(V_ip(t_i), Fs_dis, K_VCO_w6, phase_v1(:, t_i(1)), div);
    
    % reduce phase _v1 from 0 to 2pi radian
    phase_v1(:,t_i) = mod(phase_v1(:,t_i), 2);
    
    % get rise pulse time (rpt) of phase_v1 signal
    [rpt, ~] = find((fix(mod(phase_v1(:,t_i(2:end)), 2)).*~fix(mod(phase_v1(:,t_i(1:(end-1))), 2)))==1);
    
    % initate counter1 in new clock cycle
    if(i>1)
        if (qtz(:, i-1)==1)
            counter1(:,t_i) = 0;
        else
            counter1(:,t_i) = counter1(:, t_i(1)-1);
        end
    end
    % up down counter hold high value of phase_v1 signal
    counter1(:,t_i(rpt+1:end)) = 1;
    
    % caculate voltage supply for DCO_2
    V_dco2(t_i) = counter1(:,t_i)*V_bs2 + V_os2;
    
    % generate phase value of DCO_2
    [phase_d2(:,t_i), freq_d2(:,t_i)] = RO_phase_gen(V_dco2(t_i), Fs_dis, K_VCO_w6, phase_d2(:, t_i(1)), div);
    
    % get rise pulse time (rpt) of phase_d2 signal
    [rpt, ~] = find((fix(mod(phase_d2(:,t_i(2:end)), 2)).*~fix(mod(phase_d2(:,t_i(1:end-1)), 2)))==1);
    
    % initate counter2 in new clock cycle
    counter2(:,t_i) = 0;
    
    % up down counter hold high value of phase_d2 signal
    counter2(:,rpt+1:end) = 1;
    
    % phase_d2 quantization (qtz)
    qtz(:, i) = counter2(:,t_i(end));
end


%% Decimation filter
% adder tree return sum of all sampled phases
adder_tree_out = qtz;
% excute 3rd order sinc filter 
[out_sinc3, out_integ_3] = decimation(adder_tree_out, Fs, t_s(1:end-1), ovs);

%% Plot result
subplot (4, 1, 1);
plot (fix(mod(phase_v1, 2)));
subplot (4, 1, 2);
plot (counter1);
subplot (4, 1, 3);
plot (fix(mod(phase_d2, 2)));
subplot (4, 1, 4);
plot (counter2);


grid on;
%figure(2)
%scatter(out_integ_3);
