%assn6c (c part)

%importing the text file from the directory
file = load("data_for_lab.txt");

%extracting the column vectors from the text file
Biooil = file(:,9);
CO = file(:,7);
A1CH3 = file(:,8);

%data given
m_Bio = 0.017008;
m_CO = 0.02801;
m_A1CH3 = 0.092134;

%modifying the component arrays 
new_BioOil = m_Bio*Biooil*1000; %g/mol
new_CO = m_CO*CO*1000;  %g/mol
new_A1CH3 = m_A1CH3*A1CH3*1000; %g/mol

%to divide by the total...
total = new_BioOil + new_CO + new_A1CH3;

%to get dimensionless mole fraction
new_BioOil = new_BioOil./total;
new_CO = new_CO./total;
new_A1CH3 = new_A1CH3./total;