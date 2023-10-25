function [H,THETA,RHO]=MY_Hough(edgepic,threshold,linecount)
%% this function is wroten by Tianyan
%  take the function hough in matlab as reference
%  the three outputs are symbol as follws:
%     H:the hough space matrix,row is the rho while col is the theta;
%     THETA:different from the function hough in matlab.
%     only detected lines's theta values are returned.
%     RHO:same as the THETA.
%  the three inputs are as follows:
%     edgepic:the gray picture after binarization and edge detection
%     threshold:threshold of whether recognizing it as a line
%     lincount:decide how many lines you want to detect

%% Original processing part
[row_M,col_M]=size(edgepic);%get size of the input image
rhomax=round((row_M^2+col_M^2)^0.5);%calculate the rhomax 
H=zeros(2*rhomax,180);%constract the HOUGH space
[row_H,col_H]=size(H);%get size of Hough space
T=zeros(1,linecount+1);%deposit original Theta value
R=zeros(1,linecount+1);%deposit original Rho value
count=2;%start of the T/R vector
%%  this part generate the Hough space
for Rho=1:row_M
    for Theta=1:col_M
        if(edgepic(Rho,Theta)>0)%detect whether the pix is an edge
            for theta=1:180%draw the Hough space
                rad=theta/180*pi;%transform the theta into radian
                rho=round(Rho*cos(rad)+Theta*sin(rad));%culculate the rho value
                rho=rho+rhomax;%the rho value may be negative,add rhomax make it positive
                H(rho,theta)=H(rho,theta)+1;%draw the line in hough space
            end
        end
    end
end
%% test code 
% while row_H>0
%     while col_H>0
%         if H(row_H,col_H)>threshold
%             R(count)=row_H-rhomax;
%             T(count)=col_H;
%             count=count+1;
%             row_H=row_H-10;
%             col_H=col_H-10;
%         end
%         col_H=col_H-1;
%     end
%     row_H=row_H-1;
% end
% [R,T]=find(H>threshold);
%%  this part return the theta and rho value of the detected lines
for Rho=1:row_H
    for Theta=1:col_H
        if (H(Rho,Theta)>threshold)&&(count<=linecount+1)%get the lines that beyond the shreshold
            R(count)=Rho-rhomax;%return the rho value
            T(count)=Theta;%return the theta value
            if (abs(R(count-1)-R(count))<=10)&&(abs(T(count-1)-T(count))<=10)
                count=count+1-1;%if the next value is similar to the previous,abandon it
            else count=count+1;
            end
        end
    end
end
THETA=zeros(1,linecount);
RHO=zeros(1,linecount);%consttact the return value vectors
for i=1:linecount
    THETA(i)=T(i+1);%shift the value from the original vectors 
    RHO(i)=R(i+1);  %to the return vectors to insure that it starts from one
end
end