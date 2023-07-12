% 1066600
clear all;

% Create map
map = binaryOccupancyMap(8,6,100);

% Extract Occupancy
Matr = occupancyMatrix(map);

% Fill Grid with 1
% Occ Rows
Matr(1,:) = 1;
for i = 100:100:600
    Matr(i,:) = 1;
end
% Occ Col
Matr(:,1) = 1;
for i = 100:100:800
    Matr(:,i) = 1;
end
%----------------Rows-------------------%
Matr(1,301:400) = 0; % 1st 
Matr(100,2:99) = 0;
Matr(100,101:199) = 0;
Matr(100,401:499) = 0;
Matr(100,701:799) = 0;
Matr(200,2:99) = 0; % 2nd
Matr(200,201:299) = 0;
Matr(200,301:399) = 0;
Matr(200,401:499) = 0;
Matr(200,501:599) = 0;
Matr(200,601:699) = 0;
Matr(300,2:99) = 0; % 3rd
Matr(300,101:199) = 0;
Matr(300,401:499) = 0;
Matr(300,701:799) = 0;
Matr(400,2:99) = 0; % 4th
Matr(400,501:599) = 0;
Matr(500,2:99) = 0; % 5th
Matr(500,101:199) = 0;
Matr(500,301:399) = 0;
Matr(500,601:699) = 0;
Matr(500,701:799) = 0;
Matr(600,401:500) = 0; % 6th
%----------------Columns-------------------%
Matr(2:99,100) = 0; % 2nd
Matr(201:299,100) = 0;
Matr(501:599,100) = 0;
Matr(2:99,200) = 0; % 3rd
Matr(201:299,200) = 0;
Matr(301:399,200) = 0;
Matr(401:499,200) = 0;
Matr(101:199,300) = 0; %4th
Matr(301:399,300) = 0;
Matr(401:499,300) = 0;
Matr(501:599,300) = 0;
Matr(2:99,400) = 0; %5th
Matr(301:399,400) = 0;
Matr(401:499,400) = 0;
Matr(501:599,400) = 0;
Matr(501:599,500) = 0; %6th
Matr(2:99,600) = 0; %7th
Matr(101:199,600) = 0;
Matr(301:399,600) = 0;
Matr(401:499,600) = 0;
Matr(501:599,600) = 0;
Matr(2:99,700) = 0; %8th
Matr(101:199,700) = 0; %8th
Matr(201:299,700) = 0; %8th
Matr(301:399,700) = 0; %8th
Matr(501:599,700) = 0; %8th

% Set Occ
setOccupancy(map,[0,0],Matr)

% Inflate for C-Space 
map.inflate(0.165);

% Plot
show(map)

% Save
save('C:\Users\Konstantin\Desktop\lab\4o Etos\robotic systems\Optional\maze_bin_occupancy_map','map');