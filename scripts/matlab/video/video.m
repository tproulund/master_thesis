
clear all;

close all;
clc;


% Constructing a video input interface 
vid = videoinput('winvideo',2,'RGB24_640x480');
time = 30;
framerate = 30;
set(vid,'FramesPerTrigger',time*framerate); % Duration of movie

set(vid,'FrameGrabInterval',1); % Can control frame rate

start(vid);

wait(vid,Inf);

interval = get(vid,'FrameGrabInterval');

set(vid,'LoggingMode','disk');

avi = VideoWriter('./data/data_0001.avi', 'Uncompressed AVI');

avi.FrameRate = framerate;
set(vid,'DiskLogger',avi);

start(vid);

wait(vid,Inf); 

avi = get(vid,'DiskLogger');

delete(vid);

clear vid;




