
F_samp = 50*10^6;            % Sampling frequency                    
T = 1/F_samp;             % Sampling period       
L = 1024;             % Length of signal
t = (0:L-1)*T;        % Time vector

fft_input_sinc3 = out_sinc3(10:L);

%sinc3 fft signal
Y_sinc3 = fft(fft_input_sinc3);
P2_sinc3 = abs(Y_sinc3/L);
P1_sinc3 = P2_sinc3(1:L/2+1);
P1_sinc3(2:end-1) = 2*P1_sinc3(2:end-1);
P1_sinc3(1) = P1_sinc3(2);
P1_sinc3_db = 10*log(P1_sinc3) - max(10*log(P1_sinc3));

f = F_samp*(0:(L/2))/L;
semilogx(f,P1_sinc3_db); 
title('Sinc3 filter');
xlabel('f (MHz)');
ylabel('|P1(f)|(dB)');
grid on;












