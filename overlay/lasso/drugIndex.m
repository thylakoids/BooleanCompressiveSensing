function yy=drugIndex(drug_7)
[m,n]=size(drug_7);
if m==1
    drug_7=drug_7';
end
iterm1=[drug_7 drug_7];
iterm2=nchoosek(drug_7,2);
yy=[iterm1;iterm2];