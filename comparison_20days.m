clear all; close all; 


STAN = importdata('STAN.L.csv',',',1); % import Standard Chartered PLC data 
STAN_ACP=STAN.data(:,5); % Extracts column 6 (Adjusted Close Price) 
NWG = importdata('NWG.L.csv',',',1); % import Natwest Group plc data 
NWG_ACP=NWG.data(:,5); % Extracts column 6 (Adjusted Close Price) 
MTRO = importdata('MTRO.L.csv',',',1); % import Metro Bank PLC data 
MTRO_ACP=MTRO.data(:,5); % Extracts column 6 (Adjusted Close Price) 
HSBA = importdata('HSBA.L.csv',',',1); % import HSBC Holding plc data 
HSBA_ACP=HSBA.data(:,5); % Extracts column 6 (Adjusted Close Price) 
BARC = importdata('BARC.L.csv',',',1); % import Barclays plc data 
BARC_ACP=BARC.data(:,5); % Extracts column 6 (Adjusted Close Price)
FTSE=importdata('FTSE_Data.csv'); % import FTSE data 
FTSE_ACP = FTSE.data(:,5);  % Extracts column 6 (Adjusted Close Price)

n=5; 
datestr=STAN.textdata(2:end,1);
dates=datenum(datestr,'yyyy-mm-dd');

V=[STAN_ACP,NWG_ACP,MTRO_ACP,HSBA_ACP,BARC_ACP];

%optimal weights obtained from Optimal_Weights.m

w=[  0.35002;
   0.31443;
    0.46015;
   0.276102;
    0.32795012];


Ret=V(end,:)./V(1,:)-1;
disp(['Our portfolio return is ', num2str(Ret * w)])

FTS=FTSE_ACP(end)/FTSE_ACP(1)-1;
disp(['The market index return is ',num2str(FTS)])



% extract data for every 20 trading days
T20=V(1:20:end,:);
FTSE20=FTSE_ACP(1:20:end,:);
dates20=dates(1:20:end,:);

R=zeros(length(T20),n);
Portfolio=zeros(length(T20)-1,1); indexR=Portfolio;

for i=1:length(T20)
    for j=1:n
        R(i,j)=T20(i,j)/T20(1,j)-1;
    end
        Portfolio(i)= R(i,:)*w; % calculates the return of the portfolio for that time period
        indexR(i)=FTSE20(i)/FTSE20(1)-1; % index return
end


figure (28)
hold on
plot(dates20,Portfolio)
plot(dates20,indexR)
datetick('x','mmm')
ylabel('Returns')
xlabel('Months 2022')
legend('Portfolio','FTSE')
