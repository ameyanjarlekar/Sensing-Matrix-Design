% tic
% N = 40*8;
% Ntest = 40*2;
% d = 644;
% k = 200;
% measurements = 200;
% % A = zeros(d,N);
% id = zeros(N,1);
% count = 0;
% I = eye(d);
% D = kron(dctmtx(28),dctmtx(23));
% %D = kron(haarmtx(56),haarmtx(46));
% DCT_values = zeros(d,1);
% DCT_count = zeros(d,1);
% t = 0.1;
% for i=1:36
%     for j=1:10
%         for p=1:4
%             for q=1:4
%         fname = sprintf ('ORL//s%d//%d.pgm',i,j);
%         im = double(imread(fname)); 
%         count = count +1;
%         imr = im((p-1)*28+1:p*28,(q-1)*23+1:q*23);
%         %imr = imresize(im,0.5);
%         trans = D*(imr(:));
%         DCT_values = DCT_values + (trans).^2;
% %         trans_ord = sort(trans,'descend');
% %         trans(trans<trans_ord(k+50)) = 0.0;
% %         trans(trans>=trans_ord(k+50)) = 1.0;
% %         DCT_count = DCT_count + trans;
% %         A(:,count) = imr(:);
%     end
%         end
%     end
% end
% DCT_values = DCT_values/count;
% w= sort(DCT_values,'descend');
% % DCT_count= DCT_count/count;
% %%
% % sum(DCT_values>100)
% % sum(DCT_values>1000)
% % sum(DCT_values>10000)
% % sum(DCT_values>10)
% DCT_values(DCT_values>10000) = 10000;
% % inter1 = sort(DCT_values,'descend');
% % figure(4),
% % plot(inter1(5:end))
% DCT_values = t+(1.0-t)*DCT_values./max(DCT_values);
% %DCT_values = t+(1.0-t)*DCT_count./max(DCT_count);
% % inter2 = sort(DCT_values,'descend');
% % figure(5),
% % plot(inter2(5:end))
% toc



tic
N = 40*8;
Ntest = 40*2;
d = 154;
k = 60;
measurements = 100;
% A = zeros(d,N);
id = zeros(N,1);
count = 0;
I = eye(d);
D = kron(dctmtx(14),dctmtx(11));
DCT_values = zeros(d,1);
DCT_count = zeros(d,1);
t = 0.1;
for i=1:36
    for j=1:10
        fname = sprintf ('ORL//s%d//%d.pgm',i,j);
        imp = double(imread(fname)); 
        im = imp(:,3:90);
        for p=1:8
            for q=1:8
        count = count +1;
        imr = im((p-1)*14+1:p*14,(q-1)*11+1:q*11);
        %imr = imresize(im,0.5);
        trans = D*(imr(:));
        DCT_values = DCT_values+(trans).^2;
%         trans_ord = sort(trans,'descend');
%         trans(trans<trans_ord(k+50)) = 0.0;
%         trans(trans>=trans_ord(k+50)) = 1.0;
%         DCT_count = DCT_count + trans;
%         A(:,count) = imr(:);
    end
        end
    end
end
DCT_values = DCT_values/count;
 w= sort(DCT_values,'descend');
% DCT_count= DCT_count/count;
%%
% sum(DCT_values>100)
% sum(DCT_values>1000)
% sum(DCT_values>10000)
% sum(DCT_values>10)
DCT_values(DCT_values>10000) = 10000;
% inter1 = sort(DCT_values,'descend');
% figure(4),
% plot(inter1(5:end))
% for p=1:2
%     for q=1:2
DCT_values = t+(1.0-t)*DCT_values./max(DCT_values);
%     end
% end
%DCT_values = t+(1.0-t)*DCT_count./max(DCT_count);
% inter2 = sort(DCT_values,'descend');
% figure(5),
% plot(inter2(5:end))
% save('/net/voxel02/misc/me/ameyaa/DCT_values_clipped.mat','DCT_values');
toc