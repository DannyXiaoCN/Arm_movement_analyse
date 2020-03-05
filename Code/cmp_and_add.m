if cur_mov_amp(1,target(1,cnt)) >= 0 && cur_mov_amp(1,target(1,cnt)) <= 1
    amp_mat_m(1,1) = amp_mat_m(1,1) + 1;
elseif cur_mov_amp(1,target(1,cnt)) >= 1 && cur_mov_amp(1,target(1,cnt)) <= 2
    amp_mat_m(1,2) = amp_mat_m(1,2) + 1;
elseif cur_mov_amp(1,target(1,cnt)) >= 2 && cur_mov_amp(1,target(1,cnt)) <= 3
    amp_mat_m(1,3) = amp_mat_m(1,3) + 1;
elseif cur_mov_amp(1,target(1,cnt)) >= 3 && cur_mov_amp(1,target(1,cnt)) <= 4
    amp_mat_m(1,4) = amp_mat_m(1,4) + 1;
elseif cur_mov_amp(1,target(1,cnt)) >= 4 && cur_mov_amp(1,target(1,cnt)) <= 5
    amp_mat_m(1,5) = amp_mat_m(1,5) + 1;
end