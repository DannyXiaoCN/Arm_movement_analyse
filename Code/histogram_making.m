monkey_names = {'Hobbit','Isildur'};
ll = 0;
cc = 0;
figure();
run pre_histo.m;
H_bins = uniH.NumBins;
I_bins = uniI.NumBins;
for monkey_num = 1:numel(monkey_names)
    monkey_name = monkey_names{monkey_num};
    if strcmpi(monkey_name,'Hobbit')
        monkey_dir = '/home/bochengxiao/Monkey_Data/SMA_Monkey/MonkeyH';
    elseif strcmpi(monkey_name,'Isildur')
        monkey_dir = '/home/bochengxiao/Monkey_Data/SMA_Monkey/MonkeyI';
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
        load(sprintf('/home/bochengxiao/Monkey_Data/Arm_Movements/%s-%sarm_movements.mat',monkey_name,date));
        
        %%%%%%% INSERT ANALYSIS CODE HERE %%%%%
        ampl = MoveAmp;
        dire = MoveDir;
        [sz,sp] = size(ampl);
        dec = Decision_Index;
        pred = PreDecision_Index;
        post = PostDecision_Index;

        if cc == 0
          pred_his = histogram(ampl(logical(pred)).',H_bins);
          hold on;
          dec_his = histogram(ampl(logical(dec)).',H_bins);
          post_his = histogram(ampl(logical(post)).',H_bins);
          
        else
          pred_his = histogram(ampl(logical(pred)).',I_bins);
          hold on;
          dec_his = histogram(ampl(logical(dec)).',I_bins);
          post_his = histogram(ampl(logical(post)).',I_bins);
            
        end
        
        print(gcf,'-dpng',['/home/bochengxiao/Monkey_Data/Los_Plots/Histogram/merge/' monkey_name date '-histogram.png']);
        hold off;
        clf;
        if cc == 0
          pred_his = histogram(ampl(logical(pred)).',uniH.NumBins);
          print(gcf,'-dpng',['/home/bochengxiao/Monkey_Data/Los_Plots/Histogram/' monkey_name date '-predecision-histogram.png']);
          xlabel('predecision movement amplitude');
          ylabel('# of movement');
          dec_his = histogram(ampl(logical(dec)).',uniH.NumBins);
          xlabel('decision movement amplitude');
          ylabel('# of movement');
          print(gcf,'-dpng',['/home/bochengxiao/Monkey_Data/Los_Plots/Histogram/' monkey_name date '-decision-histogram.png']);
          post_his = histogram(ampl(logical(post)).',uniH.NumBins);
          xlabel('postdecison movement amplitude');
          ylabel('# of movement');
          print(gcf,'-dpng',['/home/bochengxiao/Monkey_Data/Los_Plots/Histogram/' monkey_name date '-postdecision-histogram.png']);
          [pre_n,pre_e] = histcounts(ampl(logical(pred)).',H_bins);
          [dec_n,dec_e] = histcounts(ampl(logical(dec)).',H_bins);
          [post_n,post_e] = histcounts(ampl(logical(post)).',H_bins);
          C = [pre_n.' dec_n.' post_n.'];
          figure();
          imagesc([1 2 3],pre_e,C);
          set(gca,'XTick',[1 2 3],'XTickLabel',{'pre','dec','post'});
          set(gca,'YDir','Normal');
          set(gca,'CLim',[0 50]);
          ylabel('movement amplitude');
          cbar = colorbar;
          ylabel(cbar,'number of movements');
          print(gcf,'-dpng',['/home/bochengxiao/Monkey_Data/Los_Plots/imagesc/' monkey_name date '-imagesc.png']);
        else
          pred_his = histogram(ampl(logical(pred)).',I_bins);
                    xlabel('predecision movement amplitude');
          ylabel('# of movement');
          print(gcf,'-dpng',['/home/bochengxiao/Monkey_Data/Los_Plots/Histogram/' monkey_name date '-predecision-histogram.png']);
          dec_his = histogram(ampl(logical(dec)).',I_bins);
          xlabel('decision movement amplitude');
          ylabel('# of movement');
          print(gcf,'-dpng',['/home/bochengxiao/Monkey_Data/Los_Plots/Histogram/' monkey_name date '-decision-histogram.png']);
          post_his = histogram(ampl(logical(post)).',I_bins);
          xlabel('postdecison movement amplitude');
          ylabel('# of movement');
          print(gcf,'-dpng',['/home/bochengxiao/Monkey_Data/Los_Plots/Histogram/' monkey_name date '-postdecision-histogram.png']);
          [pre_n,pre_e] = histcounts(ampl(logical(pred)).',I_bins);
          [dec_n,dec_e] = histcounts(ampl(logical(dec)).',I_bins);
          [post_n,post_e] = histcounts(ampl(logical(post)).',I_bins);
          C = [pre_n.' dec_n.' post_n.'];
          figure();
          imagesc([1 2 3],pre_e,C);
          set(gca,'XTick',[1 2 3],'XTickLabel',{'pre','dec','post'})
          set(gca,'YDir','Normal');
          set(gca,'CLim',[0 50]);
          ylabel('movement amplitude');
          cbar = colorbar;
          ylabel(cbar,'number of movements');
          print(gcf,'-dpng',['/home/bochengxiao/Monkey_Data/Los_Plots/imagesc/' monkey_name date '-imagesc.png']);
        end
    end
    cc = cc + 1;
end