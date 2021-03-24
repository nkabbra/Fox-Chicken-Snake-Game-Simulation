function plotIconSimulation(infoPlot, fox, chicken, snake, m, num, trollList)
    
    trollf = trollList.f;
    troll = trollList.c;
    trolls = trollList.s;
    
    if infoPlot.plotImg
        figure(2)
        for i=1:num(1)
            xlim([-4 15])
            ylim([-4 15])
            ppp(i)=plot(fox(i,1),fox(i,2),'or','MarkerSize',0.1,'MarkerFaceColor','w');
            hold on
            imagesc([100 100],[100 100],trollf);
            im(i)=image(flipud(trollf), 'XData', [fox(i,1)-0.25 fox(i,1)+0.25], 'YData', [fox(i,2)-0.25 fox(i,2)+0.25]);
        end

        for i=1:num(2)
            xlim([-4 15])
            ylim([-4 15])
            pppc(i)=plot(chicken(i,1),chicken(i,2),'or','MarkerSize',0.1,'MarkerFaceColor','w');
            hold on
            imagesc([90 90],[90 90],troll);
            imc(i)=image(flipud(troll), 'XData', [chicken(i,1)-0.25 chicken(i,1)+0.25], 'YData', [chicken(i,2)-0.25 chicken(i,2)+0.25]);
        end

        for i=1:num(3)
            xlim([-4 15])
            ylim([-4 15])
            ppps(i)=plot(snake(i,1),snake(i,2),'or','MarkerSize',0.1,'MarkerFaceColor','w');
            hold on
            imagesc([110 110],[110 110],trolls);
            ims(i)=image(flipud(trolls), 'XData', [snake(i,1)-0.25 snake(i,1)+0.25], 'YData', [snake(i,2)-0.25 snake(i,2)+0.25]);
        end

        title(['CURRENT SCORES: '  'fox score: ' num2str(m.fox_score),' num: ' num2str(num(1)), '  chicken score: ' num2str(m.chicken_score),' num: ' num2str(num(2)), '  snake score: ' num2str(m.snake_score),' num: ' num2str(num(3))])
        disp(['CURRENT SCORES: '  'fox score: ' num2str(m.fox_score),' num: ' num2str(num(1)), '  chicken score: ' num2str(m.chicken_score),' num: ' num2str(num(2)), '  snake score: ' num2str(m.snake_score),' num: ' num2str(num(3))]);

        hold off

        if infoPlot.record
            infoPlot.Frame_img = [infoPlot.Frame_img getframe(gcf)];
        end
        pause(0.05);
    end

end