% K-fold cross validation %
clear all;
clc;
K_FOLD=5; 
addpath('./spasm/');
load usa.txt;
X=usa(:,2:size(usa,2));
n=size(X,1);
p=size(X,2);
Y=usa(:,1);
X = normalize(X);
Y = center(Y);
[beta_hat,info]=lasso(X,Y,0);
figure(1)
plot(info.lambda, beta_hat, '.-');
grid on;
axis([0 200 -75 250])
xlabel('\lambda'), ylabel('\beta', 'Rotation', 0)

%shuffle the data---------
kk = 1:n;
rdm_vect=randsample(kk,length(kk));
Y=Y(rdm_vect);
X=X(rdm_vect,:);
%-------------------------
size_fold=floor(n/K_FOLD);

for i=1:K_FOLD
    RSS=[];
    %To select the training(app for apprentissage) part and the validation(vld) part
    if i==1
        Y_app=Y(1:size_fold*(K_FOLD-1));
        Y_vld=Y(size_fold*(K_FOLD-1)+1:end);
        X_app=X(1:size_fold*(K_FOLD-1),:);
        X_vld=X(size_fold*(K_FOLD-1)+1:end,:);
     else
         Y_app=[Y(1:size_fold*(i-2)) ;Y(size_fold*(i-1)+1:end)];
         Y_vld=Y(size_fold*(i-2)+1:size_fold*(i-1));
         X_app=[X(1:size_fold*(i-2),:) ; X(size_fold*(i-1)+1:end,:)];
         X_vld=X(size_fold*(i-2)+1:size_fold*(i-1),:);
    end
    %-------------------------------------------------------------
    [beta_hat,info]=lasso(X_app,Y_app,0);
    for lambda_idx=1:size(beta_hat,2)
        Y_est=X_vld*beta_hat(:,lambda_idx);
        e=Y_vld-Y_est;
        RSS(end+1)=(e'*e)./size(Y_vld,1);
    end
    figure(2)
    hold all,
    plot(info.lambda,RSS); %draw differents figures on the same curve
    
    %Spline interpolation to sum RSS at the same lambda
    Lambda=linspace(0,50,10000);
    if i==1
        RSS_cumul = interp1(info.lambda,RSS,Lambda,'spline');
    else
        RSS_cumul=interp1(info.lambda,RSS,Lambda,'spline')+RSS_cumul;
    end
    
end
xlabel('\lambda'), ylabel('RSS', 'Rotation', 0)

legend('FOLD-1','FOLD-2','FOLD-3','FOLD-4','FOLD-5',2);
figure(3)
plot(Lambda,RSS_cumul./K_FOLD);
xlabel('\lambda'), ylabel('RSS', 'Rotation', 0)
[minRSS_val,minRSS_idx]=min(RSS_cumul);

Lambda_min=Lambda(minRSS_idx)

