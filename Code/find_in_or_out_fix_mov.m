total_num_m = 0;
not_in_m = 0;
in_fixation_m = 0;
not_in_amp_m = 0;
in_amp_m = 0;
total_num_i = 0;
not_in_i = 0;
in_fixation_i = 0;
not_in_amp_i = 0;
in_amp_i = 0;

diff_1_2_m = 0;
diff_1_2_no_m = 0;
diff_1_2_i = 0;
diff_1_2_no_i = 0;

no_think_num_m = 0;
no_think_amp_m = 0;
no_think_num_i = 0;

no_pre_sum_m = 0;
no_pre_sum_i = 0;

get_reward_last_trial_m = 0;
get_reward_last_trial_i = 0;

no_pre_reward_m = 0;
no_pre_reward_i = 0;

amp_mat_m = [];
amp_mat_i = [];
aft_mat_m = [];
aft_mat_i = [];
bef_mat_m = [];
bef_mat_i = [];
exp_dif_m = [];
exp_dif_i = [];

looking_m_p = [];
looking_m_a = [];
looking_i_p = [];
looking_i_a = [];





monkey_names = {'Hobbit','Isildur'};
ll = 0;
mm = 0;
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
        load(sprintf('%s/%s_%s_corrected_movements.mat',monkey_dir,monkey_name,date));
        load(sprintf('/Users/xiaobocheng/Desktop/monkey_data/Arm_Movements/%s-%sarm_movements.mat',monkey_name,date));
       
        [siz,~] = size(MoveAmp);
        for trial_num = 1:siz
           
            cur_mov_amp = MoveAmp(trial_num,:);
            cur_mov_dir = MoveDir(trial_num,:);
            categorize_fixation_movement;
            
        end

    end
    mm = mm + 1;
end

figure;
subplot(3,1,1)
histogram(amp_mat_m,linspace(min([amp_mat_m aft_mat_m bef_mat_m]),max([amp_mat_m aft_mat_m bef_mat_m]),10));
subplot(3,1,2)
histogram(aft_mat_m,linspace(min([amp_mat_m aft_mat_m bef_mat_m]),max([amp_mat_m aft_mat_m bef_mat_m]),10));
subplot(3,1,3)
histogram(bef_mat_m,linspace(min([amp_mat_m aft_mat_m bef_mat_m]),max([amp_mat_m aft_mat_m bef_mat_m]),10));

xlabel('predecision movement amplitude');
ylabel('# of movement');
title('Monkey Hobbit Pre-Decision Amplitude Distribution');
print(gcf,'-dpng','/Users/xiaobocheng/Desktop/monkey_data/Los_plots/pre_histo/Monkey_M-pre_histo_no_filter.png');


figure;
subplot(3,1,1)
histogram(amp_mat_i,linspace(min([amp_mat_i aft_mat_i bef_mat_i]),max([amp_mat_i aft_mat_i bef_mat_i]),10));
subplot(3,1,2)
histogram(aft_mat_i,linspace(min([amp_mat_i aft_mat_i bef_mat_i]),max([amp_mat_i aft_mat_i bef_mat_i]),10));
subplot(3,1,3)
histogram(bef_mat_i,linspace(min([amp_mat_i aft_mat_i bef_mat_i]),max([amp_mat_i aft_mat_i bef_mat_i]),10));
xlabel('predecision movement amplitude');
ylabel('# of movement');
title('Monkey Isildur Pre-Decision Amplitude Distribution');
print(gcf,'-dpng','/Users/xiaobocheng/Desktop/monkey_data/Los_Plots/pre_histo/Monkey_I-pre_histo_no_filter.png');
% 
% figure;
% histogram(exp_dif_m,linspace(min([exp_dif_m exp_dif_i]),max([exp_dif_m exp_dif_i]),10));
% xlabel('Expectation value difference');
% ylabel('# of movement');
% title('Monkey Hobbit Expectation value difference Distribution objective');
% print(gcf,'-dpng','/home/bochengxiao/Monkey_Data/Los_Plots/pre_histo/Monkey_M-Exp-dif.png');
% 
% figure;
% histogram(exp_dif_i,linspace(min([exp_dif_m exp_dif_i]),max([exp_dif_m exp_dif_i]),10));
% xlabel('predecision movement amplitude');
% ylabel('# of movement');
% title('Monkey Isildur Expectation value difference Distribution objective');
% print(gcf,'-dpng','/home/bochengxiao/Monkey_Data/Los_Plots/pre_histo/Monkey_I-Exp-dif.png');
% 
% 
% 
% 
% figure;
% histogram(looking_m_a,linspace(min([looking_m_a looking_i_a]),max([looking_m_a looking_i_a]),10));
% xlabel('Doing pre-decision movement when fixing at amout');
% ylabel('# of amount');
% title('Monkey Hobbit');
% print(gcf,'-dpng','/home/bochengxiao/Monkey_Data/Los_Plots/pre_histo/Monkey_M-looking-amount.png');
% 
% figure;
% histogram(looking_m_p,linspace(min([looking_m_p looking_i_p]),max([looking_m_p looking_i_p]),10));
% xlabel('Doing pre-decision movement when fixing at probability');
% ylabel('# of probability');
% title('Monkey Hobbit');
% print(gcf,'-dpng','/home/bochengxiao/Monkey_Data/Los_Plots/pre_histo/Monkey_M-looking-probability.png');
% 
% figure;
% histogram(looking_i_a,linspace(min([looking_m_a looking_i_a]),max([looking_m_a looking_i_a]),10));
% xlabel('Doing pre-decision movement when fixing at amout');
% ylabel('# of amount');
% title('Monkey Isildur');
% print(gcf,'-dpng','/home/bochengxiao/Monkey_Data/Los_Plots/pre_histo/Monkey_I-looking-amount.png');
% 
% figure;
% histogram(looking_i_p,linspace(min([looking_m_p looking_i_p]),max([looking_m_p looking_i_p]),10));
% xlabel('Doing pre-decision movement when fixing at probability');
% ylabel('# of probability');
% title('Monkey Isildur');
% print(gcf,'-dpng','/home/bochengxiao/Monkey_Data/Los_Plots/pre_histo/Monkey_I-looking-probability.png');
% 


% 
% 
% 
% 
% 















