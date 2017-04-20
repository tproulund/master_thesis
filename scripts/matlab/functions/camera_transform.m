function [ p ] = camera_transform(u, v, z, f, u0, v0, rho)
%Transforms pixel location to world coordinates

p(1,1) = z*(u-u0)*rho/f;
p(2,1) = z*(v-v0)*rho/f;
p(3,1) = z;
%   Detailed explanation goes here


end

