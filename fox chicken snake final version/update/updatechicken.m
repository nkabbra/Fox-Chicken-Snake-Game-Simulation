function [newchicken,x,infoPlot] = updatechicken(fox,chicken,snake,p,x,k, infoPlot)
%updatechicken returns the new positions/speed of chicken

%% Parameters for the chicken agents

usedGradient = "exp"; % can be 'basic' or 'exp'

%parameters for Basic Gradient
foxParameters=[0 -3 0 0 0];
chickenParameters=[0 2 0 0 0];
snakeParameters=[-1 -3 0 0 0];
wallParameters=[1 0 0 0 0];

%parameters for exponential Gradient
foxParam_exp = [20 0.7 1];
chickenParam_exp = [2 1 1];
snakeParam_exp = [-20 0.3 -5];

% Threshold of the force saturation
threshold=[3 10];

% Dynamic behaviour
mu=3; % Damping factor (air resistance)
m=3;  % Mass of the agent
A=[0 0 1 0;0 0 0 1;0 0 -mu/m 0;0 0 0 -mu/m];
B=2*[0 0;0 0;1/m 0;0 1/m];
C=[1 1 1 1];
D=[];
sys=ss(A,B,C,D);
Ts=0.1;
sysd= c2d(sys,Ts,'zoh');
Ad=sysd.A; % Evolution matrix (pedestrian modelisation)
Bd=sysd.B;

%function's body
newchicken=chicken(:,:);
[chickenNum,dim]=size(chicken);
dim=dim-3;% ignore the team number and the current objective number
foxNum=size(fox,1);
snakeNum=size(snake,1);

V = []; % Speed vector

for i=1:chickenNum

    direction=zeros(1,dim);
    modx=0;
    mody=0;
    for j=1:foxNum
        if usedGradient == "basic"
            direction=direction - basicGradient(foxParameters,chicken(i,1:dim),fox(j,1:dim));
        elseif usedGradient == "exp"
            direction = direction - expGradient(foxParam_exp ,chicken(i,1:dim),fox(j,1:dim));
        end
    end
    
    for j=1:chickenNum% ignoring the base
        if j~=i
            if usedGradient == "basic"
                direction=direction - basicGradient(chickenParameters,chicken(i,1:dim),chicken(j,1:dim));
            elseif usedGradient == "exp"
                direction = direction - expGradient(chickenParam_exp, chicken(i,1:dim), chicken(j,1:dim));
            end
        end
    end
  
    for j=1:snakeNum
        if usedGradient == "basic"
            direction = direction - basicGradient(snakeParameters,chicken(i,1:dim),snake(j,1:dim));
        elseif usedGradient == "exp"
            direction = direction - expGradient(snakeParam_exp, chicken(i,1:dim), snake(j,1:dim));
        end
    end
    direction= direction + wallGradient(wallParameters,chicken(i,1:dim),p.SizeOfEnvironment);
    dist=norm(direction);
    
    update = saturate(dist,direction,threshold);
    u=update';
    infoPlot.U_chicken =[infoPlot.U_chicken u]; % Store chicken command
    
    % Dynamic behaviour
    o=i-1;
    x(4*o+1:4*o+4, k) = Ad* x(4*o+1:4*o+4, k-1) + Bd*u;
    newchicken(i,1:dim)=x(4*o+1:4*o+2, k)';
    
    V = [V x(4*o+3:4*o+4, k)];

end

numFig = 10;
if infoPlot.plotChickenPot
    infoPlot = expField(foxParam_exp, chickenParam_exp, snakeParam_exp, wallParameters, fox, chicken, snake, p.SizeOfEnvironment, infoPlot, numFig);
end
% z = potentialField(foxParameters, chickenParameters, snakeParameters, wallParameters, fox, chicken, snake, p.SizeOfEnvironment, U, numFig);
end

