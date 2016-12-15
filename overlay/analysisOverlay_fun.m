function yy=analysisOverlay_fun(measure_matrix,measure_result,flag)
measure_matrix(measure_matrix>0)=1;
A=[];
for col= measure_matrix'
    A=[A;single2combination(col)'];
end
y=measure_result';
%% solve
[m,n]=size(A);
if flag==1
    A=[ones(m,1) A];
    n=n+1;
end
cvx_begin
    variable x_hat(n,1);
    minimize(norm(x_hat,1));
    subject to
    A*x_hat==y;
cvx_end 
plot(x_hat,'g'),title('x\_hat')
yy=x_hat;