function new_circles=isclose(circles,minDist)
% the purpose of this function is to check if there is near circles in an image that might indicate about the same circle in the origin photo.

% the input- minDist
% is the minimum distance between two circles that will be considered two different. When the distance between two circles is less than this distance, only one of them will be taken.
%the selection will be made using the circle with the highest score in that area.
%In cases where several adjacent circles with the same score -will be chosen arbitrarily by the median.

new_circles = zeros(0,4); % Format: (x y r t)
i=1;
while length(circles)>0
    dist=sqrt((circles(i,2)-circles(:,2)).^2+(circles(i,1)-circles(:,1)).^2);
    n=find(dist<=minDist);
    index=find(circles(n,4)==max(circles(n,4))); index=round(median(index));
   if index>0
       new_circles=[new_circles; circles(index,:)];
   end
   circles(n,:) =[]; % deleting the tested circuits- improves the running time
end

end