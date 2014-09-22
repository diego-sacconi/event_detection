 function [x_c,LB,UB,iter]=min_concave(f,h,gradient_h,S,n,p,epsilon,tol)
% Author: Abla Kammoun / Avril 2012
% function [x_c,LB,UB,iter]=min_concave(f,h,gradient_h,S,n,p,epsilon,tol)
% Program for global minimization of a concave function
% Implementation of the algorithm of Harold. P Benson which can be found in the paper
% " A Branch and Bound-Outer Approximation Algorithm for Concave Minimization over a Convex Set"
% Function for global minimization of 
% min f(x) s.t. h(x)<=0
% n is the length of x
% S is a n+1 vector where s_j=min c_j'*h(x) for j=1:n et c_j(k)=delta(j,k) (delta(j,k)=1 si j=k et 0 sinon )
% S(n+1)=max \sum_{j=1}^n x_j subject to h(x)<=0;
% p is any feasible point
% epsilon is the stop criterion (stop if (UB-LB <epsilon)
% tol characterizes the tolerance of error, (x is feasible if and only if h(x)<=tol)
% The function outputs are x_c the value that achieves the global minimum, LB and UB are the lower and upper bounds of min f(x), x feasible, 
[nrow,ncol]=size(S);
assert(min([nrow,ncol])==1,'S must be a vector');
if (nrow==1) S=S'; end;
nplus1=length(S);
nVars=nplus1-1;
assert(nVars==n,'Number of Variables should be equal to n');
%assert(length(z_init)==n,'Number of elements of z_init should be equal to n');
assert(length(h(p)<=0)==length(h(p)),'z_init should be a feasible point');

V=S(1:n);
for k=1:n
S_b=S(1:n);
S_b(k)=[];
v_c=[S(1:k-1);S(end)-sum(S_b);S(k+1:end-1)];
V=[V,v_c];
end
maxh=@(x)[(max(h(x),0))];

Vplus=[V;ones(1,nVars+1)];
B=inv(Vplus);
A=[B(1:end,1:nVars)];
A=[A;-A];
b=B(:,end);
b=[1-b;b];
nconstraint=length(A);
constraint_to_keep=[];
for ii=1:nconstraint
if (length(find(abs(A(ii,:)*V-b(ii))<=1e-4))==n)
constraint_to_keep=[constraint_to_keep,ii];
end
end
A=A(constraint_to_keep,:);
b=b([constraint_to_keep]);

[row_s,col_s]=size(V);
for ii=1:col_s
fvec(ii,1)=f(V(:,ii));
end
Mat=[V' ones(n+1,1)];
enveloppe_convex=inv(Mat)*fvec;
Ai=A*V;
Aeq=ones(1,size(V,2));
lb=zeros(size(V,2),1);
[alpha,fval,exitflag,output,lambda]=linprog(enveloppe_convex(1:end-1)'*V,Ai,b,Aeq,1,lb,[],[],optimset('Simplex','on','LargeScale','off','Display','off'));
x=V*alpha;
UB=f(p);

LB=(enveloppe_convex(1:end-1))'*x+enveloppe_convex(end);
LB0=LB;
if ((f(x)<UB)&(max(h(x))<=tol)) UB=f(x); x_c=x; end
T{1}=V;
enveloppe_convex_cell_tab{1}=enveloppe_convex;
xvec{1}=x;
gvec(1)=LB;
index_T=1;
%for iter=1:30
%if (abs(UB-LB)<0.03) break; end;
iter=0;
epsilon
while (UB-LB > epsilon)
iter=iter+1;

if (max(h(xvec{index_T}))<=tol)
test_logic=1;
V=T{index_T};
x_c=xvec{index_T};
UB=f(x_c);
dist=0;
for ii=1:size(V,2)
Vii=V(:,ii);
	for jj=ii+1:size(V,2)
		Vjj=V(:,jj);
			if (dist <= norm(Vii-Vjj))
				dist=norm(Vii-Vjj);
				index_vectors=[ii,jj];
			end
	end
end
Vnew=(V(:,index_vectors(1))+V(:,index_vectors(2)))/2;
V1=V;
V1(:,index_vectors(1))=[];
V1=[V1 ,Vnew];
V2=V;
V2(:,index_vectors(2))=[];
V2=[V2,Vnew];
Tsub{1}=V1;
Tsub{2}=V2;
for ii=1:2
V=Tsub{ii};
	for jj=1:size(V,2)
		fvec(jj,1)=f(V(:,jj));
	end
	Mat=[V' ones(n+1,1)];
	enveloppe_convex=inv(Mat)*fvec;
%	enveloppe_convex_cell_tab_sub{ii}=enveloppe_convex;
	Ai=A*V;
	Aeq=ones(1,size(V,2));
	lb=zeros(size(V,2),1);
	[alpha,fval,exitflag,output,lambda]=linprog(enveloppe_convex(1:end-1)'*V,Ai,b,Aeq,1,lb,[],[],optimset('Simplex','on','LargeScale','off','Display','off'));
if (exitflag==1)
	x=V*alpha;
%	A*x-b
%	enveloppe_convex(1:end-1)'*x+enveloppe_convex(end)
%	gvec_sub{ii}=fval+enveloppe_convex(end);
%	xvec_sub{ii}=x;
	if (fval+enveloppe_convex(end)<=UB)
		T{length(T)+1}=V;
		enveloppe_convex_cell_tab{length(enveloppe_convex_cell_tab)+1}=enveloppe_convex;
		gvec(length(gvec)+1)=fval+enveloppe_convex(end);
		xvec{length(xvec)+1}=x;
	else
%	display('simplex not included');

	end
end
end

T(index_T)=[];
enveloppe_convex_cell_tab(index_T)=[];

gvec(index_T)=[];
xvec(index_T)=[];
else
test_logic=0;
lambda_etoile=fibonacciSearch(@(lambda)maxh(lambda*p+(1-lambda)*xvec{index_T}),0,1,1e-6);
z=lambda_etoile*p+(1-lambda_etoile)*xvec{index_T};
if (f(z)<=UB) UB=f(z);
x_c=z;
if (UB-LB<=epsilon) break; end;
end

gradient_x_tot=gradient_h(z);
[val_max,index_max]=max(h(z));
gradient_x=gradient_x_tot(n*(index_max-1)+1:n*(index_max-1)+n);
constant_term=gradient_x'*z;
A=[A;gradient_x.'];
b=[b;constant_term];
for ii=1:length(T)
if (ii~=index_T)
	Vii=T{ii};
	enveloppe_convex=enveloppe_convex_cell_tab{ii};
	Ai=A*Vii;
	Aeq=ones(1,size(Vii,2));
	lb=zeros(size(Vii,2),1);
	[alpha,fval,exitflag,output,lambda]=linprog(enveloppe_convex(1:end-1)'*Vii,Ai,b,Aeq,1,lb,[],[],optimset('Simplex','on','LargeScale','off','Display','off'));
	x=Vii*alpha;
	gvec(ii)=fval+enveloppe_convex(end);
	xvec{ii}=x;
end
end
V=T{index_T};
dist=0;
for ii=1:size(V,2)
Vii=V(:,ii);
	for jj=ii+1:size(V,2)
		Vjj=V(:,jj);
			if (dist <= norm(Vii-Vjj))
				dist=norm(Vii-Vjj);
				index_vectors=[ii,jj];
			end
	end
end
Vnew=(V(:,index_vectors(1))+V(:,index_vectors(2)))/2;
V1=V;
V1(:,index_vectors(1))=[];
V1=[V1 ,Vnew];
V2=V;
V2(:,index_vectors(2))=[];
V2=[V2,Vnew];
Tsub{1}=V2;
Tsub{2}=V1;
lengthT_before_sub=length(T);
%display('simplex division');
for ii=1:2
Vii=Tsub{ii};
	for jj=1:size(V,2)
		fvec(jj,1)=f(Vii(:,jj));
	end
	Mat=[Vii' ones(n+1,1)];
	enveloppe_convex=inv(Mat)*fvec;
%	enveloppe_convex_cell_tab_sub{ii}=enveloppe_convex;
	Ai=A*Vii;
	Aeq=ones(1,size(V,2));
	lb=zeros(size(V,2),1);
	[alpha,fval,exitflag,output,lambda]=linprog(enveloppe_convex(1:end-1)'*Vii,Ai,b,Aeq,1,lb,[],[],optimset('Simplex','on','LargeScale','off','Display','off'));
if (exitflag==1)
	x=Vii*alpha;
%	gvec_sub{ii}=fval+enveloppe_convex(end);
%	xvec_sub{ii}=x;
	if (fval+enveloppe_convex(end)<=UB)
		T{length(T)+1}=Vii;
		enveloppe_convex_cell_tab{length(enveloppe_convex_cell_tab)+1}=enveloppe_convex;
		gvec(length(gvec)+1)=fval+enveloppe_convex(end);
		xvec{length(xvec)+1}=x;
	else
%	display('simplex not included');
	end
end
end
T(index_T)=[];
enveloppe_convex_cell_tab(index_T)=[];
gvec(index_T)=[];
xvec(index_T)=[];
end
%%%%%%%% Deletion of simplices %%%%%%%%%
kk=1;
T_sub=[];
gvec_sub=[];
xvec_sub=[];
enveloppe_convex_sub=[];
kk=1;
for ii=1:length(T)
if (gvec(ii)<=UB)
T_sub{kk}=T{ii};
gvec_sub(kk)=gvec(ii);
xvec_sub{kk}=xvec{ii};
enveloppe_convex_sub{kk}=enveloppe_convex_cell_tab{ii};
kk=kk+1;
else
%display('simplex deletion');
end
end
T=T_sub;
gvec=gvec_sub;
xvec=xvec_sub;
enveloppe_convex_cell_tab=enveloppe_convex_sub;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[min_g,index_T]=min(gvec);
LB=min_g;

end
