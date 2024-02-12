function estimatePSD(N_signal,x,real_psd)
fs = 44100;
N_ma = N_signal; N_ar = 15*N_signal; N = N_signal*4; portion = N/2;

% first method: PSD = (1/N)*|X(jw)|^2
X1 = fft(x,N); psd2 = (1/N)*abs(X1).^2;
% second method: PSD = fourier transform of the autocorrelation (with
% xcorr)
r_hat = xcorr(x,"normalized"); psd3 = abs(fft(r_hat,N));
% third method: PSD = fourier transform of the autocorrelation (manually calculated):

r_man = zeros(1,N_ma);
for k = [1:N_ma]
    for n = [1:N_ma-k]
        r_man(k) = r_man(k) + x(n+k)*conj(x(n));
    end
    r_man(k) = (1/r_man(1))*r_man(k);
end
r_man_ = [r_man(1,[N_ma:-1:2]), r_man];
psd1 = (1/N)*abs(fft(r_man_,N));

fgrid = fs*(0:N-1)/N; wgrid = 2*pi*(0:N-1)/N;
figure(); plot(wgrid(1:portion),psd1(1:portion),wgrid(1:portion),real_psd,"black--"); % for loop computation
title("P_p_e_r_i_o_d_o_g_r_a_m = FFT on Manualy Computed r(k)"); ylabel("estimated P_1_,_x(f)"); axis tight; grid on;
figure(); plot(wgrid(1:portion),psd2(1:portion),wgrid(1:portion),real_psd,"black--"); % fft squared
title("P_p_e_r_i_o_d_o_g_r_a_m = (1/N)|X(f)|^2"); ylabel("estimated P_2_,_x(f)"); axis tight; grid on;
figure(); plot(wgrid(1:portion),psd3(1:portion),wgrid(1:portion),real_psd,"black--"); % xcorr computation
title("P_p_e_r_i_o_d_o_g_r_a_m = FFT on xcorr(x,x) output"); ylabel("estimated P_3_,_x(f)"); axis tight; grid on;


end