function [H,T,R]=HoughTransform_lines(BW,Theta_resolution,R_resolution)
%this fonction perform the hough transform 
%input:
% BW- edge image (binary) 
% Theta_resolution- resolution of theta in rad
% R_resolution- resolution of R

%output:
% H: a matrix of the "grade" of each combination of R,theta. The rows represent the r and columns the theta.
% R,T: represent the values of the length and the angle in the H matrix respectively

% The definition of the resolutions of variables:
T=-pi/2:Theta_resolution:pi/2-Theta_resolution;

M=length(BW(:,1)); N=length(BW(1,:));
max_R= ceil(sqrt((N-1)^2 + (M-1)^2));  % maximum distance: The length of the diagonal according to Pythagoras
R =-max_R:R_resolution:max_R;

H=zeros(length(R),length(T));

[y,x]=find(BW==1);
for i=1:length(x)
    r(i,:)=x(i)*cos(T)+y(i)*sin(T);
end

r_round=round(r);
for i=1:length(T)
    for j=1:length(r_round)
       n=find(R==r_round(j,i));
       H(n,i)= H(n,i)+1;
    end
end

end