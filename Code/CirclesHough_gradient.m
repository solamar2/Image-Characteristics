function  circles=CirclesHough_gradient(im,maxR,minR,thresh)
% Detect edge pixels using Canny edge detector.
% Adjust the lower and/or upper thresholds to balance between the performance and detection quality.
% For each edge pixel, increment the corresponding elements in the Hough
% array. (Ex Ey) are the coordinates of edge pixels

col=length(im(1,:)); row=length(im(:,1));
[Gmag, Gdir] = imgradient(im);
R=minR:maxR;
edgeim = edge(im, 'canny', [0.15 0.4]);

[Ey Ex] = find(edgeim);
hough=zeros(row,col,maxR-minR+1);
for i = 1:length(Ex)
 %point 1: in the gradient direction and length of the appropriate radious
 x1 = round(Ex(i)+R.*cos(Gdir(Ey(i),Ex(i))));
 y1 = round(Ey(i)-R.*sin(Gdir(Ey(i),Ex(i))));
 %point 2: in the opposite direction and length of the appropriate radious
 x2 = round(Ex(i)-R.*cos(Gdir(Ey(i),Ex(i))));
 y2 = round(Ey(i)+R.*sin(Gdir(Ey(i),Ex(i))));
 for j=1:length(x1)
 if x1(j) >= 1 && x1(j) <= size(hough,2) && y1(j) >= 1 && y1(j) <= size(hough,1)
   Index = sub2ind(size(hough), y1(j), x1(j), R(j)-minR+1);
   hough(Index) = hough(Index) + 1;
 end
 if x2(j) >= 1 && x2(j) <= size(hough,2) && y2(j) >= 1 && y2(j) <= size(hough,1)
   Index = sub2ind(size(hough), y2(j), x2(j), R(j)-minR+1);
   hough(Index) = hough(Index) + 1;
 end
 end
end

% Collect candidate circles.
% Due to digitization, the number of detectable edge pixels are about 90%
% of the calculated perimeter.
twoPi = 0.9*2*pi;
circles = zeros(0,4); % Format: (x y r t)
for radius = minR:maxR % Loop from minimal to maximal radius
 slice = hough(:,:,radius-minR+1); % Offset by minR
 twoPiR = twoPi*radius;
 slice(slice<twoPiR*thresh) = 0; % Clear pixel count < 0.9*2*pi*R*thresh
 n = find(slice);
 [y x count]=ind2sub(size(slice), n);
 circles = [circles; [y, x, radius*ones(length(x),1), count/twoPiR]];
end

end