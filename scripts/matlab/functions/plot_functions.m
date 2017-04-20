function [ A1 A2 A3 A4 ] = plot_functions(q, constants)
%PLOT_FUNCTIONS Summary of this function goes here
%   Detailed explanation goes here
a1 = constants(1);
a2 = constants(2);
d1 = constants(3);
d4 = constants(4);
a4 = constants(5);
alpha4 = constants(6);

A1 = [cos(q(1)) -sin(q(1)) 0 a1*cos(q(1));
      sin(q(1)) cos(q(1)) 0 a1*sin(q(1));
      0 0 1 d1;
      0 0 0 1];
  
A2 = [cos(q(2)) -sin(q(2)) 0 a2*cos(q(2));
      sin(q(2)) cos(q(2)) 0 a2*sin(q(2));
      0 0 1 0;
      0 0 0 1];
  
A3 = [1 0 0 0;
      0 1 0 0;
      0 0 1 q(3);
      0 0 0 1];
  
A4 = [cos(q(4)) -cos(alpha4)*sin(q(4)) sin(alpha4)*sin(q(4)) a4*cos(q(4));
      sin(q(4)) cos(alpha4)*cos(q(4)) -sin(alpha4)*cos(q(4)) a4*sin(q(4));
      0 sin(alpha4) cos(alpha4) d4;
      0 0 0 1]; 
  
end

