%assn6c(a part)

%importing the text file from the directory
file = load("data_for_lab.txt");

%loading each component vector data into the script
time = file(:,1);
Biooil = file(:,9);
CO = file(:,7);
A1CH3 = file(:,8);

%creating marker array to mark the points on the respective graphs in the
%customised function
counter = 1;
for i = [0.1 0.2 0.65 0.9 1]
    marker(1,counter) = i;  %first row stores the timestamps
    marker(2,counter) = Biooil(find(time == i)); %second row stores the marker values for Biooil component
    marker(3,counter) = CO(find(time == i)); %third row stores the marker values for CO component
    marker(4,counter) = A1CH3(find(time == i));  %fourth row stores the marker values for A1CH3 component
    counter = counter + 1;
end

%plotting the mass fractions of the components using the custom plotting
%function
figure;
do_it(Biooil,time,'Time','Bio Oil')
hold on
do_it(CO,time,'Time','CO')
hold on
do_it(A1CH3,time,'Time','A1CH3')
hold on

%plotting the marker values for each component
for i = 1:size(marker,2)
        marker_array = marker(:,i);
        time = marker_array(1);
        for j = 2:size(marker_array)
            y_point = marker_array(j);
            diagram = plot(time,y_point,'o');
        end
end