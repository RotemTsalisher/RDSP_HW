clear;

N_signal = 64;
[x,y_,real_psd_ma,real_psd_ar] = generateSig(N_signal);
estimatePSD(N_signal,x,real_psd_ma);
myWelch(x,N_signal,16,8,real_psd_ma);
estimatePSD(N_signal,y_,real_psd_ar);
myWelch(y_,N_signal,16,8,real_psd_ar);

N_signal = 1024;
[x,y_,real_psd_ma,real_psd_ar] = generateSig(N_signal);
estimatePSD(N_signal,x,real_psd_ma);
myWelch(x,N_signal,16,8,real_psd_ma);
estimatePSD(N_signal,y_,real_psd_ar);
myWelch(y_,N_signal,16,8,real_psd_ar);

