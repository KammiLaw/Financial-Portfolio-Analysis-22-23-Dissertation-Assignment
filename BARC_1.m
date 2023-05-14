clear all 
close all

BARC= importdata('BARC.L.csv'); % import Barclays plc data 


BARC_ACP=BARC.data(:,5); % Extracts column 6 (Adjusted Close Price) 

figure(9) % Plotting Daily share prices (Adjusted Close Price) 

plot(BARC_ACP)
xlabel('time')
ylabel('Adjusted Close Price')
ret=diff(BARC_ACP)./BARC_ACP(1:end-1);  % Linear return equation 


figure(10) % Plotting daily returns (linear return)
plot(ret)
xlabel('time (days)')
ylabel('Linear Returns')



mu=mean(ret) % sample mean 
Variance= var(ret) % variance 
STDEV=sqrt(Variance) % Standard deviation of the Barclays plc
