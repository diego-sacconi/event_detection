clear all
close all
n=2;
f=@(x)(-(x(1)-x(2))^2/(2*x(1)));
h=@(x)([-28*x(1)+9*x(2)+21;9*x(1)^2-72*x(1)+16*x(2)^2;64*x(1)^2-192*x(1)-36*x(2)+153]);
gradient_h=@(x)([-28;9;18*x(1)-72;32*x(2);128*x(1)-192;-36]);
p=[2;1];
S=[0.5;0;6];
epsilon=0.01;
tol=1e-2;

[x_c,LB,UB,iter]=min_concave(f,h,gradient_h,S,n,p,epsilon,tol);

