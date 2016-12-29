function yy=compSen2(measure_matrix,measure_result,alpha)
if nargin==2
    alpha=0.1;
end
A=measure_matrix;
y=measure_result;
%% solve
[m,n]=size(A);
cvx_begin
    variable x_hat(n,1);
    minimize(alpha*norm(x_hat,1)+norm(A*x_hat-y,2)/(2*m));
cvx_end 
yy=x_hat;