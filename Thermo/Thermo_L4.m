%% Data
T = [70.3 63.2 55 50.2 46.5 42.2 39.3 36.8]+273.15;
V = [24.9 29.8 30.9 33.7 36.1 38.8 40.3 42.4];

%% Calculations
moles = 20/101.1032 ;
conc = moles./(V/1000);
ksp = conc.^2;

% del G = -RTln(Ksp)
R = 8.314;
G = -R.*T.*log(ksp)/1000; %in KJ

%% Fitting
p1 = polyfit(T,G,1);
x1=[305:0.1:345];
y1 = polyval(p1,x1);

% Equation is ΔG = -0.1110T + 26.4444 KJ

p2 = polyfit(1./T,log(ksp),1);
x2 = [2.9:0.01:3.24]*10^-3;
y2 = polyval(p2,x2);

% Equation is ln(ksp) = -3.1799*10^3*(1/T) + 13.3513

% ln(ksp) = (-ΔH/R)*(1/T) + (ΔS/R)
H = -R*p2(1); % 26.437 KJ/mol
S = R*p2(2); % 111.0029 KJ/mol-K

%% Plotting
figure
plot(T,G,'ob',x1,y1,'r')
title("Gibbs Energy plot with Temperature",'Interpreter','latex')
xlabel('T (K)','FontSize',10,'FontWeight','bold')
ylabel('ΔG (KJ)','FontSize',10,'FontWeight','bold')
saveas(gcf,"fig1.pdf")

figure
plot(1./T,log(ksp),'ob',x2,y2,'r')
title("Plot of $ln(K_{sp})$ with $\frac{1}{T}$",'Interpreter','latex')
xlabel('1/T (1/K)','FontSize',10,'FontWeight','bold')
ylabel('ln(Ksp)','FontSize',10,'FontWeight','bold')
saveas(gcf,"fig2.pdf")

%% Results 
fprintf("ΔH dissolution is : %f J/mol\n",H)
fprintf("ΔS dissolution is : %f J/(mol-K)\n",S)