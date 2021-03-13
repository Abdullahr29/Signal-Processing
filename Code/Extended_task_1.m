%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MiB2 chapter 1 task
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all

%Adjust this  seed to generate different sets of pseudorandom numbers
rng(1)


%% A
% See figure for embedded process

%% B
% Solution via evolution of the whole p-distribution 
%Define simulation parameters
N_steps=500; %total numbr of steps
p0=[1;0;0;0;0] %initial proability
%states are E,s,i,S,I in my notation.

koffs=1; %relative rate constants
kcat=0.1;
koffi=5;
% Transition matrix:
T= [
    0, koffs/(koffs+kcat), koffi/(koffi+kcat) ,0 ,0;
    0.5, 0, 0,0,0; 
    0.5, 0, 0,0 ,0; 
    0, kcat/(koffs+kcat), 0, 1,0;
    0, 0 kcat/(koffi+kcat),0, 1;
    ];

%Run T for N_steps and see where we end up.
p=p0;
n=0;
while n<N_steps
    p=T*p;
    n=n+1;
end
%returning the probability vector should tell us the probability of ending up in
%each state
p
%I get that the correct substrate is added approximately 82% of the time. 

%% C
%Generate 1000 sample trajectories, count the number of times binding occurs.
numTraj=10000;
tally=0; %track binding
for i = 1:numTraj
    currentState=1; %initialize current state.
    while currentState<4 % Run until state 4 or 5 is reached
        if currentState==1
            tally=tally+1; %if the current state is 1, a tRNA will bind in the next step
        end
        r =rand();
        ptotal=0; %use to record the cumulative probability when finding the next state
        for m=1:5
            ptotal=ptotal+T(m,currentState);
            if ptotal>r
                currentState=m; %update state appropriately
                break;
            end
        end
    end
end
tally=tally/numTraj %calcualte the average number of tRNA biding events per trajectory.
% I get approx 18
%% D 
%repeat with altered kcat. I get 67% accuracy and ~1.8 binding events per
%incorporation. So increasing kcat makes the process faster but worsens
%accuracy