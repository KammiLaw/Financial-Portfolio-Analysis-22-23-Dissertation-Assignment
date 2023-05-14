clear all 
close all

NWG = importdata('NWG.L.csv'); % import Natwest Group plc data 


NWG_ACP=NWG.data(:,5); % Extracts column 6 (Adjusted Close Price) 

figure(3) % Plotting Daily share prices (Adjusted Close Price) 

plot(NWG_ACP)
xlabel('time')
ylabel('Adjusted Close Price')
ret=diff(NWG_ACP)./NWG_ACP(1:end-1);  % Linear return equation 


figure(4) % Plotting daily returns (linear return)
plot(ret)
xlabel('time (days)')
ylabel('Linear Returns')


mu=mean(ret) % sample mean 
Variance= var(ret) % variance 
STDEV=sqrt(Variance) % Standard deviation of the Natwest Group PLC
