clear all;
close all;
clc;

load usa.txt;

Y = usa(:,1); 
X = usa(:,2:14);

Y = centre(Y);
X = normalise(X);

[B,S] = lasso(X,Y);