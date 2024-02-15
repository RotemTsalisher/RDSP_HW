clear;

% main function for HW04
% all function implementations are added in .zip file
% full code for all functions is added in a .doc file

N_signal = 64;
[x,y_,real_psd_ma,real_psd_ar] = generateSig(N_signal);
estimatePSD(N_signal,x,real_psd_ma);
myWelch(x,N_signal,16,8,real_psd_ma);
ParametricEstBeta(N_signal,x,real_psd_ma, "MA");
estimatePSD(N_signal,y_,real_psd_ar);
myWelch(y_,N_signal,16,8,real_psd_ar);
ParametricEstBeta(N_signal,y_,real_psd_ar, "AR");

N_signal = 1024;
[x,y_,real_psd_ma,real_psd_ar] = generateSig(N_signal);
estimatePSD(N_signal,x,real_psd_ma);
myWelch(x,N_signal,16,8,real_psd_ma);
ParametricEstBeta(N_signal,x,real_psd_ma, "MA");
estimatePSD(N_signal,y_,real_psd_ar);
myWelch(y_,N_signal,16,8,real_psd_ar);
ParametricEstBeta(N_signal,y_,real_psd_ar, "MA");

