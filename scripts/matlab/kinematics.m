% This file defines the kinematics for the scara robot and connects the
% camera coordinate system to the base of the robot
clear all
clc
close all
addpath('plot_functions/')
addpath('V-REP_PRO_EDU_V3_3_2_64_Linux/programming/remoteApiBindings/matlab/matlab/')
addpath('V-REP_PRO_EDU_V3_3_2_64_Linux/programming/remoteApiBindings/lib/lib/64Bit/')

%% Geometri
d1 = 0.387; %m
a1 = 0.325; %m
a2 = 0.6-a1; %m
d4 = -0.05; %m

constants = [a1 a2 d1 d4];
%% Joint ranges
q1_range = [-105 105]*pi/180;
q2_range = [-150 150]*pi/180;
q3_range = [0 0.210];
q4_range = [-pi pi]*2;

%% Kinematic and invers kinematics plot

q = [-1 -1 -0.15 2]'; %joint space configuration
p = [0.2 -0.2 0.237 0.6]'; % end effector position and orientation

%figure
%for s=0:0.1:1
%p = [0.2 0.43 0.237 0.6]'+s*([0.3 0.2 0.337 0.6]'-[0.2 0.43 0.237 0.6]');   

% If p is added as the last argument, the function calculates the inverse
% kinematics 

[q_new p_new] = plot_of_scara(q, constants, @kinematric_transform, @plot_functions,p)

%drawnow
 

%end

