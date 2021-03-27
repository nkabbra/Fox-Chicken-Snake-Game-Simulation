function plotGraph(infoPlot)
% Plot the Command U of the Chicken agents
U = infoPlot.U_chicken;
Track = infoPlot.track_chicken;
[nbChicken,lenSim] = size(Track);

U_adapt = zeros(nbChicken,lenSim);

K_elim = [];
idx = 0;
for k = 1:lenSim-1
    for j = 1:nbChicken
        
        if Track(j,k) == 0
            U_adapt(j,k) = 0;
        else
            idx = idx+1;
            U_adapt(j,k) = norm(U(:,idx));
        end
    end
end

T = [1:lenSim] * 0.1;
figure(20)

plot(T, U_adapt(1,:)); hold on
plot(T, U_adapt(2,:));
plot(T, U_adapt(3,:));
plot(T, U_adapt(4,:));
title(['Control Law applied to Chicken'])
disp(['Control Law applied to Chicken'])
% %% Create video
% 
% if infoPlot.record
%     if (T(end) > 45)
%         frameRate = 20;
%     else
%         frameRate = 10;
%     end
%     
%     % ---------------------------------------------------------------------
%     F_chicken = infoPlot.Frame_chicken;
%     writerObj = VideoWriter('chicken_pot');
%     writerObj.FrameRate = frameRate;
%     % set the seconds per image
%     % open the video writer
%     open(writerObj);
%     % write the frames to the video
%     for i=1:length(F_chicken)
%         % convert the image to a frame
%         frame = F_chicken(i) ;    
%         writeVideo(writerObj, frame);
%     end
%     % close the writer object
%     close(writerObj);
%     
%     % ---------------------------------------------------------------------
%     F = infoPlot.Frame_img;
%     writerObj = VideoWriter('img');
%     writerObj.FrameRate = frameRate;
%     % set the seconds per image
%     % open the video writer
%     open(writerObj);
%     % write the frames to the video
%     for i=1:length(F)
%         % convert the image to a frame
%         frame = F(i) ;    
%         writeVideo(writerObj, frame);
%     end
%     % close the writer object
%     close(writerObj);
% end

end