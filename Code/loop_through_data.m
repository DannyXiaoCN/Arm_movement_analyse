
% This script aims to divided all arm movements into Decision, Pre-Decision
% and Post-Decision based on the OutComeCue time.


monkey_names = {'Hobbit','Isildur'};
ll = 0;
figure;
for monkey_num = 1:numel(monkey_names)
    monkey_name = monkey_names{monkey_num};
    if strcmpi(monkey_name,'Hobbit')
%         monkey_dir = '/home/bochengxiao/Monkey_Data/SMA_Monkey/MonkeyH';
        monkey_dir = '/Users/xiaobocheng/Desktop/Monkey_Data/SMA_Monkey/MonkeyH';
    elseif strcmpi(monkey_name,'Isildur')
%         monkey_dir = '/home/bochengxiao/Monkey_Data/SMA_Monkey/MonkeyI';
        monkey_dir = '/Users/xiaobocheng/Desktop/Monkey_Data/SMA_Monkey/MonkeyI';
    else
        disp('No data for this monkey');
    end
    if strcmpi(monkey_name,'Hobbit')
        dates = {'12-31-2018(01)','01-02-2019','01-03-2019','01-05-2019','01-05-2019(01)','03-05-2019(01)','03-05-2019(02)','03-07-2019','03-12-2019(01)','03-20-2019','03-20-2019(01)','03-25-2019','03-25-2019(01)','03-28-2019','06-25-2019','06-25-2019','06-26-2019','06-26-2019','06-28-2019','06-28-2019','07-02-2019','07-05-2019','07-05-2019','07-10-2019','07-05-2019'};
    elseif strcmpi(monkey_name,'Isildur')
        dates = {'08-10-2017(01)','08-16-2017(01)','08-17-2017(02)','08-18-2017(01)','08-25-2017(02)','08-25-2017(03)','08-25-2017(04)','08-28-2017(01)','09-13-2017(01)','09-13-2017(03)','10-20-2017(01)','10-25-2017(01)','10-27-2017(03)','10-31-2017(01)','10-31-2017(03)'};
    end
    
    for date_num = 1:numel(dates)
        ll=ll+1;
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
        load(sprintf('%s/%s_%s_corrected_movements.mat',monkey_dir,monkey_name,date));
        
        
        %%%%%%% INSERT ANALYSIS CODE HERE %%%%%
        data = MoveBegin;
        [sz,cl] = size(data);
        Decision = zeros(sz,cl);        
        Decision_Index = zeros(sz,cl);
        PreDecision = zeros(sz,cl);
        PreDecision_Index = zeros(sz,cl);
        PostDecision = zeros(sz,cl);
        PostDecision_Index = zeros(sz,cl);
        for counter = 1:sz
            if isnan(TOD_M.Choice(counter,1)) || isnan(TSEventBHV.OutcomeCueON(counter,1))
                continue
            end
            
            if TOD_M.TOD(counter,5)==11||TOD_M.TOD(counter,5)==12||TOD_M.TOD(counter,5)==15||TOD_M.TOD(counter,5)==16
                if TOD_M.Choice(counter)==1
                    Dec_dir = 90;
                elseif TOD_M.Choice(counter)==2
                    Dec_dir = 330;
                else
                    Dec_dir = nan;
                end
            elseif TOD_M.TOD(counter,5)==19||TOD_M.TOD(counter,5)==20||TOD_M.TOD(counter,5)==23||TOD_M.TOD(counter,5)==24
                if TOD_M.Choice(counter)==1
                    Dec_dir = 330;
                elseif TOD_M.Choice(counter)==2
                    Dec_dir = 90;
                else
                    Dec_dir = nan;
                end
            elseif TOD_M.TOD(counter,5)==17||TOD_M.TOD(counter,5)==18||TOD_M.TOD(counter,5)==21||TOD_M.TOD(counter,5)==22
                if TOD_M.Choice(counter)==1
                    Dec_dir = 330;
                elseif TOD_M.Choice(counter)==2
                    Dec_dir = 210;
                else
                    Dec_dir = nan;
                end
            elseif TOD_M.TOD(counter,5)==3||TOD_M.TOD(counter,5)==4||TOD_M.TOD(counter,5)==7||TOD_M.TOD(counter,5)==8
                if TOD_M.Choice(counter)==1
                    Dec_dir = 210;
                elseif TOD_M.Choice(counter)==2
                    Dec_dir = 330;
                else
                    Dec_dir = nan;
                end
            elseif TOD_M.TOD(counter,5)==1||TOD_M.TOD(counter,5)==2||TOD_M.TOD(counter,5)==5||TOD_M.TOD(counter,5)==6
                if TOD_M.Choice(counter)==1
                    Dec_dir = 210;
                elseif TOD_M.Choice(counter)==2
                    Dec_dir = 90;
                else
                    Dec_dir = nan;
                end
            elseif TOD_M.TOD(counter,5)==9||TOD_M.TOD(counter,5)==10||TOD_M.TOD(counter,5)==13||TOD_M.TOD(counter,5)==14
                if TOD_M.Choice(counter)==1
                    Dec_dir = 90;
                elseif TOD_M.Choice(counter)==2
                    Dec_dir = 210;
                else
                    Dec_dir = nan;
                end
            end
            
            threshold = TSEventBHV.OutcomeCueON(counter,1);
            max = 0;
            max_index = -1;
            for counter_col = 1:cl
                if MoveBegin(counter,counter_col) > max && MoveBegin(counter,counter_col) < threshold
                   max =  MoveBegin(counter,counter_col);
                   max_index = counter_col;
                end
            end
            if max_index ~= -1 
                Cannot_identify = 0;
                while abs(MoveDir(counter, max_index) - Dec_dir) > 15
                    if max_index <= 1
                        Cannot_identify = 1;
                        break
                    else
                    max = MoveBegin(counter,max_index - 1);
                    max_index = max_index - 1;
                    end
                end
                if Cannot_identify == 0
                    if max_index + 1 <= cl
                        
                        Decision(counter,max_index + 1) = max;
                        Decision_Index(counter,max_index + 1) = 1;
                    else
                        Decision(counter,max_index) = max;
                        Decision_Index(counter,max_index) = 1;
                    end
                else
                    max = 0;
                    max_index = -1;
                end
            end
            for counter_col = 1:cl
                if abs(MoveDir(counter, counter_col) - 90) < 15 || abs(MoveDir(counter, counter_col) - 210) < 15 || abs(MoveDir(counter, counter_col) - 330) < 15
                    if MoveBegin(counter,counter_col) < max
                        PreDecision(counter,counter_col) = MoveBegin(counter,counter_col);
                        PreDecision_Index(counter,counter_col) = 1;
%                         if MoveAmp(counter,counter_col) > 3
%                             ploting_the_world(FixbySacDet,counter,MoveBegin(counter,:),MoveAmp(counter,:),MoveDir(counter,:),monkey_name,date,TSEventBHV.OutcomeCueON(counter),TOD_M,Dec_dir)
%                         end
                    elseif MoveBegin(counter,counter_col) > max
                        PostDecision(counter,counter_col) = MoveBegin(counter,counter_col);
                        PostDecision_Index(counter,counter_col) = 1;
                    end
                end
            end
        end
        %         save(['/home/bochengxiao/Monkey_Data/Arm_Movements/' monkey_name '-' date 'arm_movements.mat'],'Decision','PreDecision','PostDecision','Decision_Index','PreDecision_Index','PostDecision_Index');
        save(['/Users/xiaobocheng/Desktop/monkey_data/Arm_Movements/' monkey_name '-' date 'arm_movements.mat'],'Decision','PreDecision','PostDecision','Decision_Index','PreDecision_Index','PostDecision_Index');
        
    end
end