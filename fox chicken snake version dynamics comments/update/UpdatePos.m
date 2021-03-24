function [fox2,xfox2,chicken2,xchicken2,snake2,xsnake2,measures2,num,infoPlot] = UpdatePos(fox,chicken,snake,p,measures,num,xfox,xchicken,xsnake,k, infoPlot)
% Update all agent states
[fox2,xfox] = updatefox(fox,chicken,snake,p,xfox,k);
[chicken2,xchicken,infoPlot] = updatechicken(fox,chicken,snake,p,xchicken,k, infoPlot);
[snake2,xsnake] = updatesnake(fox,chicken,snake,p,xsnake,k);

% Look for collisions and potential victories
[fox2,chicken2,snake2,measures2,num,xfox2,xchicken2,xsnake2, infoPlot]=checkCollisions(fox2,chicken2,snake2,p,measures,num,xfox,xchicken,xsnake, infoPlot);
end
