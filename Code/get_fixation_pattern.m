function [fixatedAttribute, attributeMagnitude, fixatedPosition] = get_fixation_pattern(FixbySacDet,TOD_M)

% get_fixation_pattern.m takes fixation information and places into
% full-temporal resolution TRIALS X TIME matrices
%
% INPUTS
% FixbySacDet           structure from SMA_Monkey data files containing
%                       fixation information
% TOD_M                 TOD_M structure from SMA_Monkey data files 
%                       (contains spatial positions of presented options)
%
% OUTPUTS
% fixatedAttribute      TRIALS X TIME matrix of:
%                           1 when fixating amount of option 1
%                           2 when fixating probability of option 1
%                           3 when fixating amount of option 2
%                           4 when fixating probability of option 2
%                           NaN when nothing is fixated
% attributeMagnitude    TRIALS X TIME matrix of magnitudes of the fixated
%                       attribute, NaN when nothing is fixated
% fixatedPosition       TRIALS X TIME matrix of position in degrees of the
%                       currently fixated option (top option 90, left
%                       option 210, right option 330)

num_trials = size(FixbySacDet.FixStart,1);

max_time = nanmax(nanmax(FixbySacDet.FixEnd));

fixatedAttribute = nan(num_trials,max_time);
attributeMagnitude = nan(num_trials,max_time);
fixatedPosition = nan(num_trials,max_time);

for trial_num = 1:num_trials
    for fix_num = 1:size(FixbySacDet.FixStart,2)
        if FixbySacDet.FixStart(trial_num,fix_num)==0
            continue
        end
        fixatedAttribute(trial_num,FixbySacDet.FixStart(trial_num,fix_num):FixbySacDet.FixEnd(trial_num,fix_num)) = FixbySacDet.whichAttribute(trial_num,fix_num);
        attributeMagnitude(trial_num,FixbySacDet.FixStart(trial_num,fix_num):FixbySacDet.FixEnd(trial_num,fix_num)) = FixbySacDet.FixAttributeMagnitude(trial_num,fix_num);
        if FixbySacDet.whichAttribute(trial_num,fix_num)~=0
            if TOD_M.TOD(trial_num,5)<5
                if FixbySacDet.whichAttribute(trial_num,fix_num)<=2
                    fixatedPosition(trial_num,FixbySacDet.FixStart(trial_num,fix_num):FixbySacDet.FixEnd(trial_num,fix_num)) = 90;
                else
                    fixatedPosition(trial_num,FixbySacDet.FixStart(trial_num,fix_num):FixbySacDet.FixEnd(trial_num,fix_num)) = 330;
                end
            elseif TOD_M.TOD(trial_num,5)>=5&&TOD_M.TOD(trial_num,5)<9
                if FixbySacDet.whichAttribute(trial_num,fix_num)<=2
                    fixatedPosition(trial_num,FixbySacDet.FixStart(trial_num,fix_num):FixbySacDet.FixEnd(trial_num,fix_num)) = 330;
                else
                    fixatedPosition(trial_num,FixbySacDet.FixStart(trial_num,fix_num):FixbySacDet.FixEnd(trial_num,fix_num)) = 90;
                end
            elseif TOD_M.TOD(trial_num,5)>=9&&TOD_M.TOD(trial_num,5)<13
                if FixbySacDet.whichAttribute(trial_num,fix_num)<=2
                    fixatedPosition(trial_num,FixbySacDet.FixStart(trial_num,fix_num):FixbySacDet.FixEnd(trial_num,fix_num)) = 330;
                else
                    fixatedPosition(trial_num,FixbySacDet.FixStart(trial_num,fix_num):FixbySacDet.FixEnd(trial_num,fix_num)) = 210;
                end
            elseif TOD_M.TOD(trial_num,5)>=13&&TOD_M.TOD(trial_num,5)<17
                if FixbySacDet.whichAttribute(trial_num,fix_num)<=2
                    fixatedPosition(trial_num,FixbySacDet.FixStart(trial_num,fix_num):FixbySacDet.FixEnd(trial_num,fix_num)) = 210;
                else
                    fixatedPosition(trial_num,FixbySacDet.FixStart(trial_num,fix_num):FixbySacDet.FixEnd(trial_num,fix_num)) = 330;
                end
            elseif TOD_M.TOD(trial_num,5)>=17&&TOD_M.TOD(trial_num,5)<21
                if FixbySacDet.whichAttribute(trial_num,fix_num)<=2
                    fixatedPosition(trial_num,FixbySacDet.FixStart(trial_num,fix_num):FixbySacDet.FixEnd(trial_num,fix_num)) = 210;
                else
                    fixatedPosition(trial_num,FixbySacDet.FixStart(trial_num,fix_num):FixbySacDet.FixEnd(trial_num,fix_num)) = 90;
                end
            else
                if FixbySacDet.whichAttribute(trial_num,fix_num)<=2
                    fixatedPosition(trial_num,FixbySacDet.FixStart(trial_num,fix_num):FixbySacDet.FixEnd(trial_num,fix_num)) = 90;
                else
                    fixatedPosition(trial_num,FixbySacDet.FixStart(trial_num,fix_num):FixbySacDet.FixEnd(trial_num,fix_num)) = 210;
                end
            end
        end
    end
end