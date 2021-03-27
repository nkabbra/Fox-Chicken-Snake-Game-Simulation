function [ snake, xsnake ] = initsnake(SnakeNum,Dim,SizeOfEnvironment )
    % Agents informations
    snake=zeros(SnakeNum,Dim+3);
    sigma=min(abs(SizeOfEnvironment(1,1:Dim)-SizeOfEnvironment(2,1:Dim)))*0.06;% jitter term
    mu=0.6*[17 15];
    for i=1:SnakeNum
        snake(i,1:Dim)=mvnrnd(mu,sigma*eye(Dim)); %Set a random start position for the snake
        snake(i,Dim+1)=3; % agent team (3=snake)
        snake(i,Dim+2)=1; % agent target (1=fox)
        snake(i,Dim+3)=i; % agent number
    end
    
    % State Vector xchicken - contains the state of every snake agents
    vSnakeInit=0; % initial speed for the snake
    k=0;
    for i=1:SnakeNum
        xsnake(i+k:i+1+k,1)=snake(i,1:2)';              % position [x,y]
        xsnake(i+k+2:i+k+3,1)=[vSnakeInit,vSnakeInit]'; % speed [vx, vy]
        k=k+3;
    end
end
