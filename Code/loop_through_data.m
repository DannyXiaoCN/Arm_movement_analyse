
% This script aims to divided all arm movements into Decision, Pre-Decision
% and Post-Decision based on the OutComeCue time.


monkey_names = {'Hobbit','Isildur'};
ll = 0;
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
        
        %%%%%%% INSERT ANALYSIS CODE HERE %%%%%
        data = MoveEnd;
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
            
            threshold = TSEventBHV.OutcomeCueON(counter,1);
            max = 0;
            max_index = -1;
            for cnt_col = 1:cl
                if MoveEnd(counter,cnt_col) > max && MoveEnd(counter,cnt_col) < threshold
                   max =  MoveEnd(counter,cnt_col);
                   max_index = cnt_col;
                end
            end
            if max_index ~= -1
                Decision(counter,max_index) = max;
                Decision_Index(counter,max_index) = 1;
            end
            for cnt_col = 1:cl
                if MoveEnd(counter,cnt_col) < max
                    PreDecision(counter,cnt_col) = MoveEnd(counter,cnt_col);
                    PreDecision_Index(counter,cnt_col) = 1;
                elseif MoveEnd(counter,cnt_col) > max
                    PostDecision(counter,cnt_col) = MoveEnd(counter,cnt_col);
                    PostDecision_Index(counter,cnt_col) = 1;
                end
            end
            
        end
        save(['/home/bochengxiao/Monkey_Data/Arm_Movements/' monkey_name '-' date 'arm_movements.mat'],'Decision','PreDecision','PostDecision','Decision_Index','PreDecision_Index','PostDecision_Index');
    end
end