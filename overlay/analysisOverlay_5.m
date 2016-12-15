clc
clear
close all
%%
measure_matrix1=xlsread('..\original_data_summary\generation4.xls',1,'A1:CV27');
drug_7=measure_matrix1(7,:);
drug_7=find(drug_7);
measure_matrix=xlsread('..\original_data_summary\generation5.xls',1,'A1:AB27');
measure_result=xlsread('..\original_data_summary\generation5.xls',2);
%% solve
[m,n]=size(measure_matrix);
%add control
measure_matrix=[zeros(1,n); measure_matrix];
measure_result=[1 measure_result];
x_hat=analysisOverlay_fun([ measure_matrix],measure_result,1);
plot(x_hat,'g'),title('x\_hat')
%% result
iterm=nchoosek(drug_7,2);
n_iterm=size(iterm,1);

iterm_single=[drug_7' drug_7'];
iterm=[-1 -1;iterm_single;iterm];
result=iterm((x_hat<-0.01) ,:)