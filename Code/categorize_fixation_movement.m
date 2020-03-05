if  mm == 0
    flag = 0;
    
    if any(PreDecision(trial_num,:))
        if trial_num ~= 1
            if ~isnan(TSEventBHV.RewardDelivered(trial_num - 1,:))
                get_reward_last_trial_m = get_reward_last_trial_m + 1;
            end
        end
        cur_tod = TOD_M.TOD(trial_num,:);
        ins = abs(cur_tod(1,1)*cur_tod(1,2) - cur_tod(1,3)*cur_tod(1,4));
        diff_1_2_m = diff_1_2_m + ins;
        cur_pre_dec = PreDecision(trial_num,:);
        target = find(cur_pre_dec~=0);
        [a,b] = size(target);
        target_fix = find(~isnan(FixbySacDet.whichAttribute(trial_num,:)));
        [~,cols] = size(target_fix);
        min_time = 9999;
        for cnt_f = 1:cols
            cur_start = FixOnFirst.CodeTime(trial_num,target_fix(1,cnt_f));
            if cur_start < min_time
                min_time = cur_start;
            end
        end
        
        for cnt = 1:b
            total_num_m = total_num_m + 1;
            for cnt_f = 1:cols
                cur_start = FixOnFirst.CodeTime(trial_num,target_fix(1,cnt_f));
                cur_end = cur_start + 350;
                cur_att = FixbySacDet.whichAttribute(trial_num,target_fix(1,cnt_f));
                %                 if abs(cur_mov_dir(1,target(1,cnt))- 90) < 10 || abs(cur_mov_dir(1,target(1,cnt))- 210) < 10 || abs(cur_mov_dir(1,target(1,cnt))- 330) < 10
                %                     if BHV.AnalogData{trial_num}.Joystick(1,1) < 1 && BHV.AnalogData{trial_num}.Joystick(1,2) < 1
                if cur_mov_amp(1,target(1,cnt)) > 1.25
                    svd_vec = [monkey_name,date,num2str(trial_num),num2str(target(1,cnt))];
                    save(['/home/bochengxiao/Monkey_Data/interesting_predec/' monkey_name '-' date '-' num2str(trial_num) ],'svd_vec');
                end
                
                amp_mat_m = [amp_mat_m cur_mov_amp(1,target(1,cnt))];
                if cur_pre_dec(1,target(1,cnt)) > cur_start && cur_pre_dec(1,target(1,cnt)) < cur_end
                    in_fixation_m = in_fixation_m + 1;
                    aft_mat_m = [aft_mat_m cur_mov_amp(1,target(1,cnt))];
                    if cur_att == 1
                        looking_m_a = [looking_m_a cur_tod(1,1)];
                    elseif cur_att == 2
                        looking_m_p = [looking_m_p cur_tod(1,2)];
                    elseif cur_att == 3
                        looking_m_a = [looking_m_a cur_tod(1,3)];
                    elseif cur_att == 4
                        looking_m_p = [looking_m_p cur_tod(1,4)];
                    end
                    if flag == 0
                        exp_dif_m = [exp_dif_m abs(cur_tod(1,1)*cur_tod(1,2) - cur_tod(1,3)*cur_tod(1,4))];
                        flag = 1;
                    end
                else
                    if cur_pre_dec(1,target(1,cnt)) < min_time
                        bef_mat_m = [bef_mat_m cur_mov_amp(1,target(1,cnt))];
                        continue
                    end
                    if flag == 0
                        exp_dif_m = [exp_dif_m abs(cur_tod(1,1)*cur_tod(1,2) - cur_tod(1,3)*cur_tod(1,4))];
                        flag = 1;
                    end
                    aft_mat_m = [aft_mat_m cur_mov_amp(1,target(1,cnt))];
                    not_in_m = not_in_m + 1;
                    not_in_amp_m = not_in_amp_m + cur_mov_amp(1,target(1,cnt));
                end
            end
            %                 end
            %             end
        end
    else
        if trial_num ~= 1
            if ~isnan(TSEventBHV.RewardDelivered(trial_num - 1,:))
                no_pre_reward_m = no_pre_reward_m + 1;
            end
        end
        no_pre_sum_m = no_pre_sum_m + 1;
        cur_tod = TOD_M.TOD(trial_num,:);
        ins = abs(cur_tod(1,1)*cur_tod(1,2) - cur_tod(1,3)*cur_tod(1,4));
        diff_1_2_no_m = diff_1_2_no_m + ins;
        
        
    end
else
    flag = 0;
    if any(PreDecision(trial_num,:))
        if trial_num ~= 1
            if ~isnan(TSEventBHV.RewardDelivered(trial_num - 1,:))
                get_reward_last_trial_i = get_reward_last_trial_i + 1;
            end
        end
        cur_pre_dec = PreDecision(trial_num,:);
        cur_tod = TOD_M.TOD(trial_num,:);
        ins = abs(cur_tod(1,1)*cur_tod(1,2) - cur_tod(1,3)*cur_tod(1,4));
        diff_1_2_i = diff_1_2_i + ins;
        target = find(cur_pre_dec~=0);
        [a,b] = size(target);
        target_fix = find(~isnan(FixbySacDet.whichAttribute(trial_num,:)));
        [~,cols] = size(target_fix);
        min_time = 9999;
        for cnt_f = 1:cols
            cur_start = FixOnFirst.CodeTime(trial_num,target_fix(1,cnt_f));
            if cur_start < min_time
                min_time = cur_start;
            end
        end
        
        for cnt_f = 1:cols
            for cnt = 1:b
                cur_start = FixOnFirst.CodeTime(trial_num,target_fix(1,cnt_f));
                cur_end = cur_start + 350;
                cur_att = FixbySacDet.whichAttribute(trial_num,target_fix(1,cnt_f));
                %                 if abs(cur_mov_dir(1,target(1,cnt))- 90) < 10 || abs(cur_mov_dir(1,target(1,cnt))- 210) < 10 || abs(cur_mov_dir(1,target(1,cnt))- 330) < 10
                %                     if BHV.AnalogData{trial_num}.Joystick(1,1) < 1 && BHV.AnalogData{trial_num}.Joystick(1,2) < 1
                amp_mat_i = [amp_mat_i cur_mov_amp(1,target(1,cnt))];
                
                if cur_mov_amp(1,target(1,cnt)) > 1.25
                    svd_vec = [monkey_name date num2str(trial_num) num2str(target(1,cnt))];
                    save(['/home/bochengxiao/Monkey_Data/interesting_predec/' monkey_name '-' date '-' num2str(trial_num) ],'svd_vec');
                end
                if cur_pre_dec(1,target(1,cnt)) > cur_start && cur_pre_dec(1,target(1,cnt)) < cur_end
                    in_fixation_i = in_fixation_i + 1;
                    aft_mat_i = [aft_mat_i cur_mov_amp(1,target(1,cnt))];
                    if cur_att == 1
                        looking_i_a = [looking_i_a cur_tod(1,1)];
                    elseif cur_att == 2
                        looking_i_p = [looking_i_p cur_tod(1,2)];
                    elseif cur_att == 3
                        looking_i_a = [looking_i_a cur_tod(1,3)];
                    elseif cur_att == 4
                        looking_i_p = [looking_i_p cur_tod(1,4)];
                    end
                    if flag == 0
                        exp_dif_i = [exp_dif_i abs(cur_tod(1,1)*cur_tod(1,2) - cur_tod(1,3)*cur_tod(1,4))];
                        flag = 1;
                    end
                else
                    if cur_pre_dec(1,target(1,cnt)) < min_time
                        bef_mat_i = [bef_mat_i cur_mov_amp(1,target(1,cnt))];
                        continue
                    end
                    if flag == 0
                        exp_dif_i = [exp_dif_i abs(cur_tod(1,1)*cur_tod(1,2) - cur_tod(1,3)*cur_tod(1,4))];
                        flag = 1;
                    end
                    aft_mat_i = [aft_mat_i cur_mov_amp(1,target(1,cnt))];
                    not_in_i = not_in_i + 1;
                    total_num_i = total_num_i + 1;
                    not_in_amp_i = not_in_amp_i + cur_mov_amp(1,target(1,cnt));
                end
                %                     end
                %                 end
            end
        end
        
    else
        if trial_num ~= 1
            if ~isnan(TSEventBHV.RewardDelivered(trial_num - 1,:))
                no_pre_reward_i = no_pre_reward_i + 1;
            end
        end
        no_pre_sum_i = no_pre_sum_i + 1;
        cur_tod = TOD_M.TOD(trial_num,:);
        ins = abs(cur_tod(1,1)*cur_tod(1,2) - cur_tod(1,3)*cur_tod(1,4));
        diff_1_2_no_i = diff_1_2_no_i + ins;
        
    end
end

