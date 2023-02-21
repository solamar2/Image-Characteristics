function new_circles=isEmpty(circles,edgeim,thresh)
%The purpose of this function is to check if the tested circle is in a certain percentage of the image.
%It does this by finding the amount of overlapping pixels between the tested circle and an expanded image of the edge to allow for a certain error range. 
% The multiplication gives us the number of overlapping pixels, and if it is less than thresh percent of the circumference of the circle then it is deleted.
col=length(edgeim(1,:)); row=length(edgeim(:,1));

%dilation of edge image:
se = strel('disk', 7);
edgeim_dilate=imdilate(edgeim,se); 

centers=[circles(:,2),circles(:,1)];
radii=circles(:,3);
j=1;
for i=1:length(centers)
    img = false(row,col); 
    img = drawCircle(img,centers(i,:), radii(i)); %draw binary image to each circle
    multi_img=img.*edgeim_dilate; 
    n=find(multi_img);
    if length(n)>= (2*pi*radii(i)*thresh)
        new_circles(j,:)=circles(i,:);
        j=j+1;
    end
end

end