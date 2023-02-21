function  circles=CirclesHough_article(im,maxR,minR,Rmap,thresh)
% Detect edge pixels using Canny edge detector.
% Adjust the lower and/or upper thresholds to balance between the performance and detection quality.
% For each edge pixel, increment the corresponding elements in the Hough array. (Ex Ey) are the coordinates of edge pixels and (Cy Cx R) are the
% centers and radii of the corresponding circles.

col=length(im(1,:)); row=length(im(:,1));

edgeim = edge(im, 'canny', [0.15 0.4]);
[Ey Ex] = find(edgeim);
n= find(Rmap);
[Cy Cx R]  = ind2sub(size(Rmap), n);

hough=zeros(row,col,maxR-minR+1);
for i = 1:length(Ex)
 x = Cx + Ex(i)-col/2 - 1;
 y = Cy + Ey(i)-row/2- 1;
 for j=1:length(x)
 if x(j) >= 1 && x(j) <= size(hough,2) && y(j) >= 1 && y(j) <= size(hough,1)
   Index = sub2ind(size(hough), y(j), x(j), R(j)-minR+1);
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