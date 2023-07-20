• During my participation in the Robotics Systems course, I undertook a project aimed at creating a safe and
optimal path for an Amigobot to navigate through a maze. To accomplish this, I employed Matlab in
conjunction with the Navigation Toolbox. The project involved several key steps, starting with translating
the real-life maze into a binary occupancy map. Subsequently, I identified the configuration space (C-space)
and applied the hybrid A* algorithm to determine the optimal path, taking into account the non-holonomic
constraints specific to the Amigobot. Lastly, I conducted a simulation to visualize and evaluate the
trajectory of the robot.

Project was created during the "Robotic Systems" course. (University of Patras)

1) Labyrinth_gen.m: Run this to create the maze and C-Space, visualize and finally save as "maze_bin_occupancy_map.mat.
2) with_Hybrid_Astar.m: Run this to create the optimal path throught the maze while taking in account the robot's non-holonomin constraints.
   and the path data to "HybridAstar_path.mat".
3) Diff_robot_sim.m: Simulates the robot movement on the path.

Thank you!
