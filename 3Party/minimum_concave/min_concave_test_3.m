clear all
close all
n=2;
f=@(x)(-3*x(1)^2-2*x(2)^2);
h=@(x)([-2*x(1)-3*x(2)+6;x(1)+x(2)-10;-x(1)+2*x(2)-8;x(1)-x(2)-4;-x(1);-x(2)]);
gradient_h=@(x)([-2;-3;1;1;-1;2;1;-1;-1;-1]);
p=[2;2];
S=[0;0;10];
epsilon=0.01;
tol=1e-2;
[x_c,LB,UB,iter]=min_concave(f,h,gradient_h,S,n,p,epsilon,tol);

