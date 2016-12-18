function yy=compSen2(measure_matrix,measure_result,alpha)
A=extend2combination(measure_matrix);
y=measure_result;
%% solve
n=size(A,2);
cvx_begin
    variable x_hat(n,1);
    minimize((1-alpha)*norm(x_hat,1)+alpha*norm(A*x_hat-y,1));
cvx_end 
yy=x_hat;