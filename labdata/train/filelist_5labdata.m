%% For testing 
clear all; 
clc; 

addpath(genpath("/work3/laurose/accusleep/labdata/"))
I       = "/work3/laurose/accusleep/labdata/data/"; 
outf    = ["fileList_Alessandro.mat","fileList_Antoine.mat","fileList_Kornum.mat","fileList_Maiken.mat","fileList_Sebastian.mat"] ;
exp_all = {["Antoine-cleaned-data/","Kornum-cleaned-data_v2/","Maiken-cleaned-data/", "Sebastian-cleaned-data/"],...
           ["Alessandro-cleaned-data/","Kornum-cleaned-data_v2/","Maiken-cleaned-data/", "Sebastian-cleaned-data/"],...
           ["Alessandro-cleaned-data/","Antoine-cleaned-data/","Maiken-cleaned-data/", "Sebastian-cleaned-data/"],...
           ["Alessandro-cleaned-data/","Antoine-cleaned-data/","Kornum-cleaned-data_v2/", "Sebastian-cleaned-data/"],...
           ["Alessandro-cleaned-data/","Antoine-cleaned-data/","Kornum-cleaned-data_v2/","Maiken-cleaned-data/"]};

idx_all  = {["MB*","*-*","*_*","(*)*"],...
            ["W*","*-*","*_*","(*)*"],...
            ["W*","MB*","*_*","(*)*"],...
            ["W*","MB*","*-*","(*)*"],...
            ["W*","MB*","*-*","*_*"]};

for i = 1:length(exp_all) % loops across LOLO file dataset 
    clear fileList 
    exp      = exp_all{i}; 
    idx      = idx_all{i};
   
    disp("length of filelist")
    fileList = cell(0, 3); % Initialize fileList as an empty cell array
    
        
    for k = 1:length(exp) % loops experiments 
        disp(exp(k))
        subf     = dir(strcat(I,exp(k),idx(k))); 
        temp2    = cell(length(subf),3);
            
        for j = 1:length(subf)
            disp(subf(j).name)
            disp(strcat(fullfile(subf(j).folder,subf(j).name),"/EEG*.mat"))
            eeg_path = dir(strcat(fullfile(subf(j).folder,subf(j).name),"/EEG*.mat"));
            
            if length(eeg_path)>1
                randomInteger = randi([1, length(eeg_path)]);
                temp2{j,1} = strcat(fullfile(subf(j).folder,subf(j).name), "/EEG",num2str(randomInteger),".mat");
                temp2{j,2} = strcat(fullfile(subf(j).folder,subf(j).name), "/EMG.mat");
                temp2{j,3} = strcat(fullfile(subf(j).folder,subf(j).name), "/labels_accusleep.mat");
    
            else
                temp2{j,1} = strcat(fullfile(subf(j).folder,subf(j).name), "/EEG1.mat");
                temp2{j,2} = strcat(fullfile(subf(j).folder,subf(j).name), "/EMG.mat");
                temp2{j,3} = strcat(fullfile(subf(j).folder,subf(j).name), "/labels_accusleep.mat");
            end  

        end
        fileList = [fileList; temp2];
    end 
        
    save(outf(i),'fileList');

end

