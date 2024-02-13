N_signal = 64; N = 256; portion = N/2; wgrid = 2*pi*(0:N-1)/N;
[x,y,real_psd_ma,real_psd_ar] = generateSig(N_signal);
r_y = xcorr(y,"biased");

%first order
a1 = -(r_y(N_signal+1)/r_y(N_signal)); % r(0)*a1 = -r(1)
num1 = r_y(N_signal) + a1*r_y(N_signal+1); %|b(0)|^2

a0 = 1; a = [a0 a1];
den1 = abs(fft(a,N)).^2;
est_psd1 = num1./den1;
figure(1); plot(wgrid(1:portion),est_psd1(1:portion),wgrid(1:portion),real_psd_ar(1:portion), "black--")
grid on; axis tight; title("Parametric Estimation of P_x(w) for AR(1)"); xlabel("w [rad/sec]"); ylabel("P_x(w)");
legend("est PSD", "real PSD");
%second order
% r(N_signal)*a1 + r(N_signal+1)*a2 = -r(1);
% r(N_signal+1)*a1 + r(N_signal)*a2 = -r(2);

% % B*s = v => s = B^-1*v;
v1 = [r_y(N_signal), r_y(N_signal+1)]; v2 = [v1(end:-1:1)];
B = [v1;v2]; v = [-r_y(N_signal + 1), -r_y(N_signal + 2)];
s = inv(B)*v';
num2 = r_y(N_signal) + s(1)*r_y(N_signal + 1) + s(2)*r_y(N_signal+2)

a_ = [1, s(1), s(2)]
den2 = abs(fft(a_,N)).^2;
parametricARModel(r_y,2)
est_psd2 = num2./den2;
figure(2); plot(wgrid(1:portion),est_psd2(1:portion),wgrid(1:portion),real_psd_ar(1:portion), "black--")
title("Parametric Estimation of P_x(w) for AR(1)");
grid on; axis tight; title("Parametric Estimation of P_x(w) for AR(1)"); xlabel("w [rad/sec]"); ylabel("P_x(w)");
legend("est PSD", "real PSD");