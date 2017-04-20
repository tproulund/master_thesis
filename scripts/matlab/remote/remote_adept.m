
ip='172.16.141.110';

port=1234

get_current_cart_pos=10;
get_current_joint_pos=20;
set_cart_pos=100;
set_joint_pos=200;
set_close_gripper=300;
set_open_gripper=301;


%create socket and open connection
socket=tcpip(ip,port);
fopen(socket);

%example move command
%create message with comma-separated values
message = sprintf('%d,%d,%d,%d,%d,%d,%d',set_close_gripper,400,0,314,0,180,0);
%write the message to the open socket
fwrite(socket,message);
%read the reply (a single integer, 2164 if success, 9999 else)
fscanf(socket)