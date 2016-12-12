clc
clear
close all
%%
measure_matrix1=xlsread('original_data_summary\generation4.xls',1,'A1:CV27');
drug_7=measure_matrix1(7,:);
drug_7=find(drug_7);

M=27;
N=nchoosek(28,3);
N_item=nchoosek(1:28,3);

cutvalue=[0.33 0.33];
cutvalue(1)=0.33;%%%%%%%%%%%%

measure_matrix=xlsread('original_data_summary\generation5.xls',1,'A1:AB27');
measure_result=xlsread('original_data_summary\generation5.xls',2);

%% construct measurement matrix A
A=[];
for experiment = measure_matrix'
    experiment_comb=nchoosek(experiment,3);
    t=experiment_comb;
    A=[A;(t(:,1).*t(:,2).*t(:,3))'];
end
A(A>0)=1;
%% comtruct measurement result y
y=measure_result;
y(y>=cutvalue(1))=0;
y(y>0)=1;
figure
plot(1:27,[measure_result;y],'-*')
title('28 drugs')
L1=line([1 27],[cutvalue(1) cutvalue(1)]);
L2=line([1 27],[cutvalue(2) cutvalue(2)]);
y=y';
%% recovery x_hat noise_hat from A,y
cvx_begin
    variable x_hat(N,1);
    variable noise_hat(M,1);
    minimize(norm(x_hat,1)+norm(noise_hat,1));
    subject to
    x_hat>=0;
    x_hat<=1;
    %noise_hat==zeros(M,1);
    noise_hat>=0;
    noise_hat(y>0)<=1;
    (A(y>0,:)*x_hat+noise_hat(y>0))  >=  y(y>0);
    A(y<1,:)*x_hat  ==   noise_hat(y<1);
cvx_end 
figure
plot(x_hat,'g-*'),title('x\_hat')
yy=N_item( x_hat>0.1,:);
result=drug_7(yy)
noisehat=sum(noise_hat)