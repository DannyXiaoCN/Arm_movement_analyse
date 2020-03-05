monkey_names = {'Hobbit','Isildur'};
figure;

mismatch_num = nan(numel(monkey_names),25);
mismatch_percent = nan(numel(monkey_names),25);
for monkey_num = 1:numel(monkey_names)
    monkey_name = monkey_names{monkey_num};
    if strcmpi(monkey_name,'Hobbit')
        monkey_dir = '/home/bochengxiao/Monkey_Data/SMA_Monkey/MonkeyH';
    elseif strcmpi(monkey_name,'Isildur')
        monkey_dir = '/home/bochengxiao/Monkey_Data/SMA_Monkey/MonkeyI';
    else
        disp('No data for this monkey');
    end
    if strcmpi(monkey_name,'Hobbit')
        dates = {'12-31-2018(01)','01-02-2019','01-03-2019','01-05-2019','01-05-2019(01)','03-05-2019(01)','03-05-2019(02)','03-07-2019','03-12-2019(01)','03-20-2019','03-20-2019(01)','03-25-2019','03-25-2019(01)','03-28-2019','06-25-2019','06-25-2019','06-26-2019','06-26-2019','06-28-2019','06-28-2019','07-02-2019','07-05-2019','07-05-2019','07-10-2019','07-05-2019'};
    elseif strcmpi(monkey_name,'Isildur')
        dates = {'08-10-2017(01)','08-16-2017(01)','08-17-2017(02)','08-18-2017(01)','08-25-2017(02)','08-25-2017(03)','08-25-2017(04)','08-28-2017(01)','09-13-2017(01)','09-13-2017(03)','10-20-2017(01)','10-25-2017(01)','10-27-2017(03)','10-31-2017(01)','10-31-2017(03)'};
    end
    
    for date_num = 1:numel(dates)
        if strcmpi(monkey_name,'Isildur')&&date_num==14 %Mismatch in number of trials for this file
            continue
        elseif strcmpi(monkey_name,'Isildur')&&date_num==4  %Missing TSEventBHV
            continue
        elseif strcmpi(monkey_name,'Isildur')&&date_num==5  %Missing TSEventBHV
            continue
        elseif strcmpi(monkey_name,'Isildur')&&date_num==8  %Missing TSEventBHV
            continue
        elseif strcmpi(monkey_name,'Isildur')&&date_num==12  %Missing TSEventBHV
            continue
        end
        date = dates{date_num};
        
        load(sprintf('%s/Multi-attribute-%s-%s.mat',monkey_dir,monkey_name,date));
        
        [a,b] = size(MoveAmp);
        misone = zeros(a,1);
        MoveBegin = TS_Move.MoveBegin;
        MoveEnd = TS_Move.MoveEnd;
        MoveDir = TS_Move.MoveDir;
        MoveAmp = TS_Move.MoveAmp;
        MoveDur = TS_Move.MoveDur;
%         find_chosen_option_spatial_information
        decision_direction = nan(size(MoveBegin,1),1);
        chosen_opt_pos = nan(size(MoveBegin,1),1);
        for trial_num = 1:size(MoveBegin,1)
            if TOD_M.TOD(trial_num,5)==11||TOD_M.TOD(trial_num,5)==12||TOD_M.TOD(trial_num,5)==15||TOD_M.TOD(trial_num,5)==16
                if TOD_M.Choice(trial_num)==1
                    chosen_opt_pos(trial_num) = 90;
                elseif TOD_M.Choice(trial_num)==2
                    chosen_opt_pos(trial_num) = 330;
                else
                    chosen_opt_pos(trial_num) = nan;
                end
            elseif TOD_M.TOD(trial_num,5)==19||TOD_M.TOD(trial_num,5)==20||TOD_M.TOD(trial_num,5)==23||TOD_M.TOD(trial_num,5)==24
                if TOD_M.Choice(trial_num)==1
                    chosen_opt_pos(trial_num) = 330;
                elseif TOD_M.Choice(trial_num)==2
                    chosen_opt_pos(trial_num) = 90;
                else
                    chosen_opt_pos(trial_num) = nan;
                end
            elseif TOD_M.TOD(trial_num,5)==17||TOD_M.TOD(trial_num,5)==18||TOD_M.TOD(trial_num,5)==21||TOD_M.TOD(trial_num,5)==22
                if TOD_M.Choice(trial_num)==1
                    chosen_opt_pos(trial_num) = 330;
                elseif TOD_M.Choice(trial_num)==2
                    chosen_opt_pos(trial_num) = 210;
                else
                    chosen_opt_pos(trial_num) = nan;
                end
            elseif TOD_M.TOD(trial_num,5)==3||TOD_M.TOD(trial_num,5)==4||TOD_M.TOD(trial_num,5)==7||TOD_M.TOD(trial_num,5)==8
                if TOD_M.Choice(trial_num)==1
                    chosen_opt_pos(trial_num) = 210;
                elseif TOD_M.Choice(trial_num)==2
                    chosen_opt_pos(trial_num) = 330;
                else
                    chosen_opt_pos(trial_num) = nan;
                end
            elseif TOD_M.TOD(trial_num,5)==1||TOD_M.TOD(trial_num,5)==2||TOD_M.TOD(trial_num,5)==5||TOD_M.TOD(trial_num,5)==6
                if TOD_M.Choice(trial_num)==1
                    chosen_opt_pos(trial_num) = 210;
                elseif TOD_M.Choice(trial_num)==2
                    chosen_opt_pos(trial_num) = 90;
                else
                    chosen_opt_pos(trial_num) = nan;
                end
            elseif TOD_M.TOD(trial_num,5)==9||TOD_M.TOD(trial_num,5)==10||TOD_M.TOD(trial_num,5)==13||TOD_M.TOD(trial_num,5)==14
                if TOD_M.Choice(trial_num)==1
                    chosen_opt_pos(trial_num) = 90;
                elseif TOD_M.Choice(trial_num)==2
                    chosen_opt_pos(trial_num) = 210;
                else
                    chosen_opt_pos(trial_num) = nan;
                end
            else
                fprintf('PROBLEM: Unexpected value in TOD_M.TOD(%d,5)\n',trial_num)
            end
            if isnan(TSEventBHV.OutcomeCueON(trial_num))
                continue
            else
                [trial_movement_start_times, sort_ind] = sort(MoveBegin(trial_num,:));
                trial_movement_directions = MoveDir(trial_num,sort_ind);
                pre_cue_inds = find(trial_movement_start_times<TSEventBHV.OutcomeCueON(trial_num));
                decision_direction(trial_num) = trial_movement_directions(pre_cue_inds(end));
            end
        end
        mismatches = 0;
        for trial_num = 1:size(MoveBegin,1)
            if decision_direction(trial_num)>=chosen_opt_pos(trial_num)-10 && decision_direction(trial_num)<=chosen_opt_pos(trial_num)+10
                continue
            elseif isnan(chosen_opt_pos(trial_num))||isnan(decision_direction(trial_num))
                continue
            else
%                 mismatches = mismatches+1;
                misone(trial_num,1) = 1;
            end
        end
%         mismatch_num(monkey_num,date_num) = mismatches;
%         mismatch_percent(monkey_num,date_num) = 100*(mismatches/size(MoveBegin,1));
        save(['/home/bochengxiao/Monkey_Data/find_incorrect_result/' monkey_name '-' date '-' 'mismatch.mat'],'misone');
    end
end
% 
% imagesc(mismatch_percent);
% xlabel('file number')
% set(gca,'YTick',[1 2],'YTickLabel',{'Hobbit','Isildur'});
% cbar = colorbar; ylabel(cbar,'percent of trials with a direction mismatch');