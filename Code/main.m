%% check:
x=[1,2,3];
y=[4,5,6];

theta=0:0.01:pi;
for i=1:3
    r(i,:)=x(i)*cos(theta)+y(i)*sin(theta);
end

figure
plot(theta, r(1,:));
hold on
plot(theta, r(2,:));
plot(theta, r(3,:));
xlabel('Theta [rad]');ylabel('r');


%% lines detection:
clear all
RGB = imread("gantrycrane.png");
gray = rgb2gray(RGB);
BW = edge(gray,'canny');

Theta_resolution=1*2*pi/360; R_resolution=1;
[H,T,R]=HoughTransform_lines(BW,Theta_resolution,R_resolution);

[H_true,T_true,R_true] = hough(BW,'Theta',T*180/pi); % matlab function for equalization

T_true_rad=T_true*2*pi/360;

figure;
subplot(1,2,1);
imshow(imadjust(rescale(H_true)),'XData',T_true_rad,'YData',R_true, 'InitialMagnification','fit');hold on;
title('Hough transform of gantrycrane.png - by matalb function'); xlabel('Theta [rad]'), ylabel('r');
axis on; axis normal; 
colormap(gca,hot);

subplot(1,2,2);
imshow(imadjust(rescale(H)),'XData',T,'YData',R, 'InitialMagnification','fit');hold on;
title('Hough transform of gantrycrane.png - my implementation'); xlabel('Theta [rad]'), ylabel('r');
axis on; axis normal; 
colormap(gca,hot);

%% Circular:
clear all
coins = imread('coins.png');
figure;imshow(coins)
imdistline; %measuring radius of the coins

maxR=30; minR=20;

col=length(coins(1,:)); row=length(coins(:,1)); %number of row and col
Rmap = zeros(row,col, maxR-minR+1);
% loop through the possible radii and fill the Rmap matrix:
Theta_resolution=1*2*pi/360;
T=0:Theta_resolution:2*pi-Theta_resolution;
for radius = minR:maxR
 x=col/2+radius.*cos(T); x=round(x);
 y=row/2+radius.*sin(T); y=round(y);
 Rmap(y,x,radius) =1;
end

thresh=1;
tic
circles=CirclesHough_article(coins,maxR,minR,Rmap,thresh);
toc


%improving:
minDist=35;
new_circles=isclose(circles,minDist);

edgeim = edge(coins, 'canny', [0.15 0.4]);
new_circles=isEmpty(new_circles,edgeim,0.92);

%plot the results:
centers=[new_circles(:,2),new_circles(:,1)];
radii=new_circles(:,3);
figure; imshow(coins);
hold on;
for i = 1:size(centers,1)
   viscircles(centers(i,:), radii(i));
end


%% gradient:
clear all
coins = imread('coins.png');


maxR=30; minR=20;
thresh=0.01;
tic
circles=CirclesHough_gradient(coins,maxR,minR,thresh);
toc
%improving:
edgeim = edge(coins, 'canny', [0.15 0.4]);
new_circles=isEmpty(circles,edgeim,0.9);

minDist=30;
new_circles=isclose(new_circles,minDist);

%plot the results:
centers=[new_circles(:,2),new_circles(:,1)];
radii=new_circles(:,3);
figure; imshow(coins);
hold on;
for i = 1:size(centers,1)
   viscircles(centers(i,:), radii(i));
end