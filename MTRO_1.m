clear all 
close all

MTRO = importdata('MTRO.L.csv'); % import Metro Bank PLC data 


MTRO_ACP=MTRO.data(:,5); % Extracts column 6 (Adjusted Close Price) 

figure(5) % Plotting Daily share prices (Adjusted Close Price) 

plot(MTRO_ACP)
xlabel('time')
ylabel('Adjusted Close Price')
ret=diff(MTRO_ACP)./MTRO_ACP(1:end-1);  % Linear return equation 


figure(6) % Plotting daily returns (linear return)
plot(ret)
xlabel('time (days)')
ylabel('Linear Returns')


mu=mean(ret) % sample mean 
Variance= var(ret) % variance 
STDEV=sqrt(Variance) % Standard deviation of the LMetro Bank plc
