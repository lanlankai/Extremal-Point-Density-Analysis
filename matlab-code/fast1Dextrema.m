function [rt,Tau,ind]=fast1Dextrema(x,Tau)
%  [rt]=fast1Dextrema(x,Tau)
% rt is the local extreme ratio,

if strcmpi(class(x),'single')
    x=double(x);
end
Tau1=Tau;
Tau1(Tau1>0)=Tau1(Tau1>0)-1;
[rt,ind1]=fast1Dextremac(x,Tau1);
NTau=length(Tau);
ind=ind1*nan;
for i=1:NTau
    ind(1+fix(Tau(i)/2):end-fix(Tau(i)/2),i)=ind1(1:end-fix(Tau(i)/2)*2,i);
end

