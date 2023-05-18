clear all; close all;



MTRO = importdata('MTRO.L.csv'); % import Metro Bank PLC data 
MTRO_ACP=MTRO.data(:,5); % Extracts column 6 (Adjusted Close Price)

datestr=MTRO.textdata(2:end,1);
dates=datenum(datestr,'yyyy-mm-dd');


figure (31)
hold on
plot(dates,MTRO_ACP,'y')
ylabel('Share Prices (GBP)')
xlabel('Time (Months)')
datetick('x','mmmyy','keepticks')
title("Metro Bank PLC's Share Prices")


time=126;

time_tilde=1; 

LOGR=zeros(length(MTRO_ACP)-1,1);
for i=1:length(MTRO_ACP)-1
LOGR(i)=log(MTRO_ACP(i+1))-log(MTRO_ACP(i)); 
end

Exp_C=mean(LOGR);
cov_C=cov(LOGR);

Exp_Hrzn_C=Exp_C*time/time_tilde; 
cov_Hrzn_C=cov_C*time/time_tilde;

simulations =10000000; % number of simulations
CompReturns_Scenarios=mvnrnd(Exp_Hrzn_C,cov_Hrzn_C,simulations);

% find simulated investment horizon price distribution
p=MTRO_ACP(end,:); % P(T): Latest price of the historical data
Market_Scenarios =(ones(simulations,1)*p).*exp(CompReturns_Scenarios);
% Market_Scenarios calculation:


% compute mean and variance-covariance matrix of prices at investment horizon
Exp_Prices=mean(Market_Scenarios)';% Expected random price after 126 trading days in future
Cov_Prices=cov(Market_Scenarios);

% compute linear return mean and variance-covariance matrix at investment horizon
Exp_LinRets=Exp_Prices./p-1 % Calculates the linear return of expected future price (after 126 days)
% Linear Return=(P(t)-P(t-1))/P(t-1)


p=MTRO_ACP(end,:); % Current price
e=95; % Exercise price (lower)
% No risk free rate considered hence third entry is 0.
T=1/2; % Option price for a full 6 month period, based on current price.
sig=sqrt(Cov_Prices); % Volatility of asset
finalprice=Exp_Prices; % Expected future price after 6 months (in future) for input into blsprice

%------------------------------------------------------------
% One long call and one short put
% Long call: Buy the option and wish the future price at expiry to exceed
% the agreed exercise/strike price.

% Short put: Sell the option and we wish the future price to exceed the
% buyers' exercise price, thus not having to pay out afterwards.

[inicall, iniput]=blsprice(p,e,0,T,sig);
cost = inicall-iniput; % We are selling the put option so this is subtracted from the cost.
profitcall=max(finalprice-e,0); % If final price is not the exercise price, option NOT exercised!
profitput=max(e-finalprice,0);
profit1=profitcall-profitput-cost; % profitput is what we pay out (if exercised) hence is deducted from profits
disp( ['One long call and one short put yields profit/loss =',num2str(profit1),'GBP']);



%-------------------------------------------------------------
% One short call and one short put

% Short Call: We sell the option and wish the future price to deteriorate
% so it's NOT exercised, thus we don't pay out afterwards.

[call, put]= blsprice(p,e,0,T,sig);
cost =-call-put;
profitc = max(finalprice-e,0);
profitp = max(e-finalprice,0);
profit2 = -profitc-profitp - cost;
disp( ['One short call and one short put yields profit/loss =',num2str(profit2),'GBP']);


%-------------------------------------------------------------
% One long call and one long put

[call, put]= blsprice(25,e,0,T,sig);
cost =call+put;
profitc = max(finalprice-e,0);
profitp = max(e-finalprice,0);
profit3 = profitc+profitp - cost;
disp( ['One long call and one long put yields profit/loss =',num2str(profit3),' GBP']);



%-------------------------------------------------------------

% One long call and one long put with different strike prices
e2=110; %higher
[callh, puth]= blsprice(p,e,0,T,sig);
[call,putl] = blsprice(p,e2,0,T,sig);
cost =putl-puth;
profitl = max(e-finalprice,0);
profith = max(e2-finalprice,0);
profit4 = profitl -profith-cost;
disp( ['One long call and one long put with different strike prices yields profit/loss =',num2str(profit4),' GBP']);

%-------------------------------------------------------------

% One long underlying asset and one short call

call= blsprice(p,e,0,T,sig);
cost =e-call;
profit5 = finalprice-max(finalprice-e,0)-cost; 

disp( ['One long underlying asset and one short call yields profit/loss =',num2str(profit5),' GBP']);

results=[profit1 profit2 profit3 profit4 profit5];
