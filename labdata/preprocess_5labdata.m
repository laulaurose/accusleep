clc; 
clear all; 
addpath(genpath("/work3/laurose/accusleep/labdata/data/"))
addpath(genpath("/zhome/dd/109414/Validationstudy/accusleep/helper_files/"))
I   = "/work3/laurose/accusleep/labdata/data/"; 
exp = ["Alessandro-cleaned-data/",...
        "Antoine-cleaned-data/",...
        "Kornum-cleaned-data_v2/",...
        "Maiken-cleaned-data/",...
        "Sebastian-cleaned-data/"];

idx      = ["W*","MB*","*-*","*_*","(*)*"];

sigfiles = ["/signal.mat","/signal.mat","/signal.edf","/signal.mat","/newsig.mat"];
labfiles = ["/labels.mat","/labels.mat","/labels.csv","/newSS.mat","/labels.mat"];
fs_all   = [128,512,400,nan,nan];

for j = 1:length(exp) % loops across experiments 
    disp(exp(j))
    subf = dir(strcat(I,exp(j),idx(j))); 

    for k = 1:length(subf)
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
                fs = load(fullfile(subf(k).folder,subf(k).name),"fs.mat");
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
            [~,signal] = edfread(I_sig);
            tab_lab    = readtable(I_lab);
            lbs        = tab_lab{:, 2};
            fs         = fs_all(j);

            % check that they are same lengths 
            assert(length(signal)/fs==length(lbs)*4)

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
            save(strcat(outdir,"signal.mat"),"signal")
            

        end 

        disp("--------------------------------")

    
    end




end 

