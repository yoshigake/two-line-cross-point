clc,clear;
CROSS=imread('cross3.jpg');           %original pics in left folder
graycross=rgb2gray(CROSS);
Aftergray=MY_Gaussian(graycross);     %inclue my gaussian filter
[row,col]=size(Aftergray);
for i=1:row
    for j=1:col
        if Aftergray(i,j)>=220
            Aftergray(i,j)=255;
        else Aftergray(i,j)=0;
        end
    end
end           %Binarization 
Afteredge=MY_Edge(Aftergray);         %include my edge detection function
[H,T,R]=MY_Hough(Afteredge,200,2);    %include my hough transform function
figure(1),DRAW_CROSS_Point(T,R,CROSS);%include my function to draw point
figure(2),imshow(imadjust(mat2gray(H)),...
'InitialMagnification','fit');xlabel('\theta'),ylabel('\rho')
title('HOUGH SPACE');                 %draw the Hough space
axis on,axis normal,hold on