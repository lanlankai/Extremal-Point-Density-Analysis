function [rt,EPD]=EPD_1d(x,Tau)
% rt=EPD_1d(x,Tau)
% Intput:
% x is the one dimension data to be analyzed
% Tau is the window size, default Tau>0
% Output:
% rt is the location of the extremal points.
% 
%  The theoretical part, please read the follow paper by Yongxiang Huang et
%  al.,  PHYSICAL REVIEW E 96, 012215 (2017) Extremal-point density of scaling processes: From fractional Brownian motion to turbulence in one dimension.
% 
% The extremal point is defined as  x(t-1)<x(t)<x(t+1)  or vice verse.
% Here we consider a coarse grained case, the local extrema point then
% satisfies, ((x(j-Tau(i))<x(j)) && (x(j+1-Tau(i))>x(j+1))) || ((x(j-Tau(i))>x(j)) && (x(j+1-Tau(i))<x(j+1)))
% 
% With the new version of JIT of the Matlab, the pure m-code is already as
% fast as the mex in c.
% 
% To see the density:
% EPD=sum(rt,1)./(Nx-Tau)
% plot(Tau,EPD)
% 
% Written by Yongxiang HUANG. (yongxianghuang@gmail.com)
% 

Tau=Tau(Tau>0);
NT=length(Tau);
Nx=length(x);
rt=zeros(Nx,NT);

for i=1:NT
    for j=Tau(i)+1:Nx-Tau(i)
        if ((x(j-Tau(i))<x(j)) && (x(j+1-Tau(i))>x(j+1))) || ((x(j-Tau(i))>x(j)) && (x(j+1-Tau(i))<x(j+1)))
            rt(j,i)=1;
        end
    end
end
EPD=sum(rt,1)./(Nx-Tau);