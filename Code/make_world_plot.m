monkey_names = {'Hobbit','Isildur'};
ll = 0;
figure;
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
        load(sprintf('/home/bochengxiao/Monkey_Data/find_incorrect_result/%s-%s-mismatch.mat',monkey_name,date));
        load(sprintf('/home/bochengxiao/Monkey_Data/Arm_Movements/%s-%sarm_movements.mat',monkey_name,date));
        temp = find(misone==1);
        [aa,~] = size(temp);
        for cnt = 1:aa
            cur_mov_beg = MoveBegin(temp(cnt,1),:);
            cur_mov_amp = MoveAmp(temp(cnt,1),:);
            cur_mov_dir = MoveDir(temp(cnt,1),:);
            Dec_dir = 0;

            if TOD_M.TOD(cnt,5)==11||TOD_M.TOD(cnt,5)==12||TOD_M.TOD(cnt,5)==15||TOD_M.TOD(cnt,5)==16
                if TOD_M.Choice(cnt)==1
                    Dec_dir = 90;
                elseif TOD_M.Choice(cnt)==2
                    Dec_dir = 330;
                else
                    Dec_dir = nan;
                end
            elseif TOD_M.TOD(cnt,5)==19||TOD_M.TOD(cnt,5)==20||TOD_M.TOD(cnt,5)==23||TOD_M.TOD(cnt,5)==24
                if TOD_M.Choice(cnt)==1
                    Dec_dir = 330;
                elseif TOD_M.Choice(cnt)==2
                    Dec_dir = 90;
                else
                    Dec_dir = nan;
                end
            elseif TOD_M.TOD(cnt,5)==17||TOD_M.TOD(cnt,5)==18||TOD_M.TOD(cnt,5)==21||TOD_M.TOD(cnt,5)==22
                if TOD_M.Choice(cnt)==1
                    Dec_dir = 330;
                elseif TOD_M.Choice(cnt)==2
                    Dec_dir = 210;
                else
                    Dec_dir = nan;
                end
            elseif TOD_M.TOD(cnt,5)==3||TOD_M.TOD(cnt,5)==4||TOD_M.TOD(cnt,5)==7||TOD_M.TOD(cnt,5)==8
                if TOD_M.Choice(cnt)==1
                    Dec_dir = 210;
                elseif TOD_M.Choice(cnt)==2
                    Dec_dir = 330;
                else
                    Dec_dir = nan;
                end
            elseif TOD_M.TOD(cnt,5)==1||TOD_M.TOD(cnt,5)==2||TOD_M.TOD(cnt,5)==5||TOD_M.TOD(cnt,5)==6
                if TOD_M.Choice(cnt)==1
                    Dec_dir = 210;
                elseif TOD_M.Choice(cnt)==2
                    Dec_dir = 90;
                else
                    Dec_dir = nan;
                end
            elseif TOD_M.TOD(cnt,5)==9||TOD_M.TOD(cnt,5)==10||TOD_M.TOD(cnt,5)==13||TOD_M.TOD(cnt,5)==14
                if TOD_M.Choice(cnt)==1
                    Dec_dir = 90;
                elseif TOD_M.Choice(cnt)==2
                    Dec_dir = 210;
                else
                    Dec_dir = nan;
                end
            end
            ploting_the_world(FixbySacDet,temp(cnt,1),cur_mov_beg,cur_mov_amp,cur_mov_dir,monkey_name,date,TSEventBHV.OutcomeCueON(temp(cnt,1),1),TOD_M,Dec_dir);
        end
    end
end