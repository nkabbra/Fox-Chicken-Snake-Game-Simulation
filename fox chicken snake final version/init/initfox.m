function [ fox, xfox ] = initfox(FoxNum,Dim,SizeOfEnvironment)
    % Agents informations
    fox=zeros(FoxNum,Dim+3);
    sigma = min(abs(SizeOfEnvironment(1,1:Dim)-SizeOfEnvironment(2,1:Dim)))*.06;% jitter term
    mu=0.6*[0 15];
    for i=1:FoxNum
        fox(i,1:Dim)=mvnrnd(mu,sigma*eye(Dim)); %Set a random start position for the foxes
        fox(i,Dim+1)=1; % agent team
        fox(i,Dim+2)=2; % agent target
        fox(i,Dim+3)=i; % agent number
    end
    
    % State Vector xfox - contains the state of every fox agents
    vfoxinit=0; % initial speed for the fox
    k=0;
    for i=1:FoxNum
        xfox(i+k   : i+1+k, 1)=fox(i,1:2)';          % position [x,y]
        xfox(i+k+2 : i+k+3, 1)=[vfoxinit,vfoxinit]'; % speed [vx, vy]
        k=k+3;
    end
end
