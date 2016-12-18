clc
clear 
close all
load data4
for alpha=0.5;
comR=[];
N_rep=5
for i=1:N_rep
figure(1)
[m,n]=size(measure_matrix);
trainrange=randperm(m-1,23);
trainrange=[trainrange+1 1];
train_matrix=measure_matrix(trainrange,:);
train_result=measure_result(trainrange);
predictpos=setdiff(1:m,trainrange);
%% compSen2
x_hat2=compSen2(train_matrix,train_result,alpha);
y_hat2=compSenPredict(measure_matrix,x_hat2);
subplot(221)
plot(measure_result(predictpos),y_hat2(predictpos),'*');
R2=corrcoef(measure_result(predictpos),y_hat2(predictpos));
line([0,1],[0,1])
title(['CompSen2 R=' num2str(R2(1,2))])
%% compSen
x_hat=compSen(train_matrix,train_result);
y_hat1=compSenPredict(measure_matrix,x_hat);
subplot(223)
plot(measure_result(predictpos),y_hat1(predictpos),'*');
R1=corrcoef(measure_result(predictpos),y_hat1(predictpos));
line([0,1],[0,1])
title(['CompSen R=' num2str(R1(1,2))])

%%
subplot(222)
plot(1:size(x_hat,1),x_hat2')
title('x\_hat2')
subplot(224)
plot(1:size(x_hat,1),x_hat')
title('x\_hat')


comR=[comR;R2(1,2) R1(1,2)];
end
figure
plot(1:N_rep,comR')
legend('2','1')
title(num2str(alpha))
end