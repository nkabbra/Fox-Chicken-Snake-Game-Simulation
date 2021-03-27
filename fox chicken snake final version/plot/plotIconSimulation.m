function plotIconSimulation(infoPlot, fox, chicken, snake, m, num, trollList)
    
    trollf = trollList.f;
    troll = trollList.c;
    trolls = trollList.s;
    
    if infoPlot.plotImg
        
              for i=0:(num(1)-1)
                 xlim([-4 15])
                 ylim([-4 15])
                 ppp(i+1)=plot(fox(i+1,1),fox(i+1,2),'or','MarkerSize',0.1,'MarkerFaceColor','w');
                 hold on
                 imagesc([100 100],[100 100],trollf);
                 im(i+1)=image(flipud(trollf), 'XData', [fox(i+1,1)-0.25 fox(i+1,1)+0.25], 'YData', [fox(i+1,2)-0.25 fox(i+1,2)+0.25]);
              end
                
                for i=0:(num(2)-1)
                 xlim([-4 15])
                 ylim([-4 15])
                 pppc(i+1)=plot(chicken(i+1,1),chicken(i+1,2),'or','MarkerSize',0.1,'MarkerFaceColor','w');
                 hold on
                 imagesc([90 90],[90 90],troll);
                 imc(i+1)=image(flipud(troll), 'XData', [chicken(i+1,1)-0.25 chicken(i+1,1)+0.25], 'YData', [chicken(i+1,2)-0.25 chicken(i+1,2)+0.25]);
                end
              
                for i=0:(num(3)-1)
                 xlim([-4 15])
                 ylim([-4 15])
                 ppps(i+1)=plot(snake(i+1,1),snake(i+1,2),'or','MarkerSize',0.1,'MarkerFaceColor','w');
                 hold on
                 imagesc([110 110],[110 110],trolls);
                 ims(i+1)=image(flipud(trolls), 'XData', [snake(i+1,1)-0.25 snake(i+1,1)+0.25], 'YData', [snake(i+1,2)-0.25 snake(i+1,2)+0.25]);
                end

        hold on
       title(['CURRENT SCORES: '  'fox score: ' num2str(m.fox_score),' num: ' num2str(num(1)), '  chicken score: ' num2str(m.chicken_score),' num: ' num2str(num(2)), '  snake score: ' num2str(m.snake_score),' num: ' num2str(num(3))])
        disp(['CURRENT SCORES: '  'fox score: ' num2str(m.fox_score),' num: ' num2str(num(1)), '  chicken score: ' num2str(m.chicken_score),' num: ' num2str(num(2)), '  snake score: ' num2str(m.snake_score),' num: ' num2str(num(3))]);
        pause(0.05);
        delete(im)
        delete(ppp)
        delete(imc)
        delete(pppc)
        delete(ims)
        delete(ppps)
    end
       
 

end