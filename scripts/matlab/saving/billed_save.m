close all
%% clean picture
fig = figure;
clean = vid.grab();
imshow(clean);
cd pictures\
print(fig,'clean_pic','-djpeg')
cd ..
close all
%% Region of interest
fig = figure;
roi = [1 600; 220 410];
im = iroi(clean,roi);
imshow(im)
cd pictures\
print(fig,'roi_pic','-djpeg')
cd ..
close all
%% base picture
fig = figure;
%clean = vid.grab();
imshow(base);
cd pictures\
print(fig,'base_pic','-djpeg')
cd ..
close all
%% Background substraction
im2 = ((3/3)*im(:,:,1)+(0)*im(:,:,2)+(0)*im(:,:,3));
base2 = ((3/3)*base(:,:,1)+(0/3)*base(:,:,2)+(0/3)*base(:,:,3));
im3 = abs(im2-base2);
fig = figure;
imshow(abs(im2-base2));
cd pictures\
print(fig,'background_pic','-djpeg')
cd ..
%close all

%% Tresholding and histogram
fig = figure;
imhist(im3)
xlim([0 0.4]);
ylabel('Number of pixels');
cd pictures\
print(fig,'histo_pic','-djpeg')

t = otsu(im3);
tresh = (im3 >= t);
fig = figure;
imshow(tresh);
print(fig,'tresh_otsu','-djpeg')

t = 0.15;
tresh = (im3 >= t);
fig = figure;
imshow(tresh);
print(fig,'tresh_static','-djpeg')


%% HSI
fig = figure;
imshow(HSI)
print(fig,'HSI_pic','-djpeg')


%% Histogram
fig = figure;
histogram(HSI(:,:,1))
ylabel('Number of pixels');
print(fig,'histo_H','-djpeg')

fig = figure;
histogram(HSI(:,:,2))
xlim([0 1]);
ylim([0 1000]);
ylabel('Number of pixels');
print(fig,'histo_S','-djpeg')

%% Threshold
fig = figure;
imshow(g)
print(fig,'thres_hsi','-djpeg')

%% Bounding box
fig = figure
imshow(im)
hold on
f.plot_box('r','linewidth',1.5);
hold off
print(fig,'box_hsi','-djpeg')

%% centorid box
fig = figure
imshow(im)
hold on
f.plot_box('r','linewidth',1.5);
plot(uc, vc, 'gx','linewidth',1.5); plot(uc, vc, 'go','linewidth',1.5);

hold off
print(fig,'cent_hsi','-djpeg')

%% Elipse
fig = figure
imshow(im)
hold on
f.plot_box('r','linewidth',1.5);
plot(uc, vc, 'gx','linewidth',1.5); plot(uc, vc, 'go','linewidth',1.5);
f(1).plot_ellipse('r','linewidth',1.5);
hold off
print(fig,'elipse_hsi','-djpeg')

%% Save data
save('pos.dat', 'cent','-ascii')
save('ori.dat', 'theta','-ascii')
save('vec.dat', 'save_v','-ascii')

%%
cd ..
close all