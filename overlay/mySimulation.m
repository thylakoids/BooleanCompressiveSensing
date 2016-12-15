n=5050;
sparsity=10;
pos=randperm(n,sparsity);
x=zeros(n,1);
x(pos)=rand(sparsity,1);
A=rand(80,n);
y=A*x;

%% solve
cvx_begin
    variable x_hat(n,1);
    minimize(norm(x_hat,1));
    subject to
    A*x_hat==y;
cvx_end 
subplot(211),plot(x,'r'),title('x')
subplot(212),plot(x_hat,'g'),title('x\_hat')