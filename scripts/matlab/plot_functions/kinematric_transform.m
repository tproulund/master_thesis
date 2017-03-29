function [ A1 A2 A3 J] = kinematric_transfer( q, constants)
% This function returns the direct kinematics values
% for each joint. 
a1 = constants(1);
a2 = constants(2);
d1 = constants(3);
d4 = constants(4);

A1 = [cos(q(1)+q(2)) -sin(q(1)+q(2)) 0 a1*cos(q(1))+a2*cos(q(1)+q(2));
      sin(q(1)+q(2)) cos(q(1)+q(2)) 0 a1*sin(q(1))+a2*sin(q(1)+q(2));
      0 0 1 d1;
      0 0 0 1];
  
A2 = [cos(q(1)+q(2)) -sin(q(1)+q(2)) 0 a1*cos(q(1))+a2*cos(q(1)+q(2));
      sin(q(1)+q(2)) cos(q(1)+q(2)) 0 a1*sin(q(1))+a2*sin(q(1)+q(2));
      0 0 1 d1+q(3);
      0 0 0 1];
A3 = [cos(q(1)+q(2)+q(4)) sin(q(1)+q(2)+q(4)) 0 a1*cos(q(1))+a2*cos(q(1)+q(2));
      sin(q(1)+q(2)+q(4)) -cos(q(1)+q(2)+q(4)) 0 a1*sin(q(1))+a2*sin(q(1)+q(2));
      0 0 1 d4+d1+q(3);
      0 0 0 1];
  
J  = [-a2*sin(q(1)+q(2))-a1*sin(q(1)) -a2*sin(q(1)+q(2)) 0 0;
     a2*cos(q(1)+q(2))+a1*cos(q(1)) a2*cos(q(1)+q(2)) 0 0;
      0 0 1 0;
      1 1 0 1];

% J  = [-a2*sin(q(1)+q(2))-a1*sin(q(1)) -a2*sin(q(1)+q(2)) 0;
%      a2*cos(q(1)+q(2))+a1*cos(q(1)) a2*cos(q(1)+q(2)) 0;
%       0 0 1];
end

