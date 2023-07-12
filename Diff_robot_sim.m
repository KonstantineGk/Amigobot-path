%-------------------------- 1066600 ---------------------------------%
clear;
% Load Labyrinth
data = load('C:\Users\Konstantin\Desktop\lab\4o Etos\robotic systems\Optional\maze_bin_occupancy_map.mat');
map = data.map;
 
% Load path
loadedData = load('C:\Users\Konstantin\Desktop\lab\4o Etos\robotic systems\Optional\HybridAstar_path.mat');
pathObj = loadedData.pthObj;
path = pathObj.States;

% Define Waypoints
start = [4.5 0.1 pi/2]; % Start
goal = [3.5 5.7 pi/2]; % Goal
robotCurrentPose = path(1,:)';
x_f = goal(1);
y_f = goal(2);

% Create a Kinematic Robot Model
robot = differentialDriveKinematics;
robot.TrackWidth = 0.24;
robot.VehicleInputs = "WheelSpeeds"; %VehicleSpeedHeadingRate
robot.WheelRadius = 0.05;
robot.WheelSpeedRange = [-0.942 0.942];

% Define the Path Following Controller
controller = controllerPurePursuit;
controller.Waypoints = path(:,1:2);
controller.LookaheadDistance = 0.15;

% Using the Path Following Controller, Drive the Robot over the Desired Waypoints
goalRadius = 5;
distanceToGoal = norm(start - goal);

% Initialize the simulation loop
sampleTime = 0.1;
vizRate = rateControl(1/sampleTime);

% Initialize the figure
figure

% Determine vehicle frame size to most closely represent vehicle with plotTransforms
frameSize = robot.TrackWidth/0.9;

% Initialize the costate variables
lambda1 = 10;
lambda2 = 10;
learningRate = 0.01;
criteria =[];

while( distanceToGoal > goalRadius )
    % Compute the controller outputs, i.e., the inputs to the robot
    [v, omega] = controller(robotCurrentPose);

    % Calculate velocities for each wheel
    Ur = (v + (omega * robot.TrackWidth) / 2) / robot.WheelRadius;
    Ul = (v - (omega * robot.TrackWidth) / 2) / robot.WheelRadius;

    % Update the control inputs and costate variables based on optimization
    dH_dUr = 2 * Ur + lambda1;
    dH_dUl = 2 * Ul + lambda2;

    % Update the control inputs using optimization update rule
    Ur = Ur - learningRate * dH_dUr;
    Ul = Ul - learningRate * dH_dUl;

    % Calculate velocities for each wheel based on the updated control inputs
    v = (Ur + Ul) * robot.WheelRadius / 2;
    omega = (Ur - Ul) * robot.WheelRadius / robot.TrackWidth;

    % Get the robot's velocity using controller inputs
    vel_dot = derivative(robot, robotCurrentPose, [v, omega]);

    % Update the current pose
    robotCurrentPose = robotCurrentPose + vel_dot*sampleTime; 

    % Calculate Criterion
    criteria(end+1) = (robotCurrentPose(1) - x_f)^2 + (robotCurrentPose(2) - y_f)^2 + Ur^2 + Ul^2;

    % Re-compute the distance to the goal
    distanceToGoal = norm(robotCurrentPose(1:2) - goal(1:2));
    
    % Update the costate variables based on the dynamics equations
    lambda1 = lambda1 - learningRate * dH_dUr;
    lambda2 = lambda2 - learningRate * dH_dUl;

    % Update the plot
    hold off
    
    % Plot path each instance so that it stays persistent while robot mesh
    % moves
    plot(path(:,1), path(:,2),"k--d")
    hold all
    
    % Plot the path of the robot as a set of transforms
    plotTrVec = [robotCurrentPose(1:2); 0];
    plotRot = axang2quat([0 0 1 robotCurrentPose(3)]);
    plotTransforms(plotTrVec', plotRot, "MeshFilePath", "groundvehicle.stl", "Parent", gca, "View","2D", "FrameSize", frameSize);
    light;
    xlim([0 8])
    ylim([0 6])
    waitfor(vizRate);
end