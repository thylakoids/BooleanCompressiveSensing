function yy=plotyyhat(y,y_hat)
figure
plot(y,y_hat,'*')
hold on
A=polyfit(y,y_hat,1);
R=corrcoef(y,y_hat);
z=polyval(A,y);
yy=R(1,2);
tmp=0:0.1:1;
plot(tmp,tmp,'g',y,z,'r')%线性拟合曲线
title(['R=' num2str(yy)]);