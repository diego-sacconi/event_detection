clear all
close all
n=4;
f=@(x)(-100*(x(1)+1)^2-5*(x(2)+8)^2-25*x(3)^2-3*(x(4)+8)^2);
h=@(x)([15*x(1)+3*x(2)+5*x(3);-5*x(1)+7*x(2)+5*x(3)-4*x(4);5*x(1)+x(2)+10*x(3)+x(4);-5*x(1)-10*x(3)+2*x(4);10*x(1)-x(2)-10*x(3)-10;-10*x(1)-4*x(2)+40*x(3)+2*x(4)-5;15*x(1)-x(2)+5*x(3)+4*x(4)-5;-15*x(1)-5*x(2)-15*x(3)+6*x(4)-10;-4*x(4)-35]);
gradient_h=@(x)([15;3;5;0;-5;7;5;-4;5;1;10;1;-5;0;-10;2;10;-1;-10;0;-10;-4;40;2;15;-1;5;4;-15;-5;-15;6;0;0;0;-4]);
p=[0;-1;0;-1];
A=[[15 3 5 0];[-5 7 5 -4];[5 1 10 1];[-5 0 -10 2];[10 -1 -10 0];[-10 -4 40 2];[15 -1 5 4];[-15 -5 -15 6];[0  0 0 -4]];
b=[0;0;0;0;10;5;5;10;35];

[alpha,fval,exitflag,output,lambda]=linprog([1 0 0 0],A,b,[],[],[],[],[],optimset('Simplex','on','LargeScale','off','Display','off'));
S(1)=fval;
[alpha,fval,exitflag,output,lambda]=linprog([0 1 0 0],A,b,[],[],[],[],[],optimset('Simplex','on','LargeScale','off','Display','off'));
S(2)=fval;
[alpha,fval,exitflag,output,lambda]=linprog([0 0 1 0],A,b,[],[],[],[],[],optimset('Simplex','on','LargeScale','off','Display','off'));
S(3)=fval;
[alpha,fval,exitflag,output,lambda]=linprog([0 0 0 1],A,b,[],[],[],[],[],optimset('Simplex','on','LargeScale','off','Display','off'));
S(4)=fval;
[alpha,fval,exitflag,output,lambda]=linprog(-[1 1 1 1],A,b,[],[],[],[],[],optimset('Simplex','on','LargeScale','off','Display','off'));
S(5)=-fval;
epsilon=0.01;
tol=1e-6;
[x_c,LB,UB,iter]=min_concave(f,h,gradient_h,S,n,p,epsilon,tol);

