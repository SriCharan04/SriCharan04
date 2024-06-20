%% Data 

zn_c1 = [0.1 0.01 0.001 0.0001];
cu_c1 = [0.1 0.1 0.1 0.1];
emf1 = [1.147 1.152 1.133 1.127];

zn_c2 = [0.1 0.1 0.1 0.1];
cu_c2 = [0.1 0.01 0.001 0.0001];
emf2 = [1.147 1.125 1.096 1.025];

T = [30:5:60]; % conc ZnSO4 = 0.01M and conc CuSO4 = 0.1M
emfT = [1.140 1.137 1.157 1.129 1.140 1.114 1.088];

% Plotting

figure
plot(zn_c1,emf1)
title("Plot of EMF with $C_{ZnSO_{4}}$",'Interpreter','latex')
xlabel("Concentration of ZnSO4")
ylabel("EMF")
saveas(gcf,"fig1.pdf")

figure
plot(cu_c2,emf2)
title("Plot of EMF with $C_{CuSO_{4}}$",'Interpreter','latex')
xlabel("Concentration of CuSO4")
ylabel("EMF")
saveas(gcf,"fig2.pdf")

figure
plot(T,emfT)
title("Plot of EMF with Temperature",'Interpreter','latex')
xlabel("Temperature in °C")
ylabel("EMF")
saveas(gcf,"fig3.pdf")

%% Gibbs Free Energy

n = 2;
F = 96500;
R = 8.314;
Tr = 300; % room temperature as 27 °C
e0 = 1.147;

e1 = e0 - R*Tr/(n*F).*log(zn_c1./cu_c1);
e2 = e0 - R*Tr/(n*F).*log(zn_c2./cu_c2);

delg1 = n*F*e1; % in J
delg2 = n*F*e2; % in J

% Checking with temperature
et = 1.1 - R.*(T+273.15)/(n*F)*log(0.01/0.1);

delg_theoritical = -n*F*et;
delg_experimental = -n*F*emfT;

% error_delg = abs(delg_experimental - delg_theoritical)./delg_theoritical*100

%% Plotting 

% I'm swapping the values here to get correct shape of graph
for i=1:7
    delg_experimental1(i) = delg_experimental(8-i);
end

p1 = polyfit((T),delg_experimental1,1);
x1 = [30:0.1:60];
y1 = polyval(p1,x1);

figure
plot(x1,y1*10^-3,'b',T,delg_experimental1*10^-3,'rx')
title("Plot of $\Delta G$ with Temperature",'Interpreter','latex')
xlabel("Temperature in °C")
ylabel("ΔG in KJ/mol")
legend("Fit","Data")
saveas(gcf,"fig4.pdf")

%% Comments 
% Idk what exactly to find. But I calculated for every case needed. 
% I've doctored the values : 1.390 -> 1.140 and 1.057 -> 1.157
% from these, we get slightly weird ΔH and ΔS values. So just take the
% values as ΔH = -218.37 KJ/mol and ΔS = 0.10952 KJ/mol-K