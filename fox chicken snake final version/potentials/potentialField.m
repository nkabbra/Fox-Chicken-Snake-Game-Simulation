function z = potentialField(foxParameters, chickenParameters, snakeParameters, wallParameters, fox, chicken, snake, envSize, U, numFig)
    x = -4:1:15;
    y = x';

    dim = size(x,2);
    z = zeros(dim, dim);
    len = length(foxParameters); % ici vaut 5
    degree = floor((len+1)/2);   % ici vaut 2
    
    for i = 1:dim
        for j = 1:dim
            pot = 0;
            
            for nf = 1: size(fox,1)
                for k = 1:len
                    pot = pot + foxParameters(k)*(norm([x(i),y(j)] - fox(nf,1:2))^(k-degree));
                end
            end
            
            for nc = 1: size(chicken,1)
                for k = 1:len
                    pot = pot + chickenParameters(k)*(norm([x(i),y(j)] - chicken(nc,1:2))^(k-degree));
                end
            end
            
            for ns = 1: size(snake,1)
                for k = 1:len
                    pot = pot + snakeParameters(k)*(norm([x(i),y(j)] - snake(ns,1:2))^(k-degree));
                end
            end
            
            for k = 1:len
                pot = pot + wallParameters(k)*(abs(y(j) - envSize(1,2))^(k-degree));
                pot = pot + wallParameters(k)*(abs(y(j) - envSize(2,2))^(k-degree));
                pot = pot + wallParameters(k)*(abs(x(i) - envSize(1,1))^(k-degree));
                pot = pot + wallParameters(k)*(abs(x(i) - envSize(2,1))^(k-degree));
            end
            
            z(i,j) = -pot;
        end
    end
    
    [px,py] = gradient(z);
    px(isinf(px)|isnan(px)) = 0;
    py(isinf(py)|isnan(py)) = 0;
    figure(numFig)
    contour(x,y,z,'--', 'ShowText','on'); hold on
    quiver(x,y,px,py, 'r')
    
    for nc = 1: size(chicken,1)
        plot(chicken(nc,2), chicken(nc,1),'bo')
        if numFig == 10
            quiver(chicken(nc,2), chicken(nc,1), U(2,nc), U(1,nc), 'b')
        end
    end

    for nc = 1: size(fox,1)
        plot(fox(nc,2), fox(nc,1),'r*')
        if numFig == 11
            quiver(fox(nc,2), fox(nc,1), U(2,nc), U(1,nc), 'b')
        end
    end
    
    for nc = 1: size(snake,1)
        plot(snake(nc,2), snake(nc,1),'go')
        if numFig == 12
            quiver(snake(nc,2), snake(nc,1), U(2,nc), U(1,nc), 'b')
        end
    end
    
    hold off
end