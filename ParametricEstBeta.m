N_signal = 64; N = 256; portion = N/2; wgrid = 2*pi*(0:N-1)/N;
[x,y,real_psd_ma,real_psd_ar] = generateSig(N_signal);
r_y = xcorr(y,"biased"); r_x = xcorr(x,"biased");
% 
% %first order
% [b1,a1] = parametricARModel(r_y,1);
% den1 = abs(fft(a1,N)).^2; num1 = b1;
% est_psd1 = num1./den1;
% figure(1); plot(wgrid(1:portion),est_psd1(1:portion),wgrid(1:portion),real_psd_ar(1:portion), "black--")
% grid on; axis tight; title("Parametric Estimation of P_x(w) for AR(1)"); xlabel("w [rad/sec]"); ylabel("P_x(w)");
% legend("est PSD", "real PSD");
% 
% %second order
% [b2,a2] = parametricARModel(r_y,2); 
% den2 = abs(fft(a2,N)).^2; num2 = b2;
% est_psd2 = num2./den2;
% figure(2); plot(wgrid(1:portion),est_psd2(1:portion),wgrid(1:portion),real_psd_ar(1:portion), "black--")
% grid on; axis tight; title("Parametric Estimation of P_x(w) for AR(2)"); xlabel("w [rad/sec]"); ylabel("P_x(w)");
% legend("est PSD", "real PSD");
% 

% first order ma

func = @(r,n,k) sum(r(N_signal -k:N_signal +k)'.*exp(-j*((2 * pi)*[-k:k]'*n)/256),1);
est_psd_ma1 = func(r_x,[0:255],1);
figure(); plot(est_psd_ma1);

% second order ma
est_psd_ma2 = func(r_x,[0:255],2);
figure(); plot(abs(est_psd_ma2));