clc
clear
close all
load data4%%%%%%%%%%%%%%%%%%%%%%%


%% use compSen2 to choose drug
[m,n]=size(measure_matrix);
x_hat=compSen2(measure_matrix,measure_result,0.5);
plot(x_hat)
iterm=nchoosek(1:n,2);
iterm_single=[(1:n)' (1:n)'];
iterm=[-1 -1; iterm_single;iterm];
result_cs=[x_hat iterm];
result_cs=sortrows(result_cs,1);


a=result_cs(result_cs(:,1)<-0.02,2:3);
b=result_cs(result_cs(:,1)>0.02,2:3);
drug_choose=union(a,b);
drug_choose__=drug_choose(2:end);
drug_100=drug_7(drug_choose__);
%%%%%%%%%%%%%%%%%%%%%%%%%
Rcount=[];
for count=1:10
% %% gp
% load data4
% measure_matrix=measure_matrix(:,drug_choose);
% [m,n]=size(measure_matrix);
% trainrange=randperm(m-1,m-7);
% %trainrange=1:(m-8);
% trainrange=[trainrange+1 1];
% x=measure_matrix(trainrange,:);
% y=measure_result(trainrange);
% predictpos=setdiff(1:m,trainrange);
% xs=measure_matrix;
% ys=measure_result;
% 
% meanfunc=@meanZero; hyp.mean=[];
% %covfunc=@covSEiso ;ell = 1/4; sf = 1; hyp.cov = log([ell; sf]);
% covfunc=@covSEard ;ell = 10*rand(size(x,2),1); sf = 1; hyp.cov = log([ell; sf]);
% likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
% hyp2 = minimize(hyp, @gp, -50000, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
% [mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y,xs);
% 
% f = [mu+2*sqrt(s2) ;flipdim(mu-2*sqrt(s2),1)];
% fill([(1:m)'; (flipdim(1:m,2))'], f, [7 7 7]/8);
% hold on; plot(1:m, mu,'o'); 
% plot(1:m, ys, '+')
% figure
% plot(mu(predictpos),ys(predictpos),'*');
% R1=corrcoef(mu(predictpos),ys(predictpos));
% r1=R1(1,2)
% 
%% step 
load data4
measure_matrix=measure_matrix(:,drug_choose__);
[m,n]=size(measure_matrix);
trainrange=randperm(m-1,m-7);
%trainrange=1:(m-8);
trainrange=[trainrange+1 1];
x=measure_matrix(trainrange,:);
y=measure_result(trainrange);
predictpos=setdiff(1:m,trainrange);
xs=measure_matrix;
ys=measure_result;
result=stepwiselm(x,y);
y_hat=result.predict(xs);
figure
plot(ys(predictpos),y_hat(predictpos),'*');
R1=corrcoef(ys(predictpos),y_hat(predictpos));
r1=R1(1,2)
%% stepwise all
load data4
drug_choose=1:55;
measure_matrix=measure_matrix(:,drug_choose);
[m,n]=size(measure_matrix);
trainrange=randperm(m-1,m-4);
%trainrange=1:(m-8);
trainrange=[trainrange+1 1];
x=measure_matrix(trainrange,:);
y=measure_result(trainrange);
predictpos=setdiff(1:m,trainrange);
xs=measure_matrix;
ys=measure_result;

result=stepwiselm(x,y);
y_hat=result.predict(xs);
figure
plot(ys(predictpos),y_hat(predictpos),'*');
R2=corrcoef(ys(predictpos),y_hat(predictpos));
r2=R2(1,2)
Rcount=[Rcount [r1; r2]];
end
plot(1:count,Rcount);
legend('cs+sw','sw')