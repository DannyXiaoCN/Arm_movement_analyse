function ploting_the_world(FixbySacDet,trial_num,MoveBegin,MoveAmp,MoveDir,monkey_name,date,Outcome,TOD_M,Dec_dir)

% first use whichattribute to see find ~= nan
% get the start time and end time of it
% ploting
% mark the movement
clf;
target = find(~isnan(FixbySacDet.whichAttribute(trial_num,:)));
[~,cols] = size(target);
% for cnt = 1:cols
%     answ = -2;
%     cur_start = FixbySacDet.FixStart(trial_num,target(1,cnt));
%     cur_end = FixbySacDet.FixEnd(trial_num,target(1,cnt));
%     get_dir;
%     if FixbySacDet.whichAttribute(trial_num,target(1,cnt)) == 1 || FixbySacDet.whichAttribute(trial_num,target(1,cnt)) == 3
%         
%         % create orange up plot (1 amount)
%         if answ == 1 
%             plot([cur_start cur_end],ones(1,2),'y','LineWidth',3);
%         elseif answ == 0
%             plot([cur_start cur_end],zeros(1,2),'y','LineWidth',3);
%         elseif answ == -1
%             plot([cur_start cur_end],-1*ones(1,2),'y','LineWidth',3);
%         end
%         
%     elseif FixbySacDet.whichAttribute(trial_num,target(1,cnt)) == 2 || FixbySacDet.whichAttribute(trial_num,target(1,cnt)) == 4
%         % create blue up plot (1 probability)
%         if answ == 1 
%             plot([cur_start cur_end],ones(1,2),'b','LineWidth',3);
%         elseif answ == 0
%             plot([cur_start cur_end],zeros(1,2),'b','LineWidth',3);
%         elseif answ == -1
%             plot([cur_start cur_end],-1*ones(1,2),'b','LineWidth',3);
%          end
%     hold on;
%     end
%     
% end
% 
% cmap = jet(360);%normal(360);
temp = find(MoveBegin~=0);
[~,a] = size(temp);
% % disp(a)
% for cnt2 = 1:a
%     
%     bar(MoveBegin(1,temp(cnt2)),MoveAmp(1,temp(cnt2)),'EdgeColor',cmap(round(MoveDir(1,temp(1,cnt2))),:),'LineWidth',4);
%     xlim([0,max(max(MoveBegin))+5000]);
%     ylim([-2,6]);
%     xlabel('time');
%     ylabel('amplitude');
%     colormap(cmap);
%     c = colorbar;
% %     c.Limits = [0 360];
%     set(c,'YTick',[90 210 330]/360,'YTickLabel',{'top','left','right'})
% end
% print(gcf,'-dpng',['/home/bochengxiao/Monkey_Data/Los_Plots/whole_plot/ver1/' monkey_name '-' date '-' num2str(trial_num) '-whole-plot-ver-color.png']);




clf;
main_axes = axes;
for cnt = 1:cols
    
    cur_start = FixbySacDet.FixStart(trial_num,target(1,cnt));
    cur_end = FixbySacDet.FixEnd(trial_num,target(1,cnt));
    get_dir;
    if FixbySacDet.whichAttribute(trial_num,target(1,cnt)) == 1 || FixbySacDet.whichAttribute(trial_num,target(1,cnt)) == 3
        
        % create orange up plot (1 amount)
        if answ == 1 
            plot([cur_start cur_end],ones(1,2),'y','LineWidth',3);
        elseif answ == 0
            plot([cur_start cur_end],zeros(1,2),'y','LineWidth',3);
        elseif answ == -1
            plot([cur_start cur_end],-1*ones(1,2),'y','LineWidth',3);
        end
        
    elseif FixbySacDet.whichAttribute(trial_num,target(1,cnt)) == 2 || FixbySacDet.whichAttribute(trial_num,target(1,cnt)) == 4
        % create blue up plot (1 probability)
         if answ == 1 
            plot([cur_start cur_end],ones(1,2),'b','LineWidth',3);
        elseif answ == 0
            plot([cur_start cur_end],zeros(1,2),'b','LineWidth',3);
        elseif answ == -1
            plot([cur_start cur_end],-1*ones(1,2),'b','LineWidth',3);
         end
    hold on;
    end
    
end

if Dec_dir > 80 && Dec_dir < 100 
    plot(Outcome,1,'-s');
    bar(Outcome,1);
elseif Dec_dir > 200 && Dec_dir < 220
    plot(Outcome,0,'-s');
    bar(Outcome,0);
elseif Dec_dir > 320 && Dec_dir < 340
    plot(Outcome,-1,'-s');
    bar(Outcome,-1);
end

xlim([0,max(max(MoveBegin))+5000]);
ylim([-2,2]);
xlabel('time (ms');
    title([monkey_name '-' date '-' 'trial #' num2str(trial_num)]);
set(gca,'YTick',[-1 0 1],'YTickLabel',{'right','left','top'});
for cnt2 = 1:a
    
    A = get(main_axes,'Position');
    XL = max(max(MoveBegin))+5000;
    xpos = (MoveBegin(1,temp(1,cnt2)))/XL*A(1,3) + A(1,1);
    ypos = (2/4)*A(1,4) + A(1,2);
    axes('Position',[xpos-0.1 ypos-0.1 0.2 0.2])
    polarplot([1 MoveDir(1,temp(1,cnt2))],[0 MoveAmp(1,temp(1,cnt2))],'k','LineWidth',3);
    rlim([0 5])

    axis off
    
end
print(gcf,'-dpng',['/home/bochengxiao/Monkey_Data/Los_Plots/whole_plot/ver2/' monkey_name '-' date '-' num2str(trial_num) '-whole-plot-ver-2.png']);

% plot the movement (Predecision Decision PostDecision)
% the create a circle radiant is the ampl, the degrees is the direction
% the color represents it is Pre, Dec or Post


