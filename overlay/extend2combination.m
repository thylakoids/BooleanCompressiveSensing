function yy=single2combination(matrix,constant,linear)
%extend a measure matrix to (constan + linear + interact)
switch nargin
    case 1
        constant=1;
        linear=1;
    case 2
        linear=1;
    case 3
    otherwise
        disp('Unknown parameters')
        return
end
yy=[];
for col=matrix';
interact=nchoosek(col,2);
interact=interact(:,1).*interact(:,2);
y=interact;
if linear==1
    y=[col; y];
end
if constant==1
    y=[1;y];
end
yy=[yy;y'];
end