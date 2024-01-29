clc;clear;clf;
N = [2,5,10,50,100];
M = 1000;
mu = 10;

r1 = poissrnd(mu,N(1),M);
r2 = poissrnd(mu,N(2),M);
r3 = poissrnd(mu,N(3),M);
r4 = poissrnd(mu,N(4),M);
r5 = poissrnd(mu,N(5),M);

mu_spike = [mean(r1);mean(r2);mean(r3);mean(r4);mean(r5)];
mu_axon = [mean([r1-mu_spike(1,:)].^2);mean([r2-mu_spike(2,:)].^2);mean([r3-mu_spike(3,:)].^2);mean([r4-mu_spike(4,:)].^2);mean([r5-mu_spike(5,:)].^2);];
mu_axon_fixed = [(N(1)/(N(1)-1)).*mu_axon(1,:);(N(2)/(N(2)-1))*mu_axon(2,:);(N(3)/(N(3)-1))*mu_axon(3,:);(N(4)/(N(4)-1))*mu_axon(4,:);(N(5)/(N(5)-1))*mu_axon(5,:)];

E_mu_spike = mean(mu_spike');
E_mu_axon = mean(mu_axon');
E_mu_axon_fixed = mean(mu_axon_fixed');

figure(1); plot([1:1000],mu_axon_fixed(1,:),[1:1000],mu_axon(1,:),[1:1000],mu_spike(1,:)); title("N = 2"); grid on; % N = 2
ylabel("Estimated {\mu}"); xlabel("Amount of Itterations through random function"); yline(mu,'b--');
legend("{\mu} axon fixed","{\mu} axon","{\mu} spike");
figure(2); plot([1:1000],mu_axon_fixed(2,:),[1:1000],mu_axon(2,:),[1:1000],mu_spike(2,:)); title("N = 5"); grid on; % N = 5
ylabel("Estimated {\mu}"); xlabel("Amount of Itterations through random function"); yline(mu,"b--")
legend("{\mu} axon fixed","{\mu} axon","{\mu} spike");
figure(3); plot([1:1000],mu_axon_fixed(3,:),[1:1000],mu_axon(3,:),[1:1000],mu_spike(3,:)); title("N = 10"); grid on; % N = 10
ylabel("Estimated {\mu}"); xlabel("Amount of Itterations through random function"); yline(mu,"b--")
legend("{\mu} axon fixed","{\mu} axon","{\mu} spike");
figure(4); plot([1:1000],mu_axon_fixed(4,:),[1:1000],mu_axon(4,:),[1:1000],mu_spike(4,:)); title("N = 50"); grid on; % N = 50
ylabel("Estimated {\mu}"); xlabel("Amount of Itterations through random function"); yline(mu,"b--")
legend("{\mu} axon fixed","{\mu} axon","{\mu} spike");
figure(5); plot([1:1000],mu_axon_fixed(5,:),[1:1000],mu_axon(5,:),[1:1000],mu_spike(5,:)); title("N = 100"); grid on; % N = 100
ylabel("Estimated {\mu}"); xlabel("Amount of Itterations through random function"); yline(mu,"b--")
legend("{\mu} axon fixed","{\mu} axon","{\mu} spike");

figure(6); 

subplot(311); stem(N,E_mu_spike); grid on;
title("E({\mu}_s_p_i_k_e)"); xlabel("N"); ylabel("E({\mu})"); xticks([ 2 5 10 50 100]); xticklabels({'N = 2','N = 5','N = 10', 'N = 50', 'N = 100'});
subplot(312); stem(N,E_mu_axon); grid on;
title("E({\mu}_a_x_o_n)"); xlabel("N"); ylabel("E({\mu})"); xticks([ 2 5 10 50 100]); xticklabels({'N = 2','N = 5','N = 10', 'N = 50', 'N = 100'});
subplot(313); stem(N,E_mu_axon_fixed); grid on;
title("E({\mu}_a_x_o_n _f_i_x_e_d)"); xlabel("N"); ylabel("E({\mu})"); xticks([ 2 5 10 50 100]); xticklabels({'N = 2','N = 5','N = 10', 'N = 50', 'N = 100'});

B_mu_spike = mu - E_mu_spike;
B_mu_axon = mu - E_mu_axon;
B_mu_axon_fixed = mu - E_mu_axon_fixed;

var_mu_spike = var(mu_spike');
var_mu_axon = var(mu_axon');
var_mu_axon_fixed = var(mu_axon_fixed');

mse_spike_vec = []; mse_axon_vec = []; mse_axon_fixed_vec = [];
for i = [1:5]
    mse_spike_vec = [mse_spike_vec, immse(E_mu_spike(1,i),mu)];
    mse_axon_vec = [mse_axon_vec, immse(E_mu_axon(1,i),mu)];
    mse_axon_fixed_vec = [mse_axon_fixed_vec, immse(E_mu_axon_fixed(1,i),mu)];
end

figure(7); clf(7);  

hold on; stem(N,B_mu_spike); stem(N,B_mu_axon); stem(N,B_mu_axon_fixed); grid on;
xlabel("N"); ylabel("B({\mu})"); xticks([ 2 5 10 50 100]); xticklabels({'N = 2','N = 5','N = 10', 'N = 50', 'N = 100'});
legend("{\mu} - E({\mu}_s_p_i_k_e)","{\mu} - E({\mu}_a_x_o_n)","{\mu} - E({\mu}_a_x_o_n _f_i_x_e_d)");
title("Bias for all Estimations"); hold off;

figure(8); clf(8);
hold on; stem(N,var_mu_spike); stem(N,var_mu_axon); stem(N,var_mu_axon_fixed); grid on;
xlabel("N"); ylabel("Var({\mu})"); xticks([ 2 5 10 50 100]); xticklabels({'N = 2','N = 5','N = 10', 'N = 50', 'N = 100'});
legend("Var({\mu}_s_p_i_k_e)","Var({\mu}_a_x_o_n)","Var({\mu}_a_x_o_n _f_i_x_e_d)");
title("Variance for all Estimations"); hold off;

figure(9); clf(9)
hold on; stem(N,mse_spike_vec); stem(N,mse_axon_vec); stem(N,mse_axon_fixed_vec); grid on;
xlabel("N"); ylabel("MSE({\mu})"); xticks([ 2 5 10 50 100]); xticklabels({'N = 2','N = 5','N = 10', 'N = 50', 'N = 100'});
legend("MSE({\mu}_s_p_i_k_e)","MSE({\mu}_a_x_o_n)","MSE({\mu}_a_x_o_n _f_i_x_e_d)");
title("MSE for all Estimations"); hold off;
mse_spike_vec
mse_axon_fixed_vec