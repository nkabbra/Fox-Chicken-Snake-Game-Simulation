% Convention:
% foxTeam = 1, chickenTeam = 2, snakeTeam = 3

function [fox, xfox, chicken, xchicken, snake, xsnake] = initMat(p)
    [fox, xfox] = initfox(p.foxNum,p.Dimension,p.SizeOfEnvironment);
    [chicken, xchicken] = initchicken(p.chickenNum,p.Dimension,p.SizeOfEnvironment);
    [snake, xsnake] = initsnake(p.snakeNum,p.Dimension,p.SizeOfEnvironment);
end
