% tic
% m = 500;
% n = 644;
% s = 200;
% Q = randn(m,n);
% x = zeros(n,n);
% iter = 10;
% lr = 0.01;
% for j=1:iter
%     loss = 0;
%     j
%     parfor i=1:n
%         Q_copy = randn(m,n);
%         Q_copy(:,:) = Q(:,:);
%         Q_copy(:,i) = [];
%         x_pre = zeros(n-1,1);
%         x_pre(:,1) = omp(s,Q(:,i),Q_copy);
%         loss = loss+norm(Q(:,i)-Q_copy*x_pre(:,1));
%         q = 1;
%         for p=1:n
%             if p==i
%                 x(p,i) = 1;
%             else
%                 x(p,i) = -x_pre(q,1);
%                 q = q+1;
%             end
%         end
%     end
%     loss
%     grad = zeros(m,n);
%     parfor i=1:n
%         grad = grad + Q*x(:,i)*x(:,i)';
%     end
%     Q = Q+lr*grad;
% end
% toc
%  tic
% %%
% % load('/net/voxel02/misc/me/ameyaa/DCT_values_clipped.mat');
% m = 100;
% n = 154;
% s = 60;
% Q = randi([0 1],m,n);
% D = kron(dctmtx(14),dctmtx(11));
% x = zeros(n,n);
% iter = 5;
% % lr = 0.1;
% % for p=1:2
% %     for q=1:2
% DCT_values = DCT_values*n/sum(DCT_values);
% curr_loss = 0;
% loss= 0;
% parfor i=1:n
%    A = Q*D;
%     A_copy = randn(m,n);
%     A_copy(:,:) = A;
%     A_copy(:,i) = [];
%     x_pre = zeros(n-1,1);
%     x_pre(:,1) = omp(s,A(:,i),A_copy);
%     loss = loss+DCT_values(i,1)*norm(A(:,i)-A_copy*x_pre(:,1));
%     %        loss = loss+norm(squeeze(Q(:,i,p,q))-Q_copy*x_pre(:,1));
%     q1 = 1;
%     for p1=1:n
%         if p1==i
%             x(p1,i) = 1;
%         else
%             x(p1,i) = -x_pre(q1,1);
%             q1 = q1+1;
%         end
%     end
% end
% curr_loss =loss;
% %     end
% % end
% for j=1:iter
%     j
%     for e=1:m
%         e
%         curr_loss
%         for f=1:n
%             Q(e,f) = 1-Q(e,f);            
%             loss = 0;
%             
%             parfor i=1:n
%                 A = Q*D;
%                 A_copy = randn(m,n);
%                 A_copy(:,:) = A;
%                 A_copy(:,i) = [];
%                 x_pre = zeros(n-1,1);
%                 x_pre(:,1) = omp(s,A(:,i),A_copy);
%                 loss = loss+DCT_values(i,1)*norm(A(:,i)-A_copy*x_pre(:,1));
%                 %        loss = loss+norm(squeeze(Q(:,i,p,q))-Q_copy*x_pre(:,1));
%                 q1 = 1;
%                 for p1=1:n
%                     if p1==i
%                         x(p1,i) = 1;
%                     else
%                         x(p1,i) = -x_pre(q1,1);
%                         q1 = q1+1;
%                     end
%                 end
%             end
%             
%             if(loss > curr_loss)
%                 curr_loss = loss;
%             else
%                 Q(e,f) = 1-Q(e,f); 
%             end
%         end
%     end
% end
% 
% % save('/net/voxel02/misc/me/ameyaa/sensing_normal.mat','Q');
% %%
% toc
% addpath '/net/voxel02/misc/me/ameyaa/spgl1-2.1'
% cd '/net/voxel02/misc/me/ameyaa/spgl1-2.1'
% spgsetup 
% cd '/net/voxel02/misc/me/ameyaa/'
% load('/net/voxel02/misc/me/ameyaa/DCT_values_clipped.mat');
tic
m = 100;
n = 154;
s = 60;
Q = randi([0 5],m,n)/5;
%save('/net/voxel02/misc/me/ameyaa/sensing3_normal_init.mat','Q');
D = kron(dctmtx(14),dctmtx(11));
% x = zeros(n,n);
iter = 5;
% lr = 0.1;
% for p=1:2
%     for q=1:2
DCT_values = DCT_values*n/sum(DCT_values);
curr_loss = 0;
prev_loss = 0;
loss = 10000;
opts = spgSetParms('verbosity',0);
parfor i=1:n
   A = Q*D;
    A_copy = randn(m,n);
    A_copy(:,:) = A;
    A_copy(:,i) = [];
    x_pre = zeros(n-1,1);
   % x_pre(:,1) = omp(s,A(:,i),A_copy);
   x_pre(:,1) = spg_lasso(A_copy,A(:,i),s-1,opts);
    %loss = loss+DCT_values(i,1)*norm(A(:,i)-A_copy*x_pre(:,1));
            loss = min(loss,norm(A(:,i)-A_copy*x_pre(:,1)));
%     q1 = 1;
%     for p1=1:n
%         if p1==i
%             x(p1,i) = 1;
%         else
%             x(p1,i) = -x_pre(q1,1);
%             q1 = q1+1;
%         end
%     end
end
curr_loss =loss;
%     end
% end
for j=1:iter
    if (curr_loss-prev_loss) < 0.00000001
        break;
    end
    prev_loss = curr_loss;
    j
    for e=1:m
        e
        curr_loss
        norm(Q)
        for f=1:n
            temp_loss = curr_loss;
            temp_var = Q(e,f);
            prev_val = Q(e,f);
            for step=0:0.2:1
                if prev_val == step
                    continue
                else
            Q(e,f) = step;            
            loss = 10000;            
            parfor i=1:n
                A = Q*D;
                A_copy = randn(m,n);
                A_copy(:,:) = A;
                A_copy(:,i) = [];
                x_pre = zeros(n-1,1);
                %x_pre(:,1) = omp(s,A(:,i),A_copy);
                   x_pre(:,1) = spg_lasso(A_copy,A(:,i),s-1,opts);
                %loss = loss+DCT_values(i,1)*norm(A(:,i)-A_copy*x_pre(:,1));
                        loss = min(loss,norm(A(:,i)-A_copy*x_pre(:,1)));
%                 q1 = 1;
%                 for p1=1:n
%                     if p1==i
%                         x(p1,i) = 1;
%                     else
%                         x(p1,i) = -x_pre(q1,1);
%                         q1 = q1+1;
%                     end
%                 end
            end
            if(loss > temp_loss)
                temp_loss = loss;
                temp_var = step;
            end
                end
            end
            Q(e,f) = temp_var;
            curr_loss = temp_loss;
        end
    end
end

%save('/net/voxel02/misc/me/ameyaa/sensing2_normal_fin.mat','Q');
%%
toc