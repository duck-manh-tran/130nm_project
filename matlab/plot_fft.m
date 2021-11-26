function plot_fft(fft_input, F_samp, fft_window_length)
                   
T = 1/F_samp;             % Sampling period       
L = fft_window_length;    % Length of signal
t = (0:L-1)*T;            % Time vector
W_blackman = blackmanharris(L).';
fft_input_window = fft_input(10:L+9).*W_blackman;
Y_adc = fft(fft_input_window);
P2_adc = abs(Y_adc/L);
P1_adc = P2_adc(1:L/2+1);
P1_adc(2:end-1) = 2*P1_adc(2:end-1);
P1_adc(1) = P1_adc(2);
P1_adc_db = 10*log(P1_adc) - max(10*log(P1_adc));

f = F_samp*(0:(L/2))/L;
semilogx(f, P1_adc_db); 
title('Spectrum of ADC ouput');
xlabel('Frequency (MHz)');
ylabel('|P1(f)|(dB)');
grid on;

end