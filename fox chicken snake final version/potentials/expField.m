function infoPlot = expField(foxParameters, chickenParameters, snakeParameters, wallParameters, fox, chicken, snake, envSize, infoPlot, numFig)
    x = -4:0.5:15;
    y = x';
    U = infoPlot.U_chicken;

    dim = size(x,2);
    z = zeros(dim, dim);
    len = length(wallParameters); % ici vaut 5
    degree = floor((len+1)/2);   % ici vaut 2
    
    for i = 1:dim
        for j = 1:dim
            pot = 0;
            
            for nf = 1: size(fox,1)
                pot = pot + foxParameters(1)*exp(-foxParameters(2)*norm([x(i),y(j)] - fox(nf,1:2)));
                pot = pot + foxParameters(3)*(norm([x(i),y(j)] - fox(nf,1:2))^(-1));
            end
            
            for nc = 1: size(chicken,1)
                pot = pot + chickenParameters(1)*exp(-chickenParameters(2)*norm([x(i),y(j)] - chicken(nc,1:2)));
                pot = pot + chickenParameters(3)*(norm([x(i),y(j)] - chicken(nc,1:2))^(-1));
            end
            
            for ns = 1: size(snake,1)
                pot = pot + snakeParameters(1)*exp(-snakeParameters(2)*norm([x(i),y(j)] - snake(ns,1:2)));
                pot = pot + snakeParameters(3)*(norm([x(i),y(j)] - snake(ns,1:2))^(-1));
            end
            
            for k = 1:len
                pot = pot + wallParameters(k)*(abs(y(j) - envSize(1,2))^(k-degree));
                pot = pot + wallParameters(k)*(abs(y(j) - envSize(2,2))^(k-degree));
                pot = pot + wallParameters(k)*(abs(x(i) - envSize(1,1))^(k-degree));
                pot = pot + wallParameters(k)*(abs(x(i) - envSize(2,1))^(k-degree));
            end
            
            z(j,i) = -pot;
        end
    end
    
    [px,py] = gradient(z);
    px(isinf(px)|isnan(px)) = 0;
    py(isinf(py)|isnan(py)) = 0;
    figure(numFig)
%     contour(x,y,z,'--', 'ShowText','on'); hold on
    contour(x,y,z,'--'); hold on
    quiver(x,y,px,py, 'r')
    
    for nc = 1: size(chicken,1)
        plot(chicken(nc,1), chicken(nc,2), 'bo')
        if numFig == 10
            quiver(chicken(nc,1), chicken(nc,2), U(1,end-size(chicken,1)+nc)/5, U(2,end-size(chicken,1)+nc)/5, 'b')
        end
    end

    for nc = 1: size(fox,1)
        plot(fox(nc,1), fox(nc,2), 'ro')
        if numFig == 11
            quiver(fox(nc,2), fox(nc,1), U(1,end-size(fox,1)+nc), U(2,end-size(fox,1)+nc), 'b')
        end
    end
    
    for nc = 1: size(snake,1)
        plot(snake(nc,1), snake(nc,2), 'go')
        if numFig == 12
            quiver(snake(nc,1), snake(nc,2), U(1,end-size(snake,1)+nc), U(2,end-size(snake,1)+nc), 'b')
        end
    end
    
    hold off
    
end