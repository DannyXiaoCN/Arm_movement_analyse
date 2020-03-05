
% This is a helper script for rec_time_run.

% First check if in this trial the monkey made a decision. If not, add
% 'NaN' to recording matrix.
if any(Decision(trial_num,:)~=0)
    
    cur_dec = Decision(trial_num,:);
    % Find the valid ones
    target = find(Decision(trial_num,:)~=0);
    target_fix = find((FixbySacDet.FixEnd(trial_num,:))~=0);
    [~,cols] = size(target_fix);
    % Find the last fixation end time
    
    
    % check if the decision making time > last fixation end time and also
    % if the monkey made fixation in this trial. If so, record it. If not,
    % fill it with 'NaN'
    if cols == 0
        reaction_time = [reaction_time cur_dec(1,target)];
    else
        raw_time = cur_dec(1,target);
        for cnt_f = 1:cols
            cur_start = FixbySacDet.FixStart(trial_num,target_fix(1,cnt_f));
            cur_end = FixbySacDet.FixEnd(trial_num,target_fix(1,cnt_f));
            if cur_start < raw_time && cnt_f == cols
                rslt_time = raw_time - cur_start;
                reaction_time = [reaction_time rslt_time];
                break;
            elseif cur_start < raw_time && FixbySacDet.FixStart(trial_num,target_fix(1,cnt_f + 1)) > raw_time
                rslt_time = raw_time - cur_start;
                reaction_time = [reaction_time rslt_time];
                break;
            end
            if cur_start > raw_time
                reaction_time = [reaction_time cur_dec(1,target)];
                break;
            end
        end
    end
    
else
    reaction_time = [reaction_time nan];
end