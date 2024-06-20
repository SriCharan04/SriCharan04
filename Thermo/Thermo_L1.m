density_mixture = [0.9976 0.9807 0.9652 0.9456 0.9239 0.9001 0.8776 0.8550 0.8317 0.8086 0.7851];
volume_mixture = 50./density_mixture;

mass_water = [50:-5:0];
mass_ipa = [0:5:50];

mass_fraction_water = mass_water/50;
mass_fraction_ipa = mass_ipa/50;

volume_water = mass_water/density_mixture(1);
volume_ipa = mass_ipa/density_mixture(11);

moles_water = mass_water/18;
moles_ipa = mass_ipa/60;

mole_fraction_water = moles_water./(mass_ipa + mass_water);
mole_fraction_ipa = 1 - mole_fraction_water;

delv = volume_mixture - volume_ipa - volume_water;

% figure
% subplot(2,2,1)
% plot(mass_fraction_water,delv);
% xlabel('Mass fraction of Water','FontSize',10,'FontWeight','bold')
% ylabel('Change in Volume','FontSize',10,'FontWeight','bold')
% 
% %figure
% subplot(2,2,2)
% plot(mass_fraction_ipa,delv);
% xlabel('Mass fraction of IPA','FontSize',10,'FontWeight','bold')
% ylabel('Change in Volume','FontSize',10,'FontWeight','bold')
% 
% %figure
% subplot(2,2,3)
% plot(mole_fraction_water,delv);
% xlabel('Mole fraction of Water','FontSize',10,'FontWeight','bold')
% ylabel('Change in Volume','FontSize',10,'FontWeight','bold')
% 
% %figure
% subplot(2,2,4)
% plot(mole_fraction_ipa,delv);
% xlabel('Mole fraction of IPA','FontSize',10,'FontWeight','bold')
% ylabel('Change in Volume','FontSize',10,'FontWeight','bold')

p1 = polyfit(mass_fraction_water,delv,2);
p2 = polyfit(mass_fraction_ipa,delv,2);
p3 = polyfit(mole_fraction_water,delv,2);
p4 = polyfit(mole_fraction_ipa,delv,2);

x1 = [0:0.01:1];
y1 = polyval(p1,mass_fraction_water);
y11 = polyval(p1,x1);

y2 = polyval(p2,mass_fraction_ipa);
y22 = polyval(p2,x1);

x3 = [0:0.0006:0.06];
y3 = polyval(p3,mole_fraction_water);
y33 = polyval(p3,x3);

x4 = [0.94:0.0006:1];
y4 = polyval(p4,mole_fraction_ipa);
%size(x4)
%size(y4)
%y44 = polyval(p4,x4);
%p = polyfit(x4,y44,2);
%y_P = polyval(x4,p);



figure
subplot(2,2,1)
plot(mass_fraction_water,y1,'r+',mass_fraction_water,delv,'gx',x1,y11,'b')
xlabel('Mass fraction of Water','FontSize',10,'FontWeight','bold')
ylabel('Change in Volume','FontSize',10,'FontWeight','bold')

%figure
subplot(2,2,2)
plot(mass_fraction_ipa,y2,'r+',mass_fraction_ipa,delv,'gx',x1,y22,'b')
xlabel('Mass fraction of IPA','FontSize',10,'FontWeight','bold')
ylabel('Change in Volume','FontSize',10,'FontWeight','bold')

%figure
subplot(2,2,3)
plot(mole_fraction_water,y3,'r+',mole_fraction_water,delv,'gx',x3,y33,'b')
xlabel('Mole fraction of Water','FontSize',10,'FontWeight','bold')
ylabel('Change in Volume','FontSize',10,'FontWeight','bold')

%figure
subplot(2,2,4)
plot(mole_fraction_ipa,y4,'r+',mole_fraction_ipa,delv,'gx',x4,y44,'b-')
xlabel('Mole fraction of IPA','FontSize',10,'FontWeight','bold')
ylabel('Change in Volume','FontSize',10,'FontWeight','bold')