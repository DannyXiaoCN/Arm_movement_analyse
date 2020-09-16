monkey_names = {'Hobbit','Isildur'};
ll = 0;
all_ampl_h_pre = [];
all_ampl_h_dec = [];
all_ampl_h_post = [];

all_dir_h_pre = [];
all_dir_h_dec = [];
all_dir_h_post = [];

all_ampl_i_pre = [];
all_ampl_i_dec = [];
all_ampl_i_post = [];

all_dir_i_pre = [];
all_dir_i_dec = [];
all_dir_i_post = [];

ii = 0;
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

        % new added to accumulate all amplitude
        
        if ii == 0
            all_ampl_h_pre = [all_ampl_h_pre, (ampl(logical(pred)))'];
            all_ampl_h_dec = [all_ampl_h_dec, (ampl(logical(dec)))'];
            all_ampl_h_post = [all_ampl_h_post, (ampl(logical(post)))'];
            
            all_dir_h_pre = [all_dir_h_pre, (deg2rad(dire(logical(pred))))'];
            all_dir_h_dec = [all_dir_h_dec, (deg2rad(dire(logical(dec))))'];
            all_dir_h_post = [all_dir_h_post, (deg2rad(dire(logical(post))))'];
        end
        
        if ii == 1
            all_ampl_i_pre = [all_ampl_i_pre,(ampl(logical(pred)))'];
            all_ampl_i_dec = [all_ampl_i_dec,(ampl(logical(dec)))'];
            all_ampl_i_post = [all_ampl_i_post,(ampl(logical(post)))'];
            
            all_dir_i_pre = [all_dir_i_pre,(deg2rad(dire(logical(pred))))'];
            all_dir_i_dec = [all_dir_i_dec,(deg2rad(dire(logical(dec))))'];
            all_dir_i_post = [all_dir_i_post,(deg2rad(dire(logical(post))))'];
        end
    end
    ii = ii + 1;
end

boxplot(all_ampl_h_pre','positions',1);
plot1_ylim = get(gca,'Ylim');
hold on;
boxplot(all_ampl_h_dec','positions',2);
plot2_ylim = get(gca,'Ylim');
boxplot(all_ampl_h_post','positions',3);
plot3_ylim = get(gca,'Ylim');
xlim([0 4]); ylim([min([plot1_ylim(1) plot2_ylim(1) plot3_ylim(1)]) max([plot1_ylim(2) plot2_ylim(2) plot3_ylim(2)])]);
set(gca,'xtick',[1 2 3],'xticklabels',{'pre' 'dec' 'post'});
ylabel('Hobbit movement amplitude');
print(gcf,'-dpng','/Users/xiaobocheng/Desktop/Monkey_Data/SMA_Monkey/Hobbit-box.png');

boxplot(all_ampl_i_pre','positions',1);
plot1_ylim = get(gca,'Ylim');
hold on;
boxplot(all_ampl_i_dec','positions',2);
plot2_ylim = get(gca,'Ylim');
boxplot(all_ampl_i_post','positions',3);
plot3_ylim = get(gca,'Ylim');
xlim([0 4]); ylim([min([plot1_ylim(1) plot2_ylim(1) plot3_ylim(1)]) max([plot1_ylim(2) plot2_ylim(2) plot3_ylim(2)])]);
set(gca,'xtick',[1 2 3],'xticklabels',{'pre' 'dec' 'post'});
ylabel('Isildur movement amplitude');
print(gcf,'-dpng','/Users/xiaobocheng/Desktop/Monkey_Data/SMA_Monkey/Isildur-box.png');
clf;

subplot(1,3,1);
polarscatter(all_dir_h_pre' ,all_ampl_h_pre');
title('Hobbit Pre-Decision');
subplot(1,3,2);
polarscatter(all_dir_h_dec' ,all_ampl_h_dec');
title('Hobbit Decision');
subplot(1,3,3);
polarscatter(all_dir_h_post' ,all_ampl_h_post');
title('Hobbit Post-Decision');
print(gcf,'-dpng','/Users/xiaobocheng/Desktop/Monkey_Data/SMA_Monkey/Hobbit-scatter.png');
clf;

subplot(1,3,1);
polarscatter(all_dir_i_pre' ,all_ampl_i_pre');
title('Isildur Pre-Decision');
subplot(1,3,2);
polarscatter(all_dir_i_dec' ,all_ampl_i_dec');
title('Isildur Decision');
subplot(1,3,3);
polarscatter(all_dir_i_post' ,all_ampl_i_post');
title('Isildur Post-Decision');
print(gcf,'-dpng','/Users/xiaobocheng/Desktop/Monkey_Data/SMA_Monkey/Isildur-scatter.png');
clf;