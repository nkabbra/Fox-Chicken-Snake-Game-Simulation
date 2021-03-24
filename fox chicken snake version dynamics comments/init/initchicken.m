function [ chicken, xchicken ] = initchicken(ChickenNum,Dim,SizeOfEnvironment )
    % Agents informations
    chicken=zeros(ChickenNum,Dim+3);
    sigma=min(abs(SizeOfEnvironment(1,1:Dim)-SizeOfEnvironment(2,1:Dim)))*.05;% jitter term
    mu=.2*SizeOfEnvironment(1,1:Dim)+.4*SizeOfEnvironment(2,1:Dim);
    for i=1:ChickenNum
        chicken(i,1:Dim)=mvnrnd(mu,sigma*eye(Dim)); %Set a random start position for the chicken
        chicken(i,Dim+1)=2; % agent team (2=chicken)
        chicken(i,Dim+2)=3; % agent target (3=snake)
        chicken(i,Dim+3)=i; % agent number
    end
    
    % State Vector xchicken - contains the state of every chicken agents
    vChickenInit=0; % initial speed for the chicken
    k=0;
    for i=1:ChickenNum
        xchicken(i+k:i+1+k,1)=chicken(i,1:2)';                % position [x,y]
        xchicken(i+k+2:i+k+3,1)=[vChickenInit,vChickenInit]'; % speed [vx, vy]
        k=k+3;
    end
end
