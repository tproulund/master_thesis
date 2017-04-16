% This file defines the kinematics for the scara robot and connects the
% camera coordinate system to the base of the robot
clear all
clc
close all
addpath('./functions/')
addpath('trs/matlab/')
startup_robot


%% Geometri
d1 = 0.387; %m
a1 = 0.325; %m
a2 = 0.6-a1; %m
a4 = 0.1;
d4 = -0.05; %m
alpha4 = 0;


%% Camera
alpha_c = 0; % eventual z rotation of camera
p_c = [0 0 0]; %vector from camera to base

%% Constants vector
constants = [a1 a2 d1 d4 a4 alpha4 alpha_c p_c];
%% Joint ranges
q1_range = [-105 105]*pi/180;
q2_range = [-150 150]*pi/180;
q3_range = [0 0.210];
q4_range = [-pi pi]*2;

%% Kinematic and invers kinematics plot

q = [0 -pi/2 -0.1 -2]'; %joint space configuration
p = [0.2 -0.2 0.237 0.6]'; % end effector position and orientation

%figure
%for s=0:0.1:1
%p = [0.2 0.43 0.237 0.6]'+s*([0.3 0.2 0.337 0.6]'-[0.2 0.43 0.237 0.6]');   

% If p is added as the last argument, the function calculates the inverse
% kinematics 

[q_new p_new] = plot_of_scara(q, constants, @kinematric_transform, @plot_functions)

%drawnow
 

%end

