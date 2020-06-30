monkey_names = {'Hobbit','Isildur'};
ll = 0;
cc = 0;
for monkey_num = 1:numel(monkey_names)
    monkey_name = monkey_names{monkey_num};
    if strcmpi(monkey_name,'Hobbit')
        monkey_dir = '/Users/xiaobocheng/Desktop/Monkey_Data/SMA_Monkey/MonkeyH';
    elseif strcmpi(monkey_name,'Isildur')
        monkey_dir = '/Users/xiaobocheng/Desktop/Monkey_Data/SMA_Monkey/MonkeyI';
    else
        disp('No data for this monkey');
    end
    if strcmpi(monkey_name,'Hobbit')
        dates = {'12-31-2018(01)','01-02-2019','01-03-2019','01-05-2019','01-05-2019(01)','03-05-2019(01)','03-05-2019(02)','03-07-2019','03-12-2019(01)','03-20-2019','03-20-2019(01)','03-25-2019','03-25-2019(01)','03-28-2019','06-25-2019','06-25-2019','06-26-2019','06-26-2019','06-28-2019','06-28-2019','07-02-2019','07-05-2019','07-05-2019','07-10-2019','07-05-2019'};
    elseif strcmpi(monkey_name,'Isildur')
        dates = {'08-10-2017(01)','08-16-2017(01)','08-17-2017(02)','08-18-2017(01)','08-25-2017(02)','08-25-2017(03)','08-25-2017(04)','08-28-2017(01)','09-13-2017(01)','09-13-2017(03)','10-20-2017(01)','10-25-2017(01)','10-27-2017(03)','10-31-2017(01)','10-31-2017(03)'};
    end
    Pred = [];
    Dec = [];
    Post = [];
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
        load(sprintf('/Users/xiaobocheng/Desktop/monkey_data/Arm_Movements/%s-%sarm_movements.mat',monkey_name,date));
        
        %%%%%%% INSERT ANALYSIS CODE HERE %%%%%
        ampl = MoveAmp;
        dire = MoveDir;
        [sz,sp] = size(ampl);
        dec = Decision_Index;
        pred = PreDecision_Index;
        post = PostDecision_Index;
        Pred = [Pred ampl(logical(pred)).'];
        Dec = [Dec ampl(logical(dec)).'];
        Post = [Post ampl(logical(post)).'];
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure;
    subplot(3,1,1)
    histogram(Pred);
    title([monkey_name ' pre-decision movement amplitudes']);
    ylabel('number of movements'); xlabel('movement amplitude');
    xlim([0 6]);
    subplot(3,1,2)
    histogram(Dec);
    title([monkey_name ' decision movement amplitudes']);
    ylabel('number of movements'); xlabel('movement amplitude');
    xlim([0 6]);
    subplot(3,1,3)
    histogram(Post);
    title([monkey_name ' post-decision movement amplitudes']);
    ylabel('number of movements'); xlabel('movement amplitude');
    xlim([0 6]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if cc == 0
       Uni = [Pred Dec Post];
       figure();
    uniH = histogram(Uni);
    else
       Uni = [Pred Dec Post];
       figure();
       uniI = histogram(Uni);
    end
    
    cc = cc + 1;
end