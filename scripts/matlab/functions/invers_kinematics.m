function [ q_f count] = invers_kinematics(q, p, fun, constants)

a1 = constants(1);
a2 = constants(2);
d1 = constants(3);
d4 = constants(4);
count = 0;
[T1 T2 T3 J] = fun(q,constants);
f_r = [T3(1:3,4);q(1)+q(2)+q(4)];
while norm(p-f_r)>0.05
[T1 T2 T3 J] = fun(q,constants);
f_r = [T3(1:3,4);q(1)+q(2)+q(4)];
%psudo = (J'*inv(J*J'));
q_k = q+inv(J)*(p-f_r); 
q = q_k;
count = count+1;
end
q_f = q_k;
end

