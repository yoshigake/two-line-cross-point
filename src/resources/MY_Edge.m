function cannymat=MY_Edge(graypic)
%%  This function is wroten by Tianyan
%    M:the input image,befor usong this function,you can use  gaussian filter to
%    reduce the influence of the noise
%    cannymat:return the processed matrix,after the max edge and two-threshold processing

%%  The initial processing
sobelx=[-1 0 1;-2 0 2;-1 0 1];
sobely=sobelx';              %generate the sobel filter
gradx=conv2(graypic,sobelx,'same');
grady=conv2(graypic,sobely,'same');
grad=sqrt(gradx.^2+grady.^2);%get the grad matrix of the picture
theta=atan(grady./gradx);    %get the direction matrix of the pic
[row,col]=size(graypic);
MAXEDGE=zeros(row,col);      %get size and generate max edge matrix
%%  This part is to generate a max edge matrix
%    MAXEDGE is the max edge out of all the edges in differnt directions
for i=2:row-1
    for j=2:col-1
        dirc=theta(i,j);     %replace the theta(i,j),make it simple
        if abs(dirc)<=pi/8
            if grad(i,j)==max([grad(i,j-1),grad(i,j),grad(i,j+1)])
                MAXEDGE(i,j)=grad(i,j);
            end %the horizontal direction and the normal vector is vertical
        elseif abs(dirc)>=3*pi/8
            if grad(i,j)==max([grad(i-1,j),grad(i,j),grad(i+1,j)])
                MAXEDGE(i,j)=grad(i,j);
            end %the vertical direction and the normal vector is horizontal
        elseif dirc>pi/8 && dirc<3*pi/8
            if grad(i,j)==max([grad(i-1,j-1),grad(i,j),grad(i+1,j+1)])
                MAXEDGE(i,j)=grad(i,j);
            end %the 45бу direction and the normal vector is 135бу 
        elseif dirc>-3*pi/8 && dirc<-pi/8
            if grad(i,j)==max([grad(i-1,j+1),grad(i,j),grad(i+1,j-1)])
                MAXEDGE(i,j)=grad(i,j);
            end %the 135бу direction and the normal vector is 45бу
        end
    end
end
%%  This part is the two-threshold Matrix by the neibormatrix detecion
MAXthre=max(max(MAXEDGE));
threH=0.3*MAXthre;         %High threshold
threL=0.1*MAXthre;         %Low threshold
canny=zeros(row,col);      %generate the canny matrix
for i=2:row-1
    for j=2:col-1
        if MAXEDGE(i,j)>=threH      %higher than the High threshold,keep it
            canny(i,j)=MAXEDGE(i,j);
        elseif MAXEDGE(i,j)<threL  
            canny(i,j)=0;           %lower than thee Low threshold,quite it
        else
            neiborMatrix=MAXEDGE(i-1:i+1,j-1:j+1);
            if max(max(neiborMatrix))>=threH
                canny(i,j)=MAXEDGE(i,j);
            else canny(i,j)=0;
            %between the High threshold and Low threshold,detect the
            %neibor matrix.if there are values higher than the High 
            %threshold,keep it,or,quit it
            end
        end
    end
end
cannymat=canny;     %return the final matrix
end