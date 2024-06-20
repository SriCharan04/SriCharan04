%% Isothermal Data

Tt = 29+273.15; % in K
Vt = [50:-1:37]*(10^-6); % in m^3

% in mbar
P1 = [0 20.7 40.8 60 81.7 102.5 123.5 154.6 176.2 201.8 228 256.3 284.1 323];
P2 = [0 22 40 58.4 80.5 104.6 127.5 147.7 170.2 199.2 226.1 255.2 283.7 315.7];
P3 = [0 21 39.3 61.8 80.2 102 125 150.9 174 200.5 225.4 254 281.2 312.2];

Pt_avg = 10^2*(P1+P2+P3)/3; % in Pa 

%% Isobaric Data

Pb = 101325; % in Pa
Vb = [0:0.2:4]*10^-6; % in m^3
Tb = [29 30 31 31 32 33 33 34 34 35 36 38 39 41 42 43 44 45 46 47 48] + 273.15; % in K

%% Isochoric Data

Tc = [31:1:46] + 273.15; % in K
Pc = [0 3 6.2 8.9 10.8 12.4 14.5 15.7 16.9 17.8 18.7 19.6 20.1 20.6 21.0 21.3]*10^2; % in Pa

%%  Isothermal Calculations

p1 = polyfit(1./Vt,Pt_avg,1);
x1 = [3.6:0.01:5]*10^-5;
y1 = polyval(p1,1./x1);

figure;
plot(1./Vt,Pt_avg,'rx',1./x1,y1,'b')
xlabel("1/Volume in m\^-3");
ylabel("Pressure in Pa");
legend("Data Points","Fit Line")

sum = 0;
for i=2:14
dv_dp(i-1) = (Vt(i-1) - Vt(i))/(Pt_avg(i-1) - Pt_avg(i));
sum = sum+dv_dp(i-1);
end
dv_dp(14) = sum/14;

k = 1./Vt.*dv_dp;

ksum = 0;
for i=1:14
    ksum = ksum + k(i);
end
k_avg = ksum/14;

% P = 4.4748/V - 8.9215 * 10^4 in standard units

% Finding 2nd Virial coeff
B = Vt.*((Pt_avg.*Vt)/(8.314*Tt) - 1)
B_avg = mean(B,"all");
% Equation is PV/RT = 1 + B/V       solve for V

%% Isobaric Calculations

% alpha = 1/V*dV/dT

Vb_cons = 75*10^-6; %in m^3   this is some const value.

alpha = 1/Vb_cons.*Vb./(Tb-Tb(1));

alpha_avg = mean(alpha(2:20));

%Calc of R=P*M/T*rho
Rb = Pb*29/1000/(303*1.25); %Taken value of T as 303K and rho as 1.25 kg/m^3

% Plotting T vs V

p2 = polyfit(Vb,Tb,1)
x2 = [0:0.01:4]*10^-6;
y2 = polyval(p2,x2);

figure;
plot(Vb,Tb,'rx',x2,y2,'b')
xlabel("Volume in m\^-3");
ylabel("Temperature in K");
legend("Data Points","Fit Line")

%% Isochoric Conditions

p3 = polyfit(Tc,Pc,3);
x3 = [304:0.01:320];
y3 = polyval(p3,x3);
figure;
plot(Tc,Pc,'rx',x3,y3,'b')

ylabel("Pressure in Pa");
xlabel("Temperature in K");
legend("Data Points","Fit Line")

% The fitted cubic curve comes out to be 0.4284T^3 -410.6681T^2 +
% 1.3125*10^5T - 1.3984*10^7
% This exhibits a clear dominance in the linear term as seen.




