function gasussianmat=MY_Gaussian(originalpic)
%%  this function generate a 3x3 gaussian filter,wroten by Tianyan
originalpic=padarray(originalpic,[1,1]);
originalpic=double(originalpic);
G=zeros(3);%the gaussian core
[m,n]=size(originalpic);%get size of the input picture
MP=zeros(m,n);%deposit the result
for i=2:m-1                         %generate a 3x3 filter
    for j=2:n-1
            gaussian_me=[2^0.5,1,2^0.5,1,0,1,2^0.5,1,2^0.5];%get space distance
            g_std=std(double(gaussian_me),1);%calculate the std of the gaussian & bilateral core
            for k=1:3
               for l=1:3
                   G(k,l)=exp(-((k-2)^2+(l-2)^2)/(2*g_std^2));%space field gaussian function
               end
            end
            sumbgm=sum(sum(G));
            G=1/sumbgm.*G;%normalization the 3x3 bilateral_gaussian filter
            t=0;
            for p=1:3
                for q=1:3
                    t=G(p,q).*originalpic(i+p-2,j+q-2)+t;
                end
            end
            MP(i,j)=t;%get thee result
    end
end
gasussianmat=MP(2:m-1,2:n-1);%return
end