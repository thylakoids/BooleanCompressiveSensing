clc
clear
close all
load ..\data
x=measure_matrix;
y=measure_result;
x=x2fx(x,'interaction');
x=x(:,2:end);
[B FitInfo]=lasso(x,y,'CV',88);
plottype={'CV','L1','lambda'};
for i=1:3
    lassoPlot(B,FitInfo,'PlotType',plottype{i});
end
y_hat=FitInfo.Intercept(FitInfo.IndexMinMSE)+x*B(:,FitInfo.IndexMinMSE);
plotyyhat(y,y_hat);


betaname=drugIndex(drug_7);
chooseindex=find(B(:,FitInfo.IndexMinMSE));
drug_choose=union([],betaname(chooseindex,:));
betaname(chooseindex,:);