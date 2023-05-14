clear all 
close all 


STAN = importdata('STAN.L.csv'); % import Standard Chartered PLC data 


STAN_ACP=STAN.data(:,5); % Extracts column 6 (Adjusted Close Price) 

figure(1) % Plotting Daily share prices (Adjusted Close Price) 

plot(STAN_ACP)
xlabel('time')
ylabel('Adjusted Close Price')
ret=diff(STAN_ACP)./STAN_ACP(1:end-1);  % Linear return equation 


figure(2) % Plotting daily returns (linear return)
plot(ret)
xlabel('time (days)')
ylabel('Linear Returns')


mu=mean(ret) % sample mean 
Variance= var(ret) % variance 
STDEV=sqrt(Variance) % Standard deviation of the linear return of Standard Chartered PLC



