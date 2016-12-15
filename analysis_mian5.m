clc
clear
close all

measure_matrix1=xlsread('original_data_summary\generation4.xls',1,'A1:CV27');
drug_7=measure_matrix1(7,:);
drug_7=find(drug_7);
N_item=nchoosek(1:28,3);
cutvalue=[0.39 0.39];


measure_matrix=xlsread('original_data_summary\generation5.xls',1,'A1:AB27');
measure_result=xlsread('original_data_summary\generation5.xls',2);
figure
plot(1:27,measure_result,'-*')
title('28 drugs')
L1=line([1 27],[cutvalue(1) cutvalue(1)]);
L2=line([1 27],[cutvalue(2) cutvalue(2)]);
%%
measure_count=size(measure_result,2);
positive=[];
candidate=N_item;
for i=1:measure_count
    experiment=measure_matrix(i,:);
    if measure_result(i)<cutvalue(1)
        positive=[positive;experiment];
    elseif measure_result(i)>cutvalue(2)
        experiment=find(experiment);
        candidate=setdiff(candidate,nchoosek(experiment,3),'rows');
    end
end

A=[];
for tmp_positive=positive'
    tmp_positive=find(tmp_positive);
    Ai=[];
    for tmp_candidate=candidate'
        if size(intersect(tmp_positive,tmp_candidate),1)==3
            Ai=[Ai,1];
        else
            Ai=[Ai,0];
        end
    end
    A=[A;Ai];
end
[m,n]=size(A);
%% solve
cvx_begin
    variable x_hat(n,1);
    minimize(norm(x_hat,1));
    subject to
    x_hat>=0;
    x_hat<=1;
    A*x_hat>=1;
cvx_end 
figure
plot(x_hat,'g-*'),title('x\_hat')
yy=candidate(x_hat>0.1,:);
result=drug_7(yy)
