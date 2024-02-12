function myWelch(x,N_signal,L,D,real_psd)
    fs = 44100; N = 4*N_signal; wgrid = 2*pi*(0:N-1)/N; portion = N/2; Nfft = 4*N_signal;
    K = (N_signal-L)/D + 1;
    xMat = [];
    for i = [0:K-1]
         if(i*D + L <= N_signal)
             xMat = [xMat; x(1,i*D + 1:i*D + L)];
         else
             xMat = [xMat; x(1,i*D + 1:N_signal)];
         end
         
    end % splitting of signal
    xMat_fft = (1/L)*abs(fft(xMat,Nfft,2)).^2; % modified periodogram for each row
    welchPsd = mean(xMat_fft,1); % welch -> avg of all periodograms
    figure(); plot(wgrid(1:portion),welchPsd(1:portion),wgrid(1:portion),real_psd,"black--");
    title("Welch Estimation of P_x(e^j^w)"); xlabel("w [rad/sec]");
    ylabel("P_w_e_l_c_h_,_x(e^j^w)"); grid on; axis tight;
end