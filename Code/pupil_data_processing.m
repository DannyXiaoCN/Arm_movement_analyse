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
        if isfield(NeuroPhys.Analog,'AD60')
            max_num = 0;
            [a,b] = size(TSEventBHV.OutcomeCueON);
            vary_m = nan(a,121);
            for trial_num = 1:a
                
                t = NeuroPhys.Analog.AD60.Voltage{1,trial_num}.';
                [~,p] = size(t);
                if p > max_num && p < 10000
                    max_num = p;
                end
                
                cur_time = TSEventBHV.OutcomeCueON(trial_num,1);
                if cur_time ~= 0
                    if cur_time + 100 <= p && cur_time - 20 >= 0
                        vary_m(trial_num,1:121) = t(1,cur_time - 20 : cur_time + 100);
                    elseif cur_time - 20 < 0
                        vary_m(trial_num,0 : cur_time + 100) = t(1,0 : cur_time + 100);
                    elseif cur_time + 100 > p
                        vary_m(trial_num,cur_time - 20 : p) = t(1,cur_time - 20 : p);
                    end
                end
                
            end
            save (['/home/bochengxiao/Monkey_Data/pupil_data/when_reward/' monkey_name '-' date '-pupil_when_rewarded.mat'],'vary_m');
            matrix = nan(a,max_num);
            for trial_num_2 = 1:a
                t2 = NeuroPhys.Analog.AD60.Voltage{1,trial_num_2}.';
                [~,p] = size(t2);
                if p > 10000
                    continue
                end
                matrix(trial_num_2,1:p) = t2;
            end
            
            save (['/home/bochengxiao/Monkey_Data/pupil_data/' monkey_name '-' date '-pupil_data.mat'],'matrix');
            clear matrix;
        end
    end
end