if TOD_M.TOD(trial_num,5)<5
    if FixbySacDet.whichAttribute(trial_num,fixnum)<=2
        fix_opt_pos(trial_num,fixnum) = 90;
    elseif FixbySacDet.whichAttribute(trial_num,fixnum)>2
        fix_opt_pos(trial_num,fixnum) = 330;
    else
        fix_opt_pos(trial_num,fixnum) = nan;
    end
elseif TOD_M.TOD(trial_num,5)>=5&&TOD_M.TOD(trial_num,5)<9
    if FixbySacDet.whichAttribute(trial_num,fixnum)<=2
        fix_opt_pos(trial_num,fixnum) = 330;
    elseif FixbySacDet.whichAttribute(trial_num,fixnum)>2
        fix_opt_pos(trial_num,fixnum) = 90;
    else
        fix_opt_pos(trial_num,fixnum) = nan;
    end
elseif TOD_M.TOD(trial_num,5)>=9&&TOD_M.TOD(trial_num,5)<13
    if FixbySacDet.whichAttribute(trial_num,fixnum)<=2
        fix_opt_pos(trial_num,fixnum) = 330;
    elseif FixbySacDet.whichAttribute(trial_num,fixnum)>2
        fix_opt_pos(trial_num,fixnum) = 210;
    else
        fix_opt_pos(trial_num,fixnum) = nan;
    end
elseif TOD_M.TOD(trial_num,5)>=13&&TOD_M.TOD(trial_num,5)<17
    if FixbySacDet.whichAttribute(trial_num,fixnum)<=2
        fix_opt_pos(trial_num,fixnum) = 210;
    elseif FixbySacDet.whichAttribute(trial_num,fixnum)>2
        fix_opt_pos(trial_num,fixnum) = 330;
    else
        fix_opt_pos(trial_num,fixnum) = nan;
    end
elseif TOD_M.TOD(trial_num,5)>=17&&TOD_M.TOD(trial_num,5)<21
    if FixbySacDet.whichAttribute(trial_num,fixnum)<=2
        fix_opt_pos(trial_num,fixnum) = 210;
    elseif FixbySacDet.whichAttribute(trial_num,fixnum)>2
        fix_opt_pos(trial_num,fixnum) = 90;
    else
        fix_opt_pos(trial_num,fixnum) = nan;
    end
else
    if FixbySacDet.whichAttribute(trial_num,fixnum)<=2
        fix_opt_pos(trial_num,fixnum) = 90;
    elseif FixbySacDet.whichAttribute(trial_num,fixnum)>2
        fix_opt_pos(trial_num,fixnum) = 210;
    else
        fix_opt_pos(trial_num,fixnum) = nan;
    end
end