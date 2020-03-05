if TOD_M.TOD(trial_num,5)==11||TOD_M.TOD(trial_num,5)==12||TOD_M.TOD(trial_num,5)==15||TOD_M.TOD(trial_num,5)==16
    if FixbySacDet.whichAttribute(trial_num,target(1,cnt))<=2
        answ = 1;
    elseif FixbySacDet.whichAttribute(trial_num,target(1,cnt))>2
        answ = -1;
    end
elseif TOD_M.TOD(trial_num,5)==19||TOD_M.TOD(trial_num,5)==20||TOD_M.TOD(trial_num,5)==23||TOD_M.TOD(trial_num,5)==24
    if FixbySacDet.whichAttribute(trial_num,target(1,cnt))<=2
        answ = -1;
    elseif FixbySacDet.whichAttribute(trial_num,target(1,cnt))>2
        answ = 1;
    end
elseif TOD_M.TOD(trial_num,5)==17||TOD_M.TOD(trial_num,5)==18||TOD_M.TOD(trial_num,5)==21||TOD_M.TOD(trial_num,5)==22
    if FixbySacDet.whichAttribute(trial_num,target(1,cnt))<=2
        answ = -1;
    elseif FixbySacDet.whichAttribute(trial_num,target(1,cnt))>2
        answ = 0;
    end
elseif TOD_M.TOD(trial_num,5)==3||TOD_M.TOD(trial_num,5)==4||TOD_M.TOD(trial_num,5)==7||TOD_M.TOD(trial_num,5)==8
    if FixbySacDet.whichAttribute(trial_num,target(1,cnt))<=2
        answ = 0;
    elseif FixbySacDet.whichAttribute(trial_num,target(1,cnt))>2
        answ = -1;
    end
elseif TOD_M.TOD(trial_num,5)==1||TOD_M.TOD(trial_num,5)==2||TOD_M.TOD(trial_num,5)==5||TOD_M.TOD(trial_num,5)==6
    if FixbySacDet.whichAttribute(trial_num,target(1,cnt))<=2
        answ = 0;
    elseif FixbySacDet.whichAttribute(trial_num,target(1,cnt))>2
        answ = 1;
    end
elseif TOD_M.TOD(trial_num,5)==9||TOD_M.TOD(trial_num,5)==10||TOD_M.TOD(trial_num,5)==13||TOD_M.TOD(trial_num,5)==14
    if FixbySacDet.whichAttribute(trial_num,target(1,cnt))<=2
        answ = 1;
    elseif FixbySacDet.whichAttribute(trial_num,target(1,cnt))>2
        answ = 0;
    end
end