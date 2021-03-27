function [newsnake,x] = updatesnake(fox,chicken,snake,p,x,k)
%updatesnake returns the new positions/speed of snakes

%% Parameters for the snake agents

usedGradient = "basic"; % can be 'basic' or 'exp'

%parameters for basic Gradient
foxParameters=[-1 -3 0 0 0];
chickenParameters=[2 3 0 0 0];
snakeParameters=[0 2 0 0 0];
wallParameters=[1 0 0 0 0];

% Threshold of the force saturation
threshold=[3 10];

% Dynamic behaviour
mu=3; % Damping factor (air resistance)
m=5;  % Mass of the agent
A=[0 0 1 0;0 0 0 1;0 0 -mu/m 0;0 0 0 -mu/m];
B=[0 0;0 0;1/m 0;0 1/m];
C=[1 1 1 1];
D=[];
sys=ss(A,B,C,D);
Ts=0.1;
sysd= c2d(sys,Ts,'zoh');
Ad=sysd.A; % Evolution matrix (pedestrian modelisation)
Bd=sysd.B;

%% Parameters for the snake agents
newsnake=snake(:,:);
[snakeNum,dim]=size(snake);
dim=dim-3;% ignore the team number and the current objective number
foxNum=size(fox,1);
chickenNum=size(chicken,1);
U = []; % Command vector
V = []; % Speed vector

for i=1:snakeNum
    % Gradient field calculation
    direction=zeros(1,dim);
    for j=1:foxNum
        direction = direction - basicGradient(foxParameters,snake(i,1:dim),fox(j,1:dim));
    end
    for j=1:chickenNum
        direction = direction - basicGradient(chickenParameters,snake(i,1:dim),chicken(j,1:dim));
    end
    for j=1:snakeNum % ignoring the base
        if j~=i
        direction = direction - basicGradient(snakeParameters,snake(i,1:dim),snake(j,1:dim));
        end
    end
    direction = direction + wallGradient(wallParameters,snake(i,1:dim),p.SizeOfEnvironment);
    dist = norm(direction);

    update = saturate(dist,direction,threshold); % apply saturation to the command
    u=update';
    U=[U u];
    
    % Dynamic behaviour
    o=i-1;
    x(4*o+1:4*o+4, k) = Ad* x(4*o+1:4*o+4, k-1) + Bd*u;
    newsnake(i,1:dim)=x(4*o+1:4*o+2, k)';
    
    V = [V x(4*o+3:4*o+4, k)]; % Speed vector
end

% numFig = 12;
% z = potentialField(foxParameters, chickenParameters, snakeParameters, wallParameters, fox, chicken, snake, p.SizeOfEnvironment, U, numFig);

end
