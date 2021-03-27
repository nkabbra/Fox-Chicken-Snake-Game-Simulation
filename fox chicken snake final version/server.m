%%##########################################################################
%                     FOX,CHICKEN,SNAKE GAME
%##########################################################################

% This is the main code that needs to be run to start the simulation

clc;
clear all;
close all;
addpath(genpath(pwd))

%% Set parameters for the simulation
%- p stand for parameters--------------------------------------------------
p.foxNum =4;        % Number of fox agents
p.chickenNum = 4;   % Number of chicken agents
p.snakeNum=4;       % Number of snake agents
p.ObjectiveNum = 4; % Score objectif
p.AgentSize=100;    % Size of agents in plot
p.Dimension=2;      % Select Dim (in theory can be set to 3 but might be buggy)

p.SizeOfEnvironment=[-4 -4 -4;15 15 15]; % Size of Environmet (MAX(X Y Z);MIN(X Y Z))
p.speed=.1;         % agents' speed (not applicabile if dynamic system applied)
p.radius=.25;       %  safety distance before getting catched
p.Max_It=10000;     % Max iteration of simulation
p.refreshRate=5;
p.display=true;

%- m stand for measures--------------------------------------------------
m.fox_score=0;
m.chicken_score=0; 
m.snake_score=0;   
num=[];
num(1)=p.foxNum ;
num(2)=p.chickenNum;
num(3)=p.snakeNum ;

%% 

%To view simulation with animal icons place  infoPlot.plotImg = true
infoPlot.plotImg = false;        % Show the simulation with animal icon faces

%To view simulation of potentiel field seen by chicken, place infoPlot.plotChickenPot = true
infoPlot.plotChickenPot = true;  % Show the simulation of the potential fields seen by chicken

%Note, it is not recommended to place both TRUE at the same time (either view icons simulation OR potentiel field simulation) 
%% 

%- All information related to plot-----------------------------------------

% infoPlot.plotFoxPot = false;     % (HS) Show the simulation of the potential fields seen by fox
% infoPlot.plotSnakePot = false;   % (HS) Show the simulation of the potential fields seen by snake
infoPlot.U_chicken = [];         % Command of every chicken agents (2*simTic)
infoPlot.U_fox = [];             % Command of every fox agents
infoPlot.U_snake = [];           % Command of every snake agents
infoPlot.track_chicken = [1 1 1 1]'; % Track of every chicken still in the game (1=alive, 0=dead)
infoPlot.track_fox = [1 1 1 1]';     % Track of every fox still in the game (1=alive, 0=dead)
infoPlot.track_snake = [1 1 1 1]';   % Track of every snake still in the game (1=alive, 0=dead)

% infoPlot.record = false;     % Record of simulation with a video (Warning: can induce memory overflow)
% infoPlot.Frame_img = [];     % List of frame simulation (with icon)
% infoPlot.Frame_chicken = []; % List of frame potential simulation (from the chicken perspective)

% Set up the plots environments
trollList.f = imread('fox-emoji.png');
trollList.c = imread('chicken.png');
trollList.s = imread('snake-emoji.png');

if infoPlot.plotImg
    figure(2)
    set(gcf,'position',[10,10,1920,1080]) % plot size window
end

if infoPlot.plotChickenPot
    figure(10)
    set(gcf,'position',[10,10,1920,1080]) % plot size window
end

%% Initialisation of the game

[fox, xfox, chicken, xchicken, snake, xsnake] = initMat(p); % Make 1st position of agents

%% Update agents position
% This codes update the position of agents and using the 'UpdatePos' function .

InstanceCnt=1;
displayCounter=0;
for it=1:p.Max_It
    displayCounter=displayCounter+1;
    if p.display && mod(displayCounter,p.refreshRate)==0

        InstanceCnt=InstanceCnt+1;

        [fox,xfox,chicken,xchicken,snake,xsnake,m,num,infoPlot] =UpdatePos(fox,chicken,snake,p,m,num,xfox,xchicken,xsnake,InstanceCnt, infoPlot);
        plotIconSimulation(infoPlot, fox, chicken, snake, m, num, trollList)
    end
end