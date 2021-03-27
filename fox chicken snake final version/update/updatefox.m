function [newfox,x] = updatefox(fox,chicken,snake,p,x,k)
%updatefox returns the new positions/speed of foxes

%% Parameters for the fox agents

usedGradient = "exp"; % can be 'basic' or 'exp'

%parameters for basic Gradient
foxParameters = [0 2 0 0 0];
chickenParameters = [-1 -3 0 0 0];
snakeParameters = [3 0 0 0 0];
wallParameters = [1 0 0 0 0];

%parameters for exponential Gradient
foxParam_exp = [2 1 1];
chickenParam_exp = [-25 0.25 -5];
snakeParam_exp = [5 0.8 -5];

% Threshold of the force saturation
threshold=[3 10];

% Dynamic behaviour
mu=15; % Damping factor (air resistance)
m=25;  % Mass of the agent
A=[0 0 1 0;0 0 0 1;0 0 -mu/m 0;0 0 0 -mu/m];
B=8*[0 0;0 0;1/m 0;0 1/m];
C=[1 1 1 1];
D=[];
sys=ss(A,B,C,D);
Ts=0.1;
sysd= c2d(sys,Ts,'zoh');
Ad=sysd.A; % Evolution matrix (pedestrian modelisation)
Bd=sysd.B;

%% Parameters for the fox agents
newfox=fox(:,:);
[foxNum,dim]=size(fox);
dim=dim-3;% ignore the team number, the current target number and the id
chickenNum=size(chicken,1);
snakeNum=size(snake,1);
U = []; % Command vector
V = []; % Speed vector

for i=1:foxNum
    % Gradient field calculation
    direction=zeros(1,dim);
    for j=1:foxNum % ignoring the base
        if j~=i
            if usedGradient == "basic"
               direction = direction - basicGradient(foxParameters,fox(i,1:dim),fox(j,1:dim));
            elseif usedGradient == "exp"
                direction = direction - expGradient(foxParam_exp ,fox(i,1:dim),fox(j,1:dim));
            end
        end
    end
    
    for j=1:chickenNum
        if usedGradient == "basic"
            direction = direction - basicGradient(chickenParameters,fox(i,1:dim),chicken(j,1:dim));
        elseif usedGradient == "exp"
            direction = direction - expGradient(chickenParam_exp, fox(i,1:dim), chicken(j,1:dim));
        end
    end
    
	for j=1:snakeNum
        if usedGradient == "basic"
            direction = direction - basicGradient(snakeParameters,fox(i,1:dim),snake(j,1:dim));
        elseif usedGradient == "exp"
            direction = direction - expGradient(snakeParam_exp, fox(i,1:dim), snake(j,1:dim));
        end  
    end
    direction = direction + wallGradient(wallParameters,fox(i,1:dim),p.SizeOfEnvironment);
    dist = norm(direction);
    
    update = saturate(dist,direction,threshold); % apply saturation to the command
    u=update';
    U=[U u];
    
    % Dynamic behaviour
    o=i-1;
    x(4*o+1:4*o+4, k) = Ad* x(4*o+1:4*o+4, k-1) + Bd*u;
    newfox(i,1:dim)=x(4*o+1:4*o+2, k)';
    
    V = [V x(4*o+3:4*o+4, k)]; % Speed vector
    

end

% numFig = 11;
% z = potentialField(foxParameters, chickenParameters, snakeParameters, wallParameters, fox, chicken, snake, p.SizeOfEnvironment, U, numFig);

end