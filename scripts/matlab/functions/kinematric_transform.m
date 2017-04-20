function [ A1 A2 A3 J Ac] = kinematric_transfer( q, constants)
% This function returns the direct kinematics values
% for each joint. 
a1 = constants(1);
a2 = constants(2);
d1 = constants(3);
d4 = constants(4);
a4 = constants(5);
alpha4 = constants(6);
alpha_c = constants(7);
p_c = constants(8:end);

A1 = [cos(q(1)+q(2)) -sin(q(1)+q(2)) 0 a1*cos(q(1))+a2*cos(q(1)+q(2));
      sin(q(1)+q(2)) cos(q(1)+q(2)) 0 a1*sin(q(1))+a2*sin(q(1)+q(2));
      0 0 1 d1;
      0 0 0 1];
  
A2 = [cos(q(1)+q(2)) -sin(q(1)+q(2)) 0 a1*cos(q(1))+a2*cos(q(1)+q(2));
      sin(q(1)+q(2)) cos(q(1)+q(2)) 0 a1*sin(q(1))+a2*sin(q(1)+q(2));
      0 0 1 d1+q(3);
      0 0 0 1];
A3 = [cos(q(1)+q(2)+q(4)) -cos(alpha4)*sin(q(1)+q(2)+q(4)) 0 a4*cos(q(1)+q(2)+q(4))+a1*cos(q(1))+a2*cos(q(1)+q(2));
      sin(q(1)+q(2)+q(4))  cos(alpha4)*cos(q(1)+q(2)+q(4)) 0 a4*sin(q(1)+q(2)+q(4))+a1*sin(q(1))+a2*sin(q(1)+q(2));
      0 sin(alpha4) cos(alpha4) d4+d1+q(3);
      0 0 0 1];

Ac = [cos(q(1)+q(2)+q(4)+alpha_c) -cos(alpha4)*sin(q(1)+q(2)+q(4)+alpha_c) 0 a4*cos(q(1)+q(2)+q(4)+alpha_c)+a1*cos(q(1)+alpha_c)+a2*cos(q(1)+q(2)+alpha_c)+p_c(1);
      sin(q(1)+q(2)+q(4)+alpha_c)  cos(alpha4)*cos(q(1)+q(2)+q(4)+alpha_c) 0 a4*sin(q(1)+q(2)+q(4)+alpha_c)+a1*sin(q(1)+alpha_c)+a2*sin(q(1)+q(2)+alpha_c)+p_c(2);
      0 sin(alpha4) cos(alpha4) d4+d1+q(3)+p_c(3);
      0 0 0 1];  
  
J  = [-a2*sin(q(1)+q(2))-a1*sin(q(1)) -a2*sin(q(1)+q(2)) 0 0;
     a2*cos(q(1)+q(2))+a1*cos(q(1)) a2*cos(q(1)+q(2)) 0 0;
      0 0 1 0;
      1 1 0 1];

% J  = [-a2*sin(q(1)+q(2))-a1*sin(q(1)) -a2*sin(q(1)+q(2)) 0;
%      a2*cos(q(1)+q(2))+a1*cos(q(1)) a2*cos(q(1)+q(2)) 0;
%       0 0 1];
end

