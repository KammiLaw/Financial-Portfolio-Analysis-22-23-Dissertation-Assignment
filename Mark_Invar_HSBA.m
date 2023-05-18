clear all; close all;

HSBA= importdata('HSBA.L.csv'); % import HSBC Holding plc data 
HSBA_ACP=HSBA.data(:,5); % Extracts column 6 (Adjusted Close Price) 

num_tradedays=size(HSBA_ACP);

%Linear returns
LinR=zeros(length(HSBA_ACP),1);
for i=1:length(HSBA_ACP)-1
        LinR(i,1)=HSBA_ACP(i+1)/HSBA_ACP(i)-1;
end
 

% Test one
figure(22)
histogram(LinR(1:126,1),8)
title('Histogram for linear return frequence for periods 1 and 2 of year')
xlabel('Linear returns')
ylabel('Frequency')
hold on
% Second plot for second half of year.
histogram(LinR(127:end,1),8)
legend('first half','second half')

% Test two
figure(23)
scatter(LinR(1:end-1,1),LinR(2:end,1),'co')
title('Scatter-plot with lags')
xlabel('R_t')
ylabel('R_{t-1}')% Plots the returns for one trading day with the return for the previous trading day

