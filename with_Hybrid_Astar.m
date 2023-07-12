%------------ 1066600----------------%
clear;

% Load Labyrinth
data = load('C:\Users\Konstantin\Desktop\lab\4o Etos\robotic systems\Optional\maze_bin_occupancy_map.mat');
map = data.map;

% Set Start and Goal pose
startPose = [4.5 0.1 pi/2];
goalPose = [3.5 5.7 pi/2];

% Create state validator
ss = stateSpaceSE2;
ss.StateBounds = [map.XWorldLimits;map.YWorldLimits;[-pi pi]];
stateValidator = validatorOccupancyMap(ss);
stateValidator.Map = map;
stateValidator.ValidationDistance = 0.01; % 0.05

% Set Hybrid A star planner and parameters
planner = plannerHybridAStar(stateValidator);
planner.MotionPrimitiveLength = 0.375; % 0.375
planner.MinTurningRadius = 0.24; % 0.24
planner.NumMotionPrimitives = 5;
planner.InterpolationDistance = 0.1;

% Create Path
[pthObj,solnInfo] = plan(planner,startPose,goalPose);

% Save Path
save('C:\Users\Konstantin\Desktop\lab\4o Etos\robotic systems\Optional\HybridAstar_path.mat', 'pthObj');

% Path length
path_length = pthObj.pathLength();
fprintf('Path length: %.2f\n', path_length);

% Plot
show(planner);


















