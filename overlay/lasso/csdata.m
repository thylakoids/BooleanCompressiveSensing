close all
load ..\data
x=measure_matrix;
y=measure_result;
x=x2fx(x,'interaction');
beta=compSen2(x,y,0.005)
plot(beta(2:end))
y_hat=x*beta;
R=plotyyhat(y,y_hat);