function [ q_robot,p3 ] = plot_of_scara( q, constants, fun1, func2, p )
% This function will plot a q vector and solve
% the inverse kinematics if a p vector is parsed
% 
% a1 = constants(1);
% a2 = constants(2);
% d1 = constants(3);
% d4 = constants(4);

if nargin > 4

    count = 0;
    [T1 T2 T3 J] = fun1(q,constants);
    f_r = [T3(1:3,4);q(1)+q(2)+q(4)];
    while norm(p-f_r)>0.005
        [T1 T2 T3 J] = fun1(q,constants);
        f_r = [T3(1:3,4);q(1)+q(2)+q(4)];
        psudo = (J'*inv(J*J'));
        q_k = q+psudo*(p-f_r); 
        q = q_k;
        count = count+1;
    end
    %q_f = q_k;
end
[T1 T2 T3 J T4] = fun1(q,constants);
[A1 A2 A3 A4] = func2(q,constants);

%% Scale for robot controller
q_robot(1) = q(1)*180/pi;
q_robot(2) = q(2)*180/pi;
q_robot(3) = -q(3)*1000;
q_robot(4) = q(4)*180/pi;

%% Simple line plot of the robot
p1 = T1(1:3,4);
p2 = T2(1:3,4);
p3 = T3(1:3,4);
R3 = T3(1:3,1:3)*eye(3)*0.05;
X=[0 0; 
   0 A1(1,4); 
   A1(1,4) p1(1);
   p1(1) p2(1);
   p2(1) p2(1);
   p2(1) p3(1)];

Y=[0 0; 
   0 A1(2,4);
   A1(2,4) p1(2);
   p1(2) p2(2);
   p2(2) p2(2);
   p2(2) p3(2)];


Z=[0 A1(3,4);
   A1(3,4) A1(3,4); 
   A1(3,4) p1(3);
   p1(3) p2(3);
   p2(3) p3(3)
   p2(3) p3(3)];


clf 
plot3(X,Y,Z,'-','color','red','linewidth',2)
hold on
%arrow(p3,p3+R3(1:3,1),'Length',8,'Width',1.5,'color','blue')
%arrow(p3,p3+R3(1:3,2),'Length',8,'Width',1.5,'color','green')
%arrow(p3,p3-R3(1:3,3),'Length',8,'Width',1.5,'color','yellow')

plot3([p3(1) p3(1)+R3(1,1)],[p3(2) p3(2)+R3(2,1)],[p3(3) p3(3)+R3(3,1)],'color','blue','linewidth',1.5)
plot3([p3(1) p3(1)+R3(1,2)],[p3(2) p3(2)+R3(2,2)],[p3(3) p3(3)+R3(3,2)],'color','green','linewidth',1.5)
plot3([p3(1) p3(1)+R3(1,3)],[p3(2) p3(2)+R3(2,3)],[p3(3) p3(3)+R3(3,3)],'color','c','linewidth',1.5)

xlabel('x');
ylabel('y');
zlabel('z');
legend('','','x','y','z');
zlim([0 0.4])
ylim([-0.6 0.6])
xlim([-0.2 0.6])
view(-30,50)
grid
%camproj perspective; 

end

