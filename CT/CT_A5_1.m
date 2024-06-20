%a
k0 = [0.05,0.61];
Eact = [10000,8625];

reactiondata.pre_exponential_factor = k0;
reactiondata.activation_energy = Eact;

%b,c
%part 1
C1= 1000;   %M
C2 = 100;   %M
%part 2
k0 = [0.05,0.61];
Eact = [10000,8625];

reactiondata.pre_exponential_factor = k0;
reactiondata.activation_energy = Eact;
rate = zeros(1,2)

rate = reactionrate1(C1,C2,500,reactiondata);

function rate = reactionrate1(C1,C2,T,reactiondata)
    R = 8.314;
    k = reactiondata.pre_exponential_factor;
    Eac = reactiondata.activation_energy;
    rate(1) = C1*C2*k(1)*exp(-Eac(1)/(R*500)); 
    rate(2) = C1*C2*k(2)*exp(-Eac(2)/(R*800)); 
end

%d 
%part 1
C1= 1000;   %M
C2 = 100;    %M
k0 = [0.05,0.61];
Eact = [10000,8625];

reactiondata.pre_exponential_factor = k0;
reactiondata.activation_energy = Eact;
rate = zeros(2,2);
T = linspace(500,800,100)
%part 3
for T = 500:3:800
    i = 1;
    rate(i) = reactionrate1(C1,C2,T,reactiondata);
    rate1 = rate(1,:);
    rate2 = rate(2,:);
end

figure;
semilogy(rate1,T,'-b');
semilogy(rate2,T,'-g');
%part 3 ends

%part 2
function [r1, r2] = reactionrate1(C1,C2,T,reactiondata)
    R = 8.314;
    k = reactiondata.pre_exponential_factor;
    Eac = reactiondata.activation_energy;
    r1 = C1*C2*k(1)*exp(-Eac(1)/(R*T)); 
    r2 = C1*C2*k(2)*exp(-Eac(2)/(R*T)); 
end


