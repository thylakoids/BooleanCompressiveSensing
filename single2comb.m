%convert real experiment(single drug) to combination(3) form
function test_comb=single2comb(test)
global N
test_comb=zeros(1,N);
combination=nchoosek(test,3);
for tmp=combination'
    a=tmp(1)-1;
    b=tmp(2)-1;
    c=tmp(3)-1;
    index=(9900*a-199*a*(a+1)/2+a*(a+1)*(2*a+1)/6)/2+(198-a-b)*(b-a-1)/2+c-b;
    test_comb(index)=1;
end


