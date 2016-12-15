clc
clear
close all
%% get the measure matrix and measure result
measurerange=[1:87];
measure_matrix1=xlsread('..\original_data_summary\round1.xlsx',1,'A1:CV27');
measure_result1=xlsread('..\original_data_summary\round1.xlsx',2);
measure_matrix2=xlsread('..\original_data_summary\round2.xlsx',1,'A1:CV27');
measure_result2=xlsread('..\original_data_summary\round2.xlsx',2);

measure_matrix3=xlsread('..\original_data_summary\generation1.xls',1,'A1:CV27');
measure_result3=xlsread('..\original_data_summary\generation1.xls',2);
measure_matrix4=xlsread('..\original_data_summary\generation2.xls',1,'A1:CV27');
measure_result4=xlsread('..\original_data_summary\generation2.xls',2);
measure_matrix5=xlsread('..\original_data_summary\generation3.xls',1,'A1:CV27');
measure_result5=xlsread('..\original_data_summary\generation3.xls',2);

figure 
plot(1:27,[measure_result1;measure_result2;measure_result3;measure_result4;measure_result5],'-*')
legend('round1','round2','generation1','generation2','generation3')
measure_matrix_all=[measure_matrix1;measure_matrix2(8:end,:);measure_matrix3(8:end,:);measure_matrix4(8:end,:);measure_matrix5(8:end,:)];
measure_result_all=[measure_result1 measure_result2(8:end) measure_result3(8:end) measure_result4(8:end) measure_result5(8:end) ];
measure_matrix=measure_matrix_all(measurerange,:);
measure_result=measure_result_all(measurerange);

%% contruct A and y
measure_matrix(measure_matrix>0)=1;
A=[];
for col= measure_matrix'
    A=[A;single2combination(col)'];
end
y=measure_result';
%% solve
[m,n]=size(A);
cvx_begin
    variable x_hat(n,1);
    minimize(norm(x_hat,1));
    subject to
    A*x_hat==y;
cvx_end 
plot(x_hat,'g'),title('x\_hat')
