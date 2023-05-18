% Linear regression plot for HSBA vs the market FTSE 100

clear all; 
close all;

HSBA= importdata('HSBA.L.csv'); % import HSBC Holding plc data 
HSBA_ACP=HSBA.data(:,5); % Extracts column 6 (Adjusted Close Price) 

FTSE=importdata('FTSE_Data.csv'); % import FTSE data 
FTSE_ACP = FTSE.data(:,5);  % Extracts column 6 (Adjusted Close Price)

n=2; 

A=[FTSE_ACP,HSBA_ACP];

RET=zeros(length(FTSE_ACP)-1,n);
for i=1:length(FTSE_ACP)-1
for j=1:n
RET(i,j)=(A(i+1,j)-A(i,j))./A(i,j);
end
end

muR=mean(RET); % Vector of expected returns for each asset
covR=cov(RET); % Covariance matrix, for risk and correlation for each asset

mu_m=muR(1,1);
mu_a=muR(1,2);%expected value of asset
var_m=covR(1,1);
var_a=covR(2,2);%variance of asset
sig12=covR(1,2);



beta=sig12/var_m  %A beta greater than 1 means that the stock is more volatile than the market, 
% and will tend to move up or down more than the market. It indicates a higher degree of risk, 
% but also the potential for higher returns
%beta=sig12/(sqrt(var_a)*sqrt(var_m)); % The correlation coefficient
alpha=mu_a-beta*mu_m % The y (asset return intercept) comparing whether individual performance outperforms the market!
% Positive alpha implies better asset performance compared to the market as predicted
figure(14)
Rm=[-0.04:0.0001:0.04];
Ri=alpha+beta*Rm; % Linear regression plot

plot(Rm,Ri);% HSBA return vs market return - plot per working day
hold on
plot(RET(:,1),RET(:,2),'co'); 
xlabel('R_m(t)')
ylabel('R_{a}(t)')
legend('Optimal regression line','(FTSE,HSBA) returns per working day')
title('Linear regression plot for HSBA vs market')


noise=zeros(length(RET),1);%Noise coefficients the deviation of the data points from the regression line.
for i=1:length(RET(:,1))
noise(i)=RET(i,2)-beta*RET(i,1)-alpha;
end

sum_of_squared_residuals = sum((noise.^2))
noise


