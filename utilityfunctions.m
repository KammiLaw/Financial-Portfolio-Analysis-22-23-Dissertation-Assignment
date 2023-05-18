%use utility functions u(µ, σ) = µ−ασ2 and u(µ, σ) = µ/σ2 to select the ‘optimal’ portfolio

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

mu_annual=mean(LinR) % Vector of expected returns for all assets 
cov_annual=cov(LinR) % Covariance matrix, for risk and correlation of all assets
Var_annual= var(LinR)

% Annualization
mu_annual = mu_annual * 252
cov_annual = cov_annual * 252
Var_annual= Var_annual *252

Vinv=inv(cov_annual);
A=[mu_annual; ones(n,1)']*Vinv*[mu_annual' ones(n,1)]; 
mubar = [-0.5:0.0000001:0.9];
sigma2=(1/det(A))*(A(1,1)-2*A(1,2)*mubar+A(2,2)*mubar.^2); 
mu_mvp=A(1,2)/A(2,2); % Mean for Minimum Variance Portfolio
sig_mvp=sqrt(1/A(2,2)); % Risk for Minimum Variance Portfolio

mu_mrr=A(1,1)/A(1,2); % Mean for Maximum Return-Risk Portfolio
sig_mrr=sqrt(A(1,1)/(A(1,2))^2); % Risk for Maximum Return-Risk Portfolio


% The utility function for selecting the Optimal Portfolio 

Risk=4;
ra=Risk./2;
u_1=0.1;

sigpi=[0:1.e-6:0.7];
mupi_1=u_1+ ra*sigpi.^2; 

u_2=0.175;
mupi_2=u_2+ ra*sigpi.^2; 

u_3=0.25;
mupi_3=u_3+ ra*sigpi.^2; 


u_4=0.312;
mupi_4=u_4+ ra*sigpi.^2; 

figure(27)
plot(sqrt(sigma2),mubar,'k');
hold  on;
plot(sqrt(cov_annual(1,1)),mu_annual(1,1),'ro');
hold on;
plot(sqrt(cov_annual(2,2)),mu_annual(1,2),'bo');
hold on;
plot(sqrt(cov_annual(3,3)),mu_annual(1,3),'yo');
hold on;
plot(sqrt(cov_annual(4,4)),mu_annual(1,4),'co');
hold on;
plot(sqrt(cov_annual(5,5)),mu_annual(1,5),'go');
hold on;
plot(sig_mvp,mu_mvp,'sg');
hold on;
plot(sig_mrr,mu_mrr,'sm');
xlabel('\sigma')
ylabel('\mu')

x = 0.335308; % x-coordinate of the OPT
y = 0.536863; % y-coordinate of the OPT
hold on; 
scatter(x, y, 'o', 'filled', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k');

plot(sigpi,mupi_4,'b')
plot(sigpi,mupi_1,'r--')
plot(sigpi,mupi_2,'r--') 
plot(sigpi,mupi_3,'r--')

title('Efficient Frontier of the Portfolio');
legend('Min variance set','STAN','NWG','MTRO','HSBA','BARC','\Pi_{MVP}','\Pi_{MRR}','\Pi_{OPT}','Utility u=0.312','Utility u=0.1,0.175,0.25')
