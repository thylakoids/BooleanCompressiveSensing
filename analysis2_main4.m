clc
clear
close all

measure_matrix1=xlsread('original_data_summary\round1.xlsx',1,'A1:CV27');
drug_7=measure_matrix1(7,:);
drug_7=find(drug_7);

M=27;
N=nchoosek(55,3);
N_item=nchoosek(1:55,3);
cutvalue=[0.30 0.30];
cutvalue(1)=0.3;%%%%%%%%%%%%


measure_matrix=xlsread('original_data_summary\generation4.xls',1,'A1:CV27');
measure_result=xlsread('original_data_summary\generation4.xls',2);
%% construct measurement matrix A
A=[];
for experiment = measure_matrix'
    experiment_comb=nchoosek(experiment,3);
    t=experiment_comb;
    A=[A;(t(:,1).*t(:,2).*t(:,3))'];
end
A(A>0)=1;
