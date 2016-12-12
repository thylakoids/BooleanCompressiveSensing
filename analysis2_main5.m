clc
clear
close all

measure_matrix1=xlsread('original_data_summary\generation4.xls',1,'A1:CV27');
drug_7=measure_matrix1(7,:);
drug_7=find(drug_7);
N_item=nchoosek(1:28,3);
cutvalue=[0.33 0.33];


measure_matrix=xlsread('original_data_summary\generation5.xls',1,'A1:AB27');
measure_result=xlsread('original_data_summary\generation5.xls',2);
figure
plot(1:27,measure_result,'-*')
title('28 drugs')
L1=line([1 27],[cutvalue(1) cutvalue(1)]);
L2=line([1 27],[cutvalue(2) cutvalue(2)]);

