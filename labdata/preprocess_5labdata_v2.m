I       = "/work3/laurose/accusleep/labdata/data/"; 
exp     = ["Alessandro-cleaned-data/",...
           "Antoine-cleaned-data/",...
           "Kornum-cleaned-data_v2/",...
           "Maiken-cleaned-data/",...
           "Sebastian-cleaned-data/"];

idx      = ["W*","MB*","*-*","*_*","(*)*"];

sigfiles = ["/signal.mat","/signal.mat","/signal.mat","/signal.mat","/signal.mat"];
labfiles = ["/labels.mat","/labels.mat","/labels.csv","/newSS.mat","/labels.mat"];
fs_all   = [128,512,400,nan,nan];


for j = 1:length(exp) % loops across experiments 
    disp(exp(j))
    subf = dir(strcat(I,exp(j),idx(j))); 

    for k = 1:length(subf)
        clear signal EEG ss lbs labels time_original resampled_signal time_resampled EEG1 EEG2 EEG3 EEG4 EMG
        disp(subf(k).name)
        I_sig = strcat(fullfile(subf(k).folder,subf(k).name),sigfiles(j));
        I_lab = strcat(fullfile(subf(k).folder,subf(k).name),labfiles(j));
        
        if exp(j)~="Kornum-cleaned-data_v2/"
            signal = load(I_sig);
            ss = load(I_lab);
            fieldnamesSig = fieldnames(signal);
            fieldnamesLab = fieldnames(ss);
            EEG    = signal.(fieldnamesSig{1});
            lbs = ss.(fieldnamesLab{1});
            if ~isnan(fs_all(j))
               fs = fs_all(j);
            else 
               fs = load(strcat(fullfile(subf(k).folder,subf(k).name),"/fs.mat")).fs;
            end 
            % check that they are same lengths 
            assert(length(EEG)/fs==length(lbs)*4)
            % change the labels such that they fit 
            labels = nan(1,length(lbs));
            labels(find(lbs==1)) = 2; % wake = 2
            labels(find(lbs==2)) = 3; % nrem = 3
            labels(find(lbs==3)) = 1; % rem  = 1 
            labels(find(lbs==4)) = 4; % artefacts 
            disp(unique(lbs))
            assert(sum(isnan(labels))==0)
            outdir = strcat(fullfile(subf(k).folder,subf(k).name),"/");
            save(strcat(outdir,"labels_accusleep.mat"),"labels")
        else
            signal        = load(I_sig);
            fieldnamesSig = fieldnames(signal);
            EEG           = signal.(fieldnamesSig{1});
            tab_lab       = readtable(I_lab);
            lbs           = tab_lab{:, 2};
            fs            = fs_all(j);

            % check that they are same lengths 
            assert(length(EEG)/fs==length(lbs)*4)

            % change the labels such that they fit 
            labels = nan(1,length(lbs));

            labels(find(lbs==1)) = 2; % wake = 2
            labels(find(lbs==2)) = 3; % nrem = 3
            labels(find(lbs==3)) = 1; % rem  = 1 
            labels(find(lbs==4)) = 4; % artefacts 

            disp(unique(lbs))
            assert(sum(isnan(labels))==0)
            outdir = strcat(fullfile(subf(k).folder,subf(k).name),"/");
            save(strcat(outdir,"labels_accusleep.mat"),"labels")
        end 
	   % resample to 128 
     
        new_fs = 128; 
        disp("size of signal")
        disp(size(EEG))
	    time_original = (0:length(EEG)-1) / fs;
        a = figure('Visible','off'); 

        for i=1:size(EEG,1)
            resampled_signal(i,:) = resample(EEG(i,:),new_fs,fs);
	    time_resampled = (0:length(resampled_signal)-1) / new_fs;	
            subplot(size(EEG,1),1,i)
            plot(time_original,EEG(i,:))
            hold on 
            plot(time_resampled,resampled_signal(i,:),'--r')
        end     
	
  	disp(size(resampled_signal))
        disp(strcat("/work3/laurose/accusleep/labdata/inprogress/",subf(k).name,".png"))
        saveas(a,strcat("/work3/laurose/accusleep/labdata/inprogress/",subf(k).name,".png"))
	close(a)
        assert(length(resampled_signal)/new_fs==length(lbs)*4)
        assert(size(resampled_signal,1)<size(resampled_signal,2))
       
        if exp(j)=="Alessandro-cleaned-data/"
            EEG1 = resampled_signal(1,:);
            save(strcat(outdir,"EEG1.mat"),"EEG1")
            EMG = resampled_signal(2,:);
            save(strcat(outdir,"EMG.mat"),"EMG")


        elseif exp(j)=="Antoine-cleaned-data/"
            EEG1 = resampled_signal(1,:);
            save(strcat(outdir,"EEG1.mat"),"EEG1")
            EEG2 = resampled_signal(2,:);
            save(strcat(outdir,"EEG2.mat"),"EEG2")
            EEG3 = resampled_signal(3,:);
            save(strcat(outdir,"EEG3.mat"),"EEG3")
            EEG4 = resampled_signal(4,:);
            save(strcat(outdir,"EEG4.mat"),"EEG4")
            EMG = resampled_signal(5,:);
            save(strcat(outdir,"EMG.mat"),"EMG")

        elseif exp(j)=="Kornum-cleaned-data_v2/"    
            EEG1 = resampled_signal(1,:);
            save(strcat(outdir,"EEG1.mat"),"EEG1")
            EEG2 = resampled_signal(2,:);
            save(strcat(outdir,"EEG2.mat"),"EEG2")
            EMG = resampled_signal(3,:);
            save(strcat(outdir,"EMG.mat"),"EMG")

        elseif exp(j)=="Maiken-cleaned-data/"    
            EEG1 = resampled_signal(1,:);
            save(strcat(outdir,"EEG1.mat"),"EEG1")
            EMG = resampled_signal(2,:);
            save(strcat(outdir,"EMG.mat"),"EMG")

        elseif exp(j)=="Sebastian-cleaned-data/"    
            EEG1 = resampled_signal(1,:);
            save(strcat(outdir,"EEG1.mat"),"EEG1")
            EEG2 = resampled_signal(2,:);
            save(strcat(outdir,"EEG2.mat"),"EEG2")
            EMG = resampled_signal(3,:);
            save(strcat(outdir,"EMG.mat"),"EMG")
        end 

	    %save(strcat(outdir,"signal_accusleep.mat"),"resampled_signal")
	
        disp("--------------------------------")

    
    end




end
