
% Linear regression plot for NWG vs the market FTSE 100

clear all; 
close all;

NWG = importdata('NWG.L.csv'); % import Natwest Group plc data 
NWG_ACP=NWG.data(:,5); % Extracts column 6 (Adjusted Close Price)

FTSE=importdata('FTSE_Data.csv'); % import FTSE data 
FTSE_ACP = FTSE.data(:,5);  % Extracts column 6 (Adjusted Close Price)

n=2; 

A=[FTSE_ACP,NWG_ACP];

LinR=zeros(length(FTSE_ACP)-1,n); %Linear Return
for i=1:length(FTSE_ACP)-1
for j=1:n
LinR(i,j)=(A(i+1,j)-A(i,j))./A(i,j);
end
end

muR=mean(LinR); % Vector of expected returns for each asset
covR=cov(LinR); % Covariance matrix, for risk and correlation for each asset

mu_m=muR(1,1);
mu_a=muR(1,2);%expected value of asset
var_m=covR(1,1);
var_a=covR(2,2);%variance of asset
sig12=covR(1,2);



beta=sig12/var_m
%beta=sig12/(sqrt(var_a)*sqrt(var_m)); % The correlation coefficient
alpha=mu_a-beta*mu_m % The y (asset return intercept) comparing whether individual performance outperforms the market!
% Positive alpha implies better asset performance compared to the market as predicted
figure(12)
Rm=[-0.04:0.0001:0.04];
Ri=alpha+beta*Rm; % Linear regression plot

plot(Rm,Ri);% NWG return vs market return - plot per working day
hold on
plot(LinR(:,1),LinR(:,2),'bo'); 
xlabel('R_m(t)')
ylabel('R_{a}(t)')
legend('Optimal regression line','(FTSE,NWG) returns per working day')
title('Linear regression plot for NWG vs market')


noise=zeros(length(LinR),1);%Noise coefficients the deviation of the data points from the regression line.
for i=1:length(LinR(:,1))
noise(i)=LinR(i,2)-beta*LinR(i,1)-alpha;
end


sum_of_squared_residuals = sum((noise.^2))
noise



