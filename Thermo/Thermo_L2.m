
vol_water = [3 4 5 6 8 10 11 13 15 20 27];
vol_phenol = [5 5 5 5 5 5 5 5 5 5 5];

mass_water = vol_water*1;
moles_water = mass_water/18;
mass_phenol = vol_phenol*1.07;
moles_phenol = mass_phenol/94;

mass_frac_water = mass_water./(mass_phenol+mass_water);
mass_frac_phenol = 1 - mass_frac_water;
mole_frac_water = moles_water./(moles_phenol+moles_water);
mole_frac_phenol = 1 - mole_frac_water;

T1 = [45.8 56.8 62 64.2 66.5 68.1 67.4 66.7 66 64.5 61.1];
T2 = [44 55.4 61.2 63.7 65.8 66.9 67 66 65.8 64.3 60.5];
T1K = T1 + 273.15;
T2K = T2 + 273.15;

T = 1/2*(T1+T2);
TK = T + 273.15;

mass_frac_fit = polyfit(mass_frac_phenol,TK,2)
mole_frac_fit = polyfit(mole_frac_phenol,TK,2)

x1=[0.15:0.005:0.65];
y1=polyval(mass_frac_fit,mass_frac_phenol);
y11=polyval(mass_frac_fit,x1);

x2=[0:0.003:0.3];
y2=polyval(mole_frac_fit,mole_frac_phenol);
y22=polyval(mole_frac_fit,x2);

figure
plot(mass_frac_phenol,TK,'*r',x1,y11,'b')
xlabel('Mass fraction of Phenol','FontSize',10,'FontWeight','bold')
ylabel('Temperature (K)','FontSize',10,'FontWeight','bold')
legend('Data','Fitted Curve')
saveas(gcf,"fig1.pdf")

figure
plot(mole_frac_phenol,TK,'*r',x2,y22,'b')
xlabel('Mole fraction of Phenol','FontSize',10,'FontWeight','bold')
ylabel('Temperature (K)','FontSize',10,'FontWeight','bold')
legend('Data','Fitted Curve')
saveas(gcf,"fig2.pdf")

% curve = @(x) -952.3776*x^2 + 193.2332*x + 329.9628;
 
for i=1:11
    mole_frac_fit(3) = 329.9628 - TK(i);
    roots(mole_frac_fit);
end

TKnew = [TK(3),TK(4),TK(5),TK(8),TK(9),TK(10),TK(11)];
xp2 = [0.1740 0.1543 0.1235 0.1181 0.1288 0.1497 0.1796];
xp1 = [0.0289 0.0486 0.0794 0.0848 0.0741 0.0532 0.0233];

xw1 = 1-xp1;
xw2 = 1-xp2;

start_val=[1.5 9];

options=optimoptions(@fsolve,'OptimalityTolerance', 1.00e-8, 'StepTolerance', 1.00e-8,'MaxFunctionEvaluations',1.00e1);

A = [1.8711 1.9022 1.9301 1.9325 1.9269 1.9078 1.8603];
B = [9.1565 9.2661 9.3549 9.3621 9.3451 9.2848 9.1147];
A_inv = 1./A;
B_inv = 1./B;

for i=1:7
    fun = @(x) myfun (x, xp1(i), xp2(i), xw1(i), xw2(i), TKnew(i));
    fsolve(fun, start_val, options);
end

p1 = polyfit(TKnew,A_inv,1)
p2 = polyfit(TKnew,B_inv,1)

x=[333:0.01:340];
Ayval=polyval(p1,x);
Byval=polyval(p2,x);

figure
plot(TKnew,A_inv,'rx',x,Ayval,'b')
ylim([0 0.6])
xlabel('Temperature (K)','FontSize',10,'FontWeight','bold')
ylabel('1/A','FontSize',10,'FontWeight','bold')
legend('Data','Fitted Line')
saveas(gcf,"fig3.pdf")

figure
plot(TKnew,B_inv,'rx',x,Byval,'b')
ylim([0 0.15])
xlabel('Temperature (K)','FontSize',10,'FontWeight','bold')
ylabel('1/B','FontSize',10,'FontWeight','bold')
legend('Data','Fitted Line')
saveas(gcf,"fig4.pdf")
function F=myfun(x,xp1, xp2, xw1, xw2, TK)
    A=x(1);
    B=x(2);
    R=8.314;

    F(1)=(xw1)*exp((A*((B*xp1)^2))/(R*TK*(A*xw1+B*xp1)^2)) - (xw2)*exp((A*((B*xp2)^2))/(R*TK*(A*xw2+B*xp2)^2));
    F(2)=(xp1)*exp((B*((A*xw1)^2))/(R*TK*(A*xw1+B*xp1)^2)) - (xp2)*exp((B*((A*xw2)^2))/(R*TK*(A*xw2+B*xp2)^2));
end

%% Solutions obtained from fsolve

% 1.8711    9.1565
% 1.9022    9.2661
% 1.9301    9.3549
% 1.9325    9.3621
% 1.9269    9.3451
% 1.9078    9.2848
% 1.8603    9.1147