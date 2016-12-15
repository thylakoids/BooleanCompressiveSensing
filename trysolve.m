sumA=sum(A);
lengthA=size(A,2);
sumA=[1:lengthA;sumA]';
sumAs=sortrows(sumA,-2);


yy=candidate(sumAs(1:3,1),:);
result=drug_7(yy)
