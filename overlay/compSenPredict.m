function yy=compSen(measure_matrix,x_hat)
measure_matrix(measure_matrix>0)=1;
A=extend2combination(measure_matrix);
yy=A*x_hat;