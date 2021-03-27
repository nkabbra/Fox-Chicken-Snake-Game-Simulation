function [fox,chicken,snake,measures,num,xfox,xchicken,xsnake,infoPlot] = checkCollisions(fox,chicken,snake,p,measures,num,xfox,xchicken,xsnake,infoPlot)
% checkcheckCollisions deletes agents who exit the environment, and targets
% hit by trackers
radius=p.radius;
envSize=p.SizeOfEnvironment;
[foxNum,dim]=size(fox);
chickenNum=size(chicken,1);
snakeNum=size(snake,1);
dim=dim-3;



%% check captures for ...

% The foxes
chickenCatched = [];
for i = 1:foxNum
    for j = 1:chickenNum
        if norm(fox(i,1:dim)-chicken(j,1:dim)) < 2*radius
            chickenCatched = [chickenCatched j]
            xchicken(4*(j-1)+1:4*(j-1)+4,:)=[];
            num(2)= chickenNum-1;
            measures.fox_score = measures.fox_score+1;
        end
    end
end

if  measures.fox_score==4
    trolls = imread('fox-emoji.png');
          xlim([-4 15])
                ylim([-4 15])
                  hold on
                   plot(0,0,'o','MarkerSize',0.05);
    imagesc([80 110],[110 110],trolls);
 
    ims(1)=image(flipud(trolls), 'XData', [6-0.25 6+0.25], 'YData', [6-0.25 6+0.25]); 
    hold on
    legend('fox won !','Location','north')
    pause(0.1);
    plotGraph(infoPlot)
    throw(MException('Finished:TrackersVictory','Fox Won'));
end

% The Chickens
snakeCatched = [];
for i = 1:chickenNum
    for j = 1:snakeNum
        if norm(chicken(i,1:dim)-snake(j,1:dim)) < 2*radius
            snakeCatched = [snakeCatched j];
            xsnake(4*(j-1)+1:4*(j-1)+4,:)=[];
            num(3)=snakeNum-1;
            measures.chicken_score=measures.chicken_score+1;
        end
    end
end

if  measures.chicken_score==4 
    trolls = imread('chicken.png');
    xlim([-4 15])
                ylim([-4 15])
                  hold on
                   plot(0,0,'o','MarkerSize',0.05);
    imagesc([80 110],[110 110],trolls);
 
    ims(1)=image(flipud(trolls), 'XData', [6-0.25 6+0.25], 'YData', [6-0.25 6+0.25]); 
    hold on
    legend('chicken won !','Location','north')
    pause(0.1);
    plotGraph(infoPlot)
    throw(MException('Finished:TrackersVictory','Chicken Won'));
end

% The Snakes
foxCatched = [];
for i = 1:snakeNum
    for j = 1:foxNum
        if norm(snake(i,1:dim)-fox(j,1:dim)) < 2*radius
            foxCatched = [foxCatched j];
            xfox(4*(j-1)+1 : 4*(j-1)+4,:) = [];
            num(1)=foxNum - 1;
            measures.snake_score=measures.snake_score+1;
        end
    end
end

if  measures.snake_score==4 
    trolls = imread('snake-emoji.png');
      xlim([-4 15])
                ylim([-4 15])
                  hold on
                   plot(0,0,'o','MarkerSize',0.05);
    imagesc([80 110],[110 110],trolls);
 
    ims(1)=image(flipud(trolls), 'XData', [6-0.25 6+0.25], 'YData', [6-0.25 6+0.25]); 
    hold on
    legend('snake won !','Location','north')
    pause(0.1);
    plotGraph(infoPlot)
    throw(MException('Finished:TrackersVictory','snake Won'));
end

presence_chicken = infoPlot.track_chicken(:,end);

%Change everything
for i = foxCatched
    fox(i,:)=[];
end
for i = chickenCatched
    chicken(i,:)=[];
    found = 0;
    for j = i:size(presence_chicken,1)
        if presence_chicken(j)==1 & found == 0
            presence_chicken(j) = 0;
            found = 1;
        end 
    end
end
for i = snakeCatched
    snake(i,:)=[];
end

infoPlot.track_chicken = [infoPlot.track_chicken presence_chicken];


%% check wall collisions

for j = 1:3
    for i = 1:num(j)
        if j==1
            xtemp = xfox(4*(i-1)+1:4*(i-1)+4,end);
        elseif j==2
            xtemp = xchicken(4*(i-1)+1:4*(i-1)+4,end);
        elseif j==3
            xtemp = xsnake(4*(i-1)+1:4*(i-1)+4,end);
        end
        if (xtemp(1) - envSize(1,1)) < radius
            xtemp(1) = (2*envSize(1,1)+radius) - xtemp(1);
            xtemp(3) = -xtemp(3);
        end
        if (xtemp(1) - envSize(2,1)) > -radius
            xtemp(1) = (2*envSize(2,1)-radius) - xtemp(1);
            xtemp(3) = -xtemp(3);
        end
        if (xtemp(2) - envSize(1,2)) < radius
            xtemp(2) = (2*envSize(1,2)+radius) - xtemp(2);
            xtemp(4) = -xtemp(4);
        end
        if (xtemp(2) - envSize(2,2)) > -radius
            xtemp(2) = (2*envSize(2,2)-radius) - xtemp(2);
            xtemp(4) = -xtemp(4);
        end
        
        if j==1
            xfox(4*(i-1)+1:4*(i-1)+4,end) = xtemp;
        elseif j==2
            xchicken(4*(i-1)+1:4*(i-1)+4,end) = xtemp;
        elseif j==3
            xsnake(4*(i-1)+1:4*(i-1)+4,end) = xtemp;
        end
        
    end
end

end 
