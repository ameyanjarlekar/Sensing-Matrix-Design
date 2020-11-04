tic
max_iter = 1;
avg_error_ntransy_300 = zeros(3,10,5);
avg_psnr_ntransy_300 = zeros(3,10,5);
avg_ssim_ntransy_300 = zeros(3,10,5);
avg_immse_ntransy_300 = zeros(3,10,5);

%D =  kron(dctmtx(56),dctmtx(46));
for first=38:40
    first
    for second = 1:10
        second
       ang =0;
fname = sprintf ('ORL//s%d//%d.pgm',first,second);
test_img = double(imread(fname)); 
test_img2 = imresize(test_img,0.5);
% for angle=0:10:50
 for transx=0:5:0
     transx
     for transy=-8:4:8
    ang = ang+1;
    transy
    err = 0;
    psnr_err=0;
    ssim_err=0;
    immse_err=0;
% test_img1 = rotate(test_img,angle);
% test_int = test_img1(24:88,12:80);
% test_small = imresize(test_int,0.5);
        test_small = test_img2(11+transx:46+transx,9+transy:38+transy);
        % 34 28,45 37, 56 46, 68 56,79 65
       % 90,74 101 83 112 92 124 102 135 111
        
%         if(scale==0.6)
%             test_small=timr2;
%         elseif scale==0.8
%                 test_small = timr2(6:39,5:32);
%         elseif scale == 1
%                 test_small =timr2(12:45,10:37);
%         elseif scale == 1.2
%                 test_small = timr2(18:51,15:42);
%             else 
%                 test_small = timr2(23:56,19:46);
%         end
% figure(1),
% imshow(uint8(test_small))
for iter = 1:max_iter
    x = zeros(1,d);
%ran = randperm(d);
%sensing = I(ran(1:measurements),:)*(inv(sqrt(s)))*u;
%y = sensing*(test_small(:));
% y = P_mm*(test_small(:));
Pr = randn(measurements,d);
y = P_mm*(test_small(:));
% A = matrixa(P);
% At = matrixb(P);
%x = omp(k,y,sensing*D');
%x = omp(k,y,P*D');%x = algo({A,At},y',k,[]);
err_val = 100000000;
P = randn(measurements/20,d);
y_cv = P*(test_small(:));
% chance=2;
% for k=200:50:measurements-100
x = omp(measurements-5,y,P_mm*D',y_cv,P);
% erra = y_cv-P*D'*xref';
% if (-norm(erra(:))+err_val)/err_val > 0.01
% err_val = norm(erra(:));
% mem=k;
% x = xref;
% else
%     chance = chance-1;
%     if chance==0
%     break;
%     end
% end
% mem
%     out = reshape(x',56,46);
%     a = out(1:28,1:23);
%     b = out(1:28,24:46);
%     c = out(29:56,1:23);
%     d = out(29:56,24:46);
% x1 = OMPcv(y,P_mm,0.001,measurements-10,y_cv,P);
predimg = reshape(D'*x',[36,30]);
% predimg1 = reshape(D'*x1,[43,38]);

%predimg = idwt2(a,b,c,d,'haar');

% figure(2),
% imshow(uint8(predimg))
rmse = norm(test_small(:)-predimg(:))/norm(test_small(:));
err = err+rmse;
predimgm =uint8(predimg);
% imwrite(predimgm,'C:/Users/Ameya/Desktop/BTP/25octnorot/samp'+string(measurements)+'img'+string(first)+','+string(second)+'ang'+string(angle)+'.jpg');
test_smallm = uint8(test_small);
psnr_err=psnr_err+psnr(predimgm,test_smallm);
ssim_err=ssim_err+ssim(predimgm,test_smallm);
immse_err=immse_err+immse(predimgm,test_smallm)/(34*28);
end
avg_error_ntransy_300(first-37,second,ang) = err/max_iter;
avg_psnr_ntransy_300(first-37,second,ang) = psnr_err/max_iter;
avg_ssim_ntransy_300(first-37,second,ang) = ssim_err/max_iter;
avg_immse_ntransy_300(first-37,second,ang) = immse_err/max_iter;
    end
end
    end
end
toc