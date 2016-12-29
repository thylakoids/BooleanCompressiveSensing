%% read data
measure_matrix1=xlsread('..\original_data_summary\generation4.xls',1,'A1:CV27');
drug_7=measure_matrix1(7,:);
drug_7=find(drug_7);
measure_matrix=xlsread('..\original_data_summary\generation5.xls',1,'A1:AB27');
measure_result=xlsread('..\original_data_summary\generation5.xls',2);
main_fun(drug_7,measure_matrix,measure_result)
