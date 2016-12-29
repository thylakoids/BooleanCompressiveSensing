clc
clear
close all
load data5
% measure_matrixl=measure_matrix(:,[9 12 13 14 15 17 18 19 23 26]); %for data5
% measure_matrixl=measure_matrix(:,[26 17 19 ]); %for data5
measure_matrixl=measure_matrix(:,[44 55 ]); %for data4

[m,n]=size(measure_matrixl);
trainrange=randperm(m-1,23);
trainrange=1:20;
trainrange=[trainrange+1 1];
xl=measure_matrixl(trainrange,:);
x=measure_matrix(trainrange,:);
y=measure_result(trainrange);
predictpos=setdiff(1:m,trainrange);

xsl=measure_matrixl;
xs=measure_matrix;
ys=measure_result;
meanfunc=@meanConst; hyp.mean=[1];
covfunc=@covSEiso ;ell = 1/4; sf = 1; hyp.cov = log([ell; sf]);
covfunc=@covSEard ;ell = rand(size(xl,2),1); sf = 1; hyp.cov = log([ell; sf]);
likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, xl, y);
[mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, xl, y,xsl);

%%
f = [mu+2*sqrt(s2) ;flipdim(mu-2*sqrt(s2),1)];
fill([(1:28)'; (flipdim(1:28,2))'], f, [7 7 7]/8);
hold on; plot(1:28, mu,'o'); 
plot(1:28, ys, '+')
figure
plot(mu(predictpos),ys(predictpos),'*');
R1=corrcoef(mu(predictpos),ys(predictpos));
r1=R1(1,2)
%%
train_matrix=xl;
train_result=y;
result=stepwiselm(train_matrix,train_result);
y_hat=result.predict(xsl);
figure
plot(measure_result(predictpos),y_hat(predictpos),'*');
R2=corrcoef(measure_result(predictpos),y_hat(predictpos));
r2=R2(1,2)