clc
clear
close all
load data4
[m,n]=size(measure_matrix);
fid1 = fopen('stepwise.txt', 'wt');
fid=[];
for i=1
trainrange=randperm(m-1,20);
trainrange=[trainrange+1 1];
train_matrix=measure_matrix(trainrange,:);
train_result=measure_result(trainrange);
predictpos=setdiff(1:m,trainrange);
%% compSen
x_hat=compSen2(train_matrix,train_result,0.5);
y_hat1=compSenPredict(measure_matrix,x_hat);
figure
plot(measure_result(predictpos),y_hat1(predictpos),'*');
R1=corrcoef(measure_result(predictpos),y_hat1(predictpos));
line([0,1],[0,1])
title(['CompSen R=' num2str(R1(1,2))])


iterm=nchoosek(1:n,2);
n_iterm=size(iterm,1);
iterm_single=[drug_7' drug_7'];
iterm=[-1 -1; iterm_single;iterm];
result_cs=[x_hat iterm];
result_cs=sortrows(result_cs,1)
fid=[fid;x_hat'];
%% stepwise
result=stepwiselm(train_matrix,train_result);
y_hat=result.predict(measure_matrix);
figure
plot(measure_result(predictpos),y_hat(predictpos),'*');
R=corrcoef(measure_result(predictpos),y_hat(predictpos));
line([0 1],[0,1])
title(['stepwise R=' num2str(R(1,2))])
fprintf(fid1, [result.Formula.LinearPredictor '\n']);
end
fclose(fid1)