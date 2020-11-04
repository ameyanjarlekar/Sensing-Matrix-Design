% tic
% max_iter = 1;
% avg_error12 = zeros(4,10);
% %D =  kron(dctmtx(56),dctmtx(46));
% % [u s v] = svd(D*D');
% for first=37:40
%     for second = 1:10
% err = 0;
% fname = sprintf ('ORL//s%d//%d.pgm',first,second);
% test_img = double(imread(fname)); 
% % test_small = imresize(test_img,0.5);
% figure(1),
% imshow(uint8(test_img))
% pred_img = zeros(112,92);
% for iter = 1:max_iter
%     iter
% P = randn(measurements,d);
% for p=1:4
%     for q=1:4
%         test_small = test_img((p-1)*28+1:p*28,(q-1)*23+1:q*23);
% %ran = randperm(d);
% %sensing = I(ran(1:measurements),:)*(inv(sqrt(s)))*u;
% %y = sensing*(test_small(:));
% %y = P_mm*(test_small(:));
% y = Q*(test_small(:));
% %y = P*(test_small(:));
% %A = matrixa(P);
% %At = matrixb(P);
% %x = omp(k,y,sensing*D');
% x = omp(k,y,Q*D');
% %x = omp(k,y,P*D');
% %x = algo({A,At},y',k,[]);
% 
% %x = omp(k,y,P_mm*D');
% %     out = reshape(x',56,46);
% %     a = out(1:28,1:23);
% %     b = out(1:28,24:46);
% %     c = out(29:56,1:23);
% %     d = out(29:56,24:46);
% 
% predimg((p-1)*28+1:p*28,(q-1)*23+1:q*23) = reshape(D'*x',[28,23]);
% %predimg = idwt2(a,b,c,d,'haar');
%     end
% end
% % figure(2),
% % imshow(uint8(predimg))
% rmse = norm(test_img-predimg)/norm(test_img);
% err = err+rmse;
% end
% avg_error12(first-36,second) = err/max_iter;
%     end
% end
% 
% toc

tic
k=60;
% load('/net/voxel02/misc/me/ameyaa/sensing.mat');
max_iter = 1;
avg_error = zeros(4,10);
for first=37:40
    for second = 1:10
err = 0;
fname = sprintf ('ORL//s%d//%d.pgm',first,second);
impa = double(imread(fname));
test_img = impa(:,3:90); 
pred_img = zeros(112,88);
for iter = 1:max_iter
P = randn(measurements,d);
for p=1:8
    for q=1:8
        test_small = test_img((p-1)*14+1:p*14,(q-1)*11+1:q*11);

y = Q*(test_small(:));

x = omp(k,y,Q*D');


predimg((p-1)*14+1:p*14,(q-1)*11+1:q*11) = reshape(D'*x',[14,11]);
    end
end
rmse = norm(test_img-predimg)/norm(test_img);
err = err+rmse;
end
avg_error(first-36,second) = err/max_iter;
    end
end
save('/net/voxel02/misc/me/ameyaa/avgerror_normal.mat','avg_error');
toc