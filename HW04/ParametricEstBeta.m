function parametricEstBeta(N_signal,x,real_psd,modelType)
    N = N_signal*4; portion = N/2; wgrid = 2*pi*(0:N-1)/N;
    r_x = xcorr(x,"biased");
    
    %first order AR
    [b1,a1] = parametricARModel(r_x,1);
    den1 = abs(fft(a1,N)).^2; num1 = b1;
    est_psd1 = num1./den1;
    figure(); plot(wgrid(1:portion),est_psd1(1:portion),wgrid(1:portion),real_psd(1:portion), "black--")
    grid on; axis tight; title("Parametric Estimation of P_x(w) for AR(1) Model", ["Real psd is for " + modelType + " Model","N_s_i_g_n_a_l = " + num2str(N_signal)]); xlabel("w [rad/sec]"); ylabel("P_x(w)");
    legend("est PSD", "real PSD");
    
    %second order AR
    [b2,a2] = parametricARModel(r_x,2); 
    den2 = abs(fft(a2,N)).^2; num2 = b2;
    est_psd2 = num2./den2;
    figure(); plot(wgrid(1:portion),est_psd2(1:portion),wgrid(1:portion),real_psd(1:portion), "black--")
    grid on; axis tight; title("Parametric Estimation of P_x(w) for AR(2) Model",["Real psd is for " + modelType + " Model","N_s_i_g_n_a_l = " + num2str(N_signal)]); xlabel("w [rad/sec]"); ylabel("P_x(w)");
    legend("est PSD", "real PSD");
    
    % first order ma
    func = @(r,n,k) sum(r(N_signal -k:N_signal +k)'.*exp(-j*((2 * pi)*[-k:k]'*n)/N),1);
    est_psd_ma1 = abs(func(r_x,[0:N],1));
    figure(); plot(wgrid(1:portion),est_psd_ma1(1:portion),wgrid(1:portion),real_psd(1:portion),"black--");
    grid on; axis tight; title("Parametric Estimation of P_x(w) for MA(1) Model",["Real psd is for " + modelType + " Model", "N_s_i_g_n_a_l = " + num2str(N_signal)]); xlabel("w [rad/sec]"); ylabel("P_x(w)");
    legend("est PSD", "real PSD");
    
    % second order ma
    est_psd_ma2 = abs(func(r_x,[0:N],2));
    figure(); plot(wgrid(1:portion),est_psd_ma2(1:portion),wgrid(1:portion),real_psd(1:portion),"black--");
    grid on; axis tight; title("Parametric Estimation of P_x(w) for MA(2) Model",["Real psd is for " + modelType + " Model" , "N_s_i_g_n_a_l = " + num2str(N_signal)]); xlabel("w [rad/sec]"); ylabel("P_x(w)");
    legend("est PSD", "real PSD");
end