clear all 
close all 
clc
addpath('trs/matlab/')
startup_robot;

vid = Movie('./video/data/matlab_0008.avi','double'); %vid.ROIPosition = [0 134 674 216];
clc
disp('done')
%% Region of interest
base = vid.grab();
% roi
%[base roi] = iroi(base);
roi = [1 600; 200 390];
%roi = [1 600; 220 410];
base = iroi(base,roi);
[ilg ihg c] = size(base);
%idisp(base)

%%
alpha = 0.95;
treshold = 30;
reg_nr = 1;
m_00 = 0;
cent = [];
theta = [];

Gx = [1 0 -1;2 0 -2;1 0 -1];
Gy = [1 2 1; 0 0 0; -1 -2 -1];

while 1
    im = vid.grab;
    if isempty(im), break; end
    im = iroi(im,roi);
    %% RGB to HSI
      HSI = colorspace('RGB->HSI',im);
    
    %% Treshholding 

    for i = 1:ilg
       for j = 1:ihg
       if (HSI(i,j,1) >= 180 && HSI(i,j,1) <= 230 && HSI(i,j,2) >= 0.4 && HSI(i,j,2) <= 1)
           g(i,j) = 1;
       else 
           g(i,j) = 0;

       end
       end
    end        
    

    %%
    %[label m] = ilabel(g);
    f = iblobs(g,'area',[1000 100000]);
    [tmp lg] = size(f);
    
    %% Calculation shit
    if lg >= 1

    m_00 = f(1).moments.m00;
    uc = f(1).moments.m10/m_00;
    vc = f(1).moments.m01/m_00;

   %% plot   
        subplot(3,1,1)
        imshow(im)
        hold on
        f.plot_box('r');
        plot(uc, vc, 'gx'); plot(uc, vc, 'go');
        f(1).plot_ellipse('g');

        subplot(3,1,2)
        imshow(HSI);
        
        subplot(3,1,3)
        imshow(g);
   %% saveing
    cent = [cent; uc vc];
    theta = [theta;f(1).theta_ * 180/pi];
    else
        subplot(3,1,1)
        imshow(im)
        continue
    end
end
 


figure
plot(cent,'x');
%label('uc','vc')
figure
plot(theta,'x')
ylim([0 180]);

%% 1D motion model
F = [1 1;0 1]; %A
G = [0.5; 1]; %B
H = [1 0;0 1]; %C
Vd = [1e-5 0; 0 1e-5];
Vn = [1 0; 0 1];
sys = ss(F,[G Vd],H,0);
P0 = F*eye(2)*F'+1;
x0 = [0;0];
[Kf P] = lqe(F,Vd,H,Vd,Vn);
%Kf = (lqr(F',H',Vd,Vn))';
sysKF = ss(F-Kf*H,[G Kf],eye(2),0);
[lg tmp] = size(cent(:,1));
t = 1:lg;
u = 1*t;
% [x t] = lsim(sysKF,[u;cent(:,1)'],t);
% figure
% plot(t,x(:,1))
alpha = (1/30)/((1/(2*pi*30))+(1/30));
for i=2:1:lg
    v(i) = (sqrt((cent(i,1)-cent(i-1,1))^2+(cent(i,2)-cent(i-1,2))^2))*30;
    v_x(i) = (cent(i,1)-cent(i-1,1))*30;
    v_y(i) = (cent(i,2)-cent(i-1,2))*30;
    if i>=3
    filt_v(i) = (v(i)+v(i-1)+v(i-2))/3;
    end
end
save_v = [t' v_x' v_y'];
test = [t' cent(:,1) v'];

