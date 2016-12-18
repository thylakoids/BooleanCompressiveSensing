function yy=compSen(measure_matrix,measure_result)
A=extend2combination(measure_matrix);
y=measure_result;
%% solve
n=size(A,2);
cvx_begin
    variable x_hat(n,1);
    minimize(norm(x_hat,1));
        subject to
    A*x_hat==y;
cvx_end 
yy=x_hat;