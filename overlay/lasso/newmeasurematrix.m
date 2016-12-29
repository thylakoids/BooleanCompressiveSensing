%generate measurement matrix for the six round(123)
%=======================
rand('seed',333);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
drugNumber=28;
p=0.5;
filefold='experiment28';%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mkdir(filefold);
%++++++++++++++++++++++++
A_m=zeros(27*3,drugNumber);
for i=1:27*3
    matrix=zeros(1,drugNumber);
    experiment=randperm(drugNumber,round(drugNumber*p));
    experiment=sort(experiment);
    matrix(experiment)=1;
    A_m(i,:)=matrix;
end
A_m=A_m*10;
dmem1=ones(27*3,1)*300;
dmem2=dmem1;
dmem3=1000-sum(A_m')'-600;
A=[A_m dmem1 dmem2 dmem3];

for i=1:3
xlswrite([filefold '\' filefold '.xls'],A);
copyfile('worklist empty.xls','worklist round1_1.xls');
xlswrite('worklist round1_1.xls',A((27*(i-1)+1):27*i,:),1,'C2:AD28');
xlswrite('worklist round1_1.xls',[dmem1 dmem2 dmem3],1,'AJ2:AL28');
round1_1=copyfile('worklist round1_1.xls',[filefold '\' filefold '_' num2str(i) '.xls']);
end