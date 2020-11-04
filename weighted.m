tic
I = eye(d);
D =  kron(dctmtx(36),dctmtx(30));
%[u s v] = svd(D*D');
%P_mm = I(1:measurements,:)*(inv(sqrt(s)))*u;
%W = eye(d);
W = diag(DCT_values(:));
P_mm = rand(measurements,d);
for i=1:d
    P_mm(:,i) = P_mm(:,i)/norm(P_mm(:,i));
end
  phi = P_mm*D;
  err = W*(phi'*phi-I)*W;
error = (norm(err(:)))^2
prev_error = error+1.0;
  
D_hat = D*W;
[u_hat, s_hat, v_hat] = svd(D_hat);
while (prev_error - error) > 0.0001
  prev_error = error;
  G = W*D'*P_mm'*P_mm*D*W;
  H3 = eye(d);
  for i =1:d
    for j=1:d
      if (i==j)
        H3(i,j) = G(i,j) + W(i,j)^2;
      else
        H3(i,j) = G(i,j);
      end
    end
  end
  H = v_hat'*H3*v_hat;
  [u_h,s_h,v_h] = svd(H);
  P_mm = I(1:measurements,:)*sqrt(s_h)*u_h'*inv(sqrt(s_hat))*u_hat'/sqrt(2);
  phi = P_mm*D;
  err = W*(phi'*phi-I)*W;
  error = (norm(err(:)))^2
end
toc


