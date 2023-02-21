function img = drawCircle(img, center, radius)
% this function create binary image with circle in center and radius as in
% the input.
[X, Y] = meshgrid(1:size(img,2), 1:size(img,1));
dist = sqrt((X - center(1)).^2 + (Y - center(2)).^2);
img(dist <= radius & dist > radius-1) = 1;
end
