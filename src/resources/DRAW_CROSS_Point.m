function DRAW_CROSS_Point(theta,rho,originalpic)
%%  This function is specific for two-lines picture that have one cross point,Written by Tianyan
%   theta:picture after hough transform that get two theta values
%   rho:picture after hough transform that get two rho values
%   originalpic:the original two-lines picture that have one cross point

%%  Draw the detected lines and cross point
[row,col]=size(originalpic);    %get size of the original picture
rho1=rho(1);rho2=rho(2);
theta1=theta(1);theta2=theta(2);%get the rho and theta values
A=[cos(theta1*pi/180),sin(theta1*pi/180);
   cos(theta2*pi/180),sin(theta2*pi/180)];
B=[rho1;rho2];                  %constract the linear equations
X=A\B;                          %sove the equations and get answer vector
x=round(X(1));
y=round(X(2));                  %get the approximate values to draw picture
x1=1:row;x2=1:col;
y1=-cos(theta1*pi/180)/sin(theta1*pi/180)*x1+rho1/sin(theta1*pi/180);
y2=-cos(theta2*pi/180)/sin(theta2*pi/180)*x2+rho2/sin(theta2*pi/180);%generate the equations of the two lines
imshow(originalpic),title('CROSS POINT');
axis on,axis normal,hold on
plot(y1,x1,'b'),plot(y2,x2,'g');%draw the two detected lines
rectangle('Position',[y-10,x-10,20,20],'Curvature',[1,1]);%draw a circle that symbols the cross point 
end