%% Initial Data

T = [100.5 94.2 90 86.8 82.3 81.2 81.1 81 80.4 79.5 78.8 78.5];% 78.5 78.8 79.5 80.4 81.1 81.2];

volume_water = [300 270 240 210 180 150 150 120 90 60 30 0];%0 30 60 90 120 150];
volume_ethanol = [0 30 60 90 120 150 150 180 210 240 270 300];% 300 270 240 210 180 150];

density_liquid = [0.996 0.988 0.981 0.976 0.969 0.963 0.907 0.893 0.886 0.875 0.822 0.788]; %0.788 0.822 0.875 0.886 0.893 0.907];
density_vapour = [0.997 0.907 0.867 0.851 0.849 0.836 0.837 0.831 0.827 0.813 0.808 0.796]; %0.796 0.808 0.813 0.827 0.831 0.837];

density_water = 0.997;
density_ethanol = 0.788;

%% Calculation of Xe,Xw,Ye,Yw

for i=1:12
    water_vapour(i) = (density_vapour(i) - density_ethanol)/(density_water - density_ethanol);
    water_liquid(i) = (density_liquid(i) - density_ethanol)/(density_water - density_ethanol);
    ethanol_vapour(i) = 1 - water_vapour(i);
    ethanol_liquid(i) = 1 - water_liquid(i);
end

% Molecular Weights
Mw = 18;
Me = 46;

for i=1:12
    Xw(i) = water_liquid(i)/Mw/(water_liquid(i)/Mw + ethanol_liquid(i)/Me);
    Xe(i) = ethanol_liquid(i)/Me/(water_liquid(i)/Mw + ethanol_liquid(i)/Me);
    Yw(i) = water_vapour(i)/Mw/(water_vapour(i)/Mw + ethanol_vapour(i)/Me);
    Ye(i) = ethanol_vapour(i)/Me/(water_vapour(i)/Mw + ethanol_vapour(i)/Me);
end

% Antoinne Coefficients taken from the PDF sent
Ae = 12.2917;
Be = 3803.98; 
Ce = 231.47;

Aw = 11.6834;
Bw = 3816.44;
Cw = 227.02;

% Finding Pressure
for i=1:12
    P_ethanol(i) = exp(Ae - Be/(T(i)+Ce));
    P_water(i) = exp(Aw - Bw/(T(i)+Cw));
end

% Using gamma = Yi*P/(Xi*Psat)     Assumed P = 1 here, because I'm not sure
for i=1:12
    Gamma_water(i) = Yw/(Xw*P_water(i));
    Gamma_ethanol(i) = Ye/(Xe*P_ethanol(i));
end

% We also need to find gamma predicted (done in the next section)
% For which we need to calculate A and B from the RTln(gamma) equations

%% Fitting Curve
% Ethanol has been taken for xdata
y_data = (8.314.*T.*log(Gamma_water)).^0.5;
x_data = (8.314.*T.*log(Gamma_ethanol)).^0.5;

ynew = y_data(5:12);
xnew = x_data(5:12);
p = polyfit(xnew,ynew,1)

% intercept = sqrt(B); slope = sqrt(B/A)
B = p(2)^2;
A = p(1)^2*B;

R = 8.314;
Gamma_prediction_ethanol = exp((A./(R.*T)).*(B.*Xw./(A.*Xe + B.*Xw)).^2);
Gamma_prediction_water = exp((B./(R.*T)).*(A.*Xw./(A.*Xe + B.*Xw)).^2);

% Uncomment and run this part to see accuracy, it's pretty decent
% Gamma_prediction_ethanol - Gamma_ethanol
% Gamma_prediction_water - Gamma_water
%% Plotting Graphs

figure
plot(Xe,T,'bx-',Ye,T,'rx-')
legend("vapour phase", "liquid phase");
title("T vs x for liquid and vapour phases")
xlabel("x1")
ylabel("T")
saveas(gcf,"fig1.png")

figure
plot(T,Gamma_ethanol,'bx-',T,Gamma_water,'rx-')
legend("$\gamma$ ethanol", "$\gamma$ water",'interpreter','latex');
title("$\gamma$ vs T for liquid and vapour phases",'Interpreter','latex')
xlabel("T")
ylabel("\gamma")
saveas(gcf,"fig2.png")


figure
plot(Xe,log(Gamma_ethanol./Gamma_water))
title('ln$\frac{\gamma_1}{\gamma_2}$ vs $x_1$ for liquid and vapour phases','interpreter','latex')
xlabel("ln$\frac{\gamma_1}{\gamma_2}$", 'Interpreter','latex')
ylabel("y_1")
saveas(gcf,"fig3.png")

figure
plot(xnew,ynew)
title("$\sqrt{\gamma}$ for ethanol and water",'Interpreter','latex')
xlabel("$\sqrt{\gamma_{ethanol}}$",'interpreter','latex')
ylabel("$\sqrt{\gamma_{water}}$",'interpreter','latex')
saveas(gcf,"fig4.png")

figure
plot(T,Gamma_prediction_ethanol,'bx-',T,Gamma_prediction_water,'rx-')
legend("$\gamma_{pred}ethanol$","$\gamma_{pred}water$",'interpreter','latex');
title("$\gamma$ vs T for liquid and vapour phases",'interpreter','latex')
xlabel("T")
ylabel("\gamma_{pred}")
saveas(gcf,"fig5.png")
