monkey_names = {'Hobbit','Isildur'};
ll = 0;
correct_num = 0;
fail_num = 0;
total_num = 0;
rst = [];
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
        load(['/home/bochengxiao/Monkey_Data/Arm_Movements/' monkey_name '-' date 'arm_movements.mat'],'Decision','PreDecision','PostDecision','Decision_Index','PreDecision_Index','PostDecision_Index');
        find_chosen_option_spatial_information;
        dir_matrix = MoveDir(logical(Decision_Index));
        find_chosen_option_spatial_information
        [siz,c] = size(SpatialInfo);
        rst = zeros(siz,1);
        rst_dir = zeros(siz,1);
        Bingo = zeros(siz,1);
        SpringBack = zeros(siz,1);
        pre_exist = zeros(siz,1);
        for cnt = 1:siz
            
            if SpatialInfo(cnt,4) == 1
                if dir_matrix(cnt,1) > 85 && dir_matrix(cnt,1) < 95
                    correct_num = correct_num + 1;
                    total_num = total_num + 1;
                else
                    
                    fail_num = fail_num + 1;
                    total_num = total_num + 1;
                    rst(cnt,1) = 1;
                    rst_dir(cnt,1) = dir_matrix(cnt,1);
                end
            elseif SpatialInfo(cnt,4) == 2
                if dir_matrix(cnt,1) > 325 && dir_matrix(cnt,1) < 335
                    correct_num = correct_num + 1;
                    total_num = total_num + 1;
                else
                    fail_num = fail_num + 1;
                    total_num = total_num + 1;
                    rst(cnt,1) = 1;
                    rst_dir(cnt,1) = dir_matrix(cnt,1);
                end
                
                
            elseif SpatialInfo(cnt,4) == 3
                
                if dir_matrix(cnt,1) > 205 && dir_matrix(cnt,1) < 215
                    correct_num = correct_num + 1;
                    total_num = total_num + 1;
                else
                    
                    fail_num = fail_num + 1;
                    total_num = total_num + 1;
                    rst(cnt,1) = 1;
                    rst_dir(cnt,1) = dir_matrix(cnt,1);
                end
                
            end
        end
%         SI_dir = SpatialInfo(:,4);
%         SI_dir(SI_dir==1)=90; SI_dir(SI_dir==2)=330; SI_dir(SI_dir==3)=210;
%         plot(SI_dir(logical(rst))); hold on; plot(rst_dir(rst_dir~=0), 'ro');
%         print(gcf,'-dpng',['/home/bochengxiao/Monkey_Data/find_incorrect_result/plot/' monkey_name date '-plot.png']);
%         clf;
%         save(['/home/bochengxiao/Monkey_Data/find_incorrect_result/' monkey_name ...
%             '-' date 'incorrect_rst.mat'],'rst');
%         save(['/home/bochengxiao/Monkey_Data/find_incorrect_result/Bingo/' monkey_name ...
%             '-' date 'Bingo_rst.mat'],'Bingo');
%         save(['/home/bochengxiao/Monkey_Data/find_incorrect_result/Springback/' monkey_name ...
%             '-' date 'Bingo_rst.mat'],'SpringBack');
    end
end