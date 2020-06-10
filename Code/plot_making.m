monkey_names = {'Hobbit','Isildur'};
ll = 0;
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
    figure();
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
        sz = size(ampl,1);
        dec = Decision_Index;
        pred = PreDecision_Index;
        post = PostDecision_Index;
        [dec_size,dec_cl] = size(boxplot(ampl(logical(dec))));
        [pred_size,pred_cl] = size(boxplot(ampl(logical(pred))));
        [post_size,post_cl] = size(boxplot(ampl(logical(post))));
        boxplot(ampl(logical(pred)),'positions',1);
        plot1_ylim = get(gca,'Ylim');
        hold on;
        boxplot(ampl(logical(dec)),'positions',2);
        plot2_ylim = get(gca,'Ylim');
        boxplot(ampl(logical(post)),'positions',3);
        plot3_ylim = get(gca,'Ylim');
        xlim([0 4]); ylim([min([plot1_ylim(1) plot2_ylim(1) plot3_ylim(1)]) max([plot1_ylim(2) plot2_ylim(2) plot3_ylim(2)])]);
        set(gca,'xtick',[1 2 3],'xticklabels',{'pre' 'dec' 'post'});
        ylabel('movement amplitude');
        print(gcf,'-dpng',['/Users/xiaobocheng/Desktop/Monkey_Data/SMA_Monkey/Los_Plots/Box_One/' monkey_name date '-scatter.png']);
        subplot(1,3,1);
        
        polarscatter(deg2rad(dire(logical(pred))),ampl(logical(pred)));
        
        title('Pre-Decision');
        subplot(1,3,2);

        polarscatter(deg2rad(dire(logical(dec))),ampl(logical(dec)));
                title('Decision');
        subplot(1,3,3);

        polarscatter(deg2rad(dire(logical(post))),ampl(logical(post)));
                title('Post-Decision');
        
        print(gcf,'-dpng',['/Users/xiaobocheng/Desktop/Monkey_Data/SMA_Monkey/Los_Plots/Circular_One/' monkey_name date '-scatter.png']);
        clf;
    end
end