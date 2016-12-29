clc
clear
close all
load data5
[m,n]=size(measure_matrix);
r_lambda_all=[];
for lambda=0.001:0.001:0.009
for i=1:10
trainrange=randperm(m-1,80);
trainrange=[trainrange+1 1];
train_matrix=measure_matrix(trainrange,:);
train_result=measure_result(trainrange);
predictpos=setdiff(1:m,trainrange);
%% compSen
x_hat=compSen2(train_matrix,train_result,lambda);
y_hat1=compSenPredict(measure_matrix,x_hat);
R1=corrcoef(measure_result(predictpos),y_hat1(predictpos));
r_all(i)=R1(1,2);
end
r_lambda_all=[r_lambda_all mean(r_all)]
end


