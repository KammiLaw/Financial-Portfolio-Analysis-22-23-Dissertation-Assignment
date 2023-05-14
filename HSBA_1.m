clear all 
close all

HSBA= importdata('HSBA.L.csv'); % import HSBC Holding plc data 


HSBA_ACP=HSBA.data(:,5); % Extracts column 6 (Adjusted Close Price) 

figure(7) % Plotting Daily share prices (Adjusted Close Price) 

plot(HSBA_ACP)
xlabel('time')
ylabel('Adjusted Close Price')
ret=diff(HSBA_ACP)./HSBA_ACP(1:end-1);  % Linear return equation 


figure(8) % Plotting daily returns (linear return)
plot(ret)
xlabel('time (days)')
ylabel('Linear Returns')



mu=mean(ret) % sample mean 
Variance= var(ret) % variance 
STDEV=sqrt(Variance) % Standard deviation of the HSBC Holding plc


