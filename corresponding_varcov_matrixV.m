
%Compute the corresponding variance-covariance matrix V for the returns

clear all
close all

STAN = importdata('STAN.L.csv'); % import Standard Chartered PLC data 
STAN_ACP=STAN.data(:,5); % Extracts column 6 (Adjusted Close Price) 

NWG = importdata('NWG.L.csv'); % import Natwest Group plc data 
NWG_ACP=NWG.data(:,5); % Extracts column 6 (Adjusted Close Price) 

MTRO = importdata('MTRO.L.csv'); % import Metro Bank PLC data 
MTRO_ACP=MTRO.data(:,5); % Extracts column 6 (Adjusted Close Price) 

HSBA = importdata('HSBA.L.csv'); % import HSBC Holding plc data 
HSBA_ACP=HSBA.data(:,5); % Extracts column 6 (Adjusted Close Price) 

BARC = importdata('BARC.L.csv'); % import Barclays plc data 
BARC_ACP=BARC.data(:,5); % Extracts column 6 (Adjusted Close Price)


n=5; %number of assets considered


V=[STAN_ACP,NWG_ACP,MTRO_ACP,HSBA_ACP,BARC_ACP];

LinR=zeros(length(STAN_ACP)-1,n);

for i=1:length(STAN_ACP)-1
for j=1:n
LinR(i,j)=(V(i+1,j)-V(i,j))./V(i,j);
end
end

muR=mean(LinR);  % Vector of expected returns for all assets 
covR=cov(LinR) % Covariance matrix, for risk and correlation of all assets
