%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MiB2 chapter 2 task
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all

%Adjust this  seed to generate different sets of pseudorandom numbers
rng(1)



%Define simulation parameters
T=10000; %total time - quite a large number is needed due to the rare event of switching.
n=0; %start in state 1 (A) 
t=0; %initial time

% define the rates. Since the process is simple, we can just use rates for
% + and - the number of bp, don't need a full K matrix
rate_plus = [0.1,10000,10000,10000,10000,10000,0];
rate_minus= [0,1000,1000,1000,1000,1000,1000];

%histogram to record occupancy
hist=zeros(7,1);

while t<T
%Implement gillespie update
    nold=n; %save the old state for sampling
    %find the transition rate out of the state
    rp = rate_plus(n+1); %don't forget, Matlab indexes from 1
    rm = rate_minus(n+1);
    totrate=rm+rp;
    %sample next transition time
    deltat = exprnd(1/totrate);
    t=t+deltat;
    %update state
    if rand<rp/totrate
        n=n+1;
    else
        n=n-1;
    end
    %Record the total time spent in state nold in the histogram. Note the
    %offset of Matlab indeces.
    hist(nold+1)=hist(nold+1)+deltat; 
end
%Normalize histogram
hist = hist/sum(hist)
%define x axis that starts at zero
xaxis=zeros(7,1);
for y=1:7
    xaxis(y)=y-1;
end
f1=figure(1);
bar(xaxis,hist);
%fraction bound:
pbound = 1-hist(1)
%% 

%Analytic estimate - calculate relative to the 0 state, then normalize.
hist_analytic=zeros(7);
hist_analytic(1)=1;
hist_analytic(2)=0.1/1000*hist_analytic(1);
for y=3:7
    hist_analytic(y)=hist_analytic(y-1)*10000/1000;
end
hist_analytic = hist_analytic/sum(hist_analytic)
f2 =figure(2);
bar(xaxis,hist_analytic);
pbound_analytic = 1-hist_analytic(1)
%Works, but you have to run for a long time.

%Increasing the number of base pairs? The n base pair state is 10x as likely
%as n-1. So as you increase the number of base pairs, you increase the
%ratio of bound:unbound by roughly a factor of 10. This is cooperative base
%pairing, because longer strands are more stable. 

%If long strands are stable, even though individual base pairs can break,
%this allows the chromosome to be stable whilst still permitting it to be
%locally accessible. 