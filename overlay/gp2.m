clc
clear
close all
load data4
drug=[];
for i=1:55
[m,n]=size(measure_matrix);
trainrange=randperm(m-1,20);
trainrange=[trainrange+1 1];
predictpos=setdiff(1:m,trainrange);


xs=measure_matrix(:,i);
ys=measure_result;

x=xs(trainrange,:);
y=ys(trainrange);
n_train=size(x,2);
meanfunc=@meanZero; hyp.mean=[];
%covfunc=@covSEard ;ell = rand(n_train,1); sf = 1; hyp.cov = log([ell; sf]);
covfunc=@covSEiso ;ell = 1/4; sf = 1; hyp.cov = log([ell; sf]);
likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
[mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y,xs);
plot(1:28, mu,'o');
hold on 
plot(1:28,ys,'+');
drug=[drug;i var(mu)];
end
drug_choose=drug(drug(:,2)>1e-3,1);
