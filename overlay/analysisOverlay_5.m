clc
clear
close all
constant=1;
linear=1;
solverange=[1:20];%%1-27
solverange=randperm(28,20);
%% read data
measure_matrix1=xlsread('..\original_data_summary\generation4.xls',1,'A1:CV27');
drug_7=measure_matrix1(7,:);
drug_7=find(drug_7);
measure_matrix=xlsread('..\original_data_summary\generation5.xls',1,'A1:AB27');
measure_result=xlsread('..\original_data_summary\generation5.xls',2);
[m,n]=size(measure_matrix);
%add control
measure_matrix=[zeros(1,n); measure_matrix];
measure_result=[1 measure_result];
%% target
y=measure_result';
%% construct A
measure_matrix(measure_matrix>0)=1;
A=[];
for col= measure_matrix'
    A=[A;single2combination(col,linear)'];
end
[m,n]=size(A);
if constant==1
    A=[ones(m,1) A];
    n=n+1;
end
%% solve
measure_matrix=measure_matrix(solverange,:);
measure_result=measure_result(solverange);
x_hat=analysisOverlay_fun([ measure_matrix],measure_result,constant,linear);
plot(x_hat,'g'),title('x\_hat')
%% result
iterm=nchoosek(drug_7,2);
n_iterm=size(iterm,1);

iterm_single=[drug_7' drug_7'];
if linear==1
    iterm=[-1 -1; iterm_single;iterm];
else
    iterm=[-1 -1;iterm];
end
result=[x_hat iterm];
result=sortrows(result,1)
%% predict
y_hat=A*x_hat;
figure
plot(1:28,[y';y_hat'],'-*')
legend('y','y\_hat')
