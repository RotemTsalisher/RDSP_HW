clear;

N_signal = 64;
[x,y_,real_psd] = generateSig(N_signal)
estimatePSD(N_signal,x,y_,real_psd)
myWelch(x,y_,N_signal,16,8,real_psd);

N_signal = 1024;
[x,y_,real_psd] = generateSig(N_signal)
estimatePSD(N_signal,x,y_,real_psd)
myWelch(x,y_,N_signal,16,8,real_psd);

