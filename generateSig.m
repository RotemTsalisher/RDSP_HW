function [x,y,real_psd] = generateSig(N_signal)

fs = 44100; 
sigma = 1;
mu = 0;
N_ma = N_signal; N_ar = 15*N_signal; N = N_signal*4; portion = N/2;
w_ma = sigma*randn(1,N_ma) + mu;
w_ar = sigma*randn(1,N_ar) + mu;
b_ma = [1, 0.3, 0.8]; b_ar = 1;
a_ma = 1; a_ar = [1, 0.2, 0.6]; 

x = filter(b_ma,a_ma,w_ma);
y = filter(b_ar,a_ar,w_ar); y_ = y(1,N_ar-(N_signal-1):N_ar);
[H_ma ~] = freqz(b_ma,a_ma,N/2,fs);
real_psd = sigma*(abs(H_ma)).^2; real_psd = real_psd';
end