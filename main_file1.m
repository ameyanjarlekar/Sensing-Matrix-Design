tic
N = 40*8;
Ntest = 40*2;
d = 36*30;
k = 50;
measurements = 300;
% A = zeros(d,N);
id = zeros(N,1);
count = 0;
I = eye(d);
D = kron(dctmtx(36),dctmtx(30));
%D = kron(haarmtx(56),haarmtx(46));
DCT_values = zeros(d,1);
DCT_count = zeros(d,1);
t = 0.1;
for i=1:37
    for j=1:10
        %for angle=0:10:50
             for transx=-10:5:10
                 for transy=0:4:0

        count = count +1;
        fname = sprintf ('ORL//s%d//%d.pgm',i,j);
        im = double(imread(fname)); 
%         figure(1),
%         imshow(uint8(im))
         im2 =imresize(im,0.5);
%         figure(2),
%         imshow(uint8(im))
        %im1 = rotate(im,angle);
%         figure(3),
%         imshow(uint8(im1))
%         imr = im1(8:50,5:42);15
%                 imr = im1(14:56,5:42);30
        %imra = im1(24:88,12:80);
%         imr2 = imresize(im2,1);
        imr2=im2(11+transx:46+transx,9+transy:38+transy);
        % 34 28,45 37, 56 46, 68 56,79 65
       % 90,74 101 83 112 92 124 102 135 111
        
%         if(scale==0.6)
%             imr=imr2;
%         elseif scale==0.8
%                 imr = imr2(6:39,5:32);
%         elseif scale == 1
%                 imr =imr2(12:45,10:37);
%         elseif scale == 1.2
%                 imr = imr2(18:51,15:42);
%             else 
%                 imr = imr2(23:56,19:46);
%         end
        imrr=uint8(imr2);
%                 figure(4),
%         imshow(uint8(imr))
        imwrite(imrr,'C:/Users/Ameya/Desktop/BTP/originals/img'+string(i)+','+string(j)+'transx'+string(transx)+'transy'+string(transy)+'.jpg');
         trans = D*(imr2(:));
%         trip = sort(abs(trans),'descend');
        DCT_values = DCT_values + abs(trans);
        trans_ord = sort(trans,'descend');
        trans(trans<trans_ord(k)) = 0.0;
        trans(trans>=trans_ord(k)) = 1.0;
        DCT_count = DCT_count + trans;
%         A(:,count) = imr(:);
        end
    end
%     end
end
end
DCT_values = DCT_values/count;
DCT_count= DCT_count/count;
%%
inter1 = sort(DCT_values,'descend');
DCT_values(DCT_values>2500) = 2500;
figure(4),
plot(inter1(5:end))
DCT_values = t+(1.0-t)*DCT_values./max(DCT_values)+0.0*DCT_count./max(DCT_count);
inter2 = sort(DCT_values,'descend');
figure(5),
plot(inter2(5:end))
toc