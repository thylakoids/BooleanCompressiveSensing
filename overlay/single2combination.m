function yy=single2combination(col)
[m,n]=size(col);
if n~=1
    col=col'
end
yy2=nchoosek(col,2);
yy2=yy2(:,1).*yy2(:,2);
yy=[col; yy2];
end