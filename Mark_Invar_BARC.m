

clear all; close all;

BARC= importdata('BARC.L.csv'); % import Barclays plc data 
BARC_ACP=BARC.data(:,5); % Extracts column 6 (Adjusted Close Price) 

num_tradedays=size(BARC_ACP);

%Linear returns
LinR=zeros(length(BARC_ACP),1);
for i=1:length(BARC_ACP)-1
        LinR(i,1)=BARC_ACP(i+1)/BARC_ACP(i)-1;
end

% Test one: Histogram 
figure(24)
histogram(LinR(1:126,1),8)
title('Histogram for linear return frequence for periods 1 and 2 of year')
xlabel('Linear returns')
ylabel('Frequency')
hold on
% Second plot for second half of year.
histogram(LinR(127:end,1),8)
legend('first half','second half')

% Test two: Scatter 
figure(25)
scatter(LinR(1:end-1,1),LinR(2:end,1),'go')
title('Scatter-plot with lags')
xlabel('R_t')
ylabel('R_{t-1}')% Plots the returns for one trading day with the return for the previous trading day

