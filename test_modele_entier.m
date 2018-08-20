clear all;
close all;
clc;

load usa.txt;

Y = usa(:,1);
n = size(Y);
n = n(1);

phi = [ones(n,1) usa(:,2:14)];
beta_hat= inv(phi'*phi)*phi'*Y;
Y_hat = phi*beta_hat;
e = Y-Y_hat;
p = size(phi);
p = p(2)-1;
sig_hat = sqrt(e'*e/(n-p-1))
RSS = e'*e;
d = p;
AIC = (RSS/(sig_hat^2)) +2*d; %+ const ?
BIC = n*log(RSS/n)+log(n)*d; %+ const ?

