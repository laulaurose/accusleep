

clear all; 
clc; 

addpath(genpath("/work3/laurose/accusleep/data/")) % path to data  
addpath(genpath("/zhome/dd/4/109414/")) % path to scripts 
I = "/work3/laurose/accusleep/data/";
disp("starting")

aid = {'Mouse01', 'Mouse02', 'Mouse03', 'Mouse04', 'Mouse05', 'Mouse06', 'Mouse07', 'Mouse08', 'Mouse09', 'Mouse10'};

% Number of mice in each training set
numMiceTraining   = 8;
numMiceValidation = 2;
totalSets         = 5;

% Calculate the total number of mice
totalMice = numel(aid);

% Initialize the cell arrays for training and validation sets
trainingSets   = cell(totalSets, 1);
validationSets = cell(totalSets, 1);

% Iterate over each set
for i = 1:totalSets
    % Randomly permute the indices
    permutedIndices = randperm(totalMice);
    
    % Extract the indices for the training set
    trainingSetIndices = permutedIndices(1:numMiceTraining);
    
    % Extract the indices for the validation set
    validationSetIndices = permutedIndices(numMiceTraining + 1:numMiceTraining + numMiceValidation);
    
    % Assign mice to training and validation sets
    trainingSets{i} = aid(trainingSetIndices);
    validationSets{i} = aid(validationSetIndices);
end

for p = 1:5 % cv split 
    disp(p)	    
    fileList_train = cell(40,3);
    fileList_test  = cell(10,3);
    train_list = strcat(I,trainingSets{p});
    test_list  = strcat(I,validationSets{p});
    
    for k = 1:length(train_list)
        
        subf = dir(strcat(train_list(k),"/Da*"));
    
        for j = 1:5
            tempcell{j,1} = strcat(subf(1).folder,"/",subf(j).name,"/EEG.mat");
            tempcell{j,2} = strcat(subf(1).folder,"/",subf(j).name,"/EMG.mat");
            tempcell{j,3} = strcat(subf(1).folder,"/",subf(j).name,"/labels.mat");
        end
    
    
        % Calculate the indices to insert tempcell into fileList
        idx_start = (k - 1) * size(tempcell, 1) + 1;
        idx_end = k * size(tempcell, 1);
        
        % Insert tempcell into fileList
        fileList_train(idx_start:idx_end, :) = tempcell;
    
    end

    save(strcat("train_",num2str(p),'fileList.mat'), 'fileList_train');
        
    for k = 1:length(test_list)
        
        subf = dir(strcat(test_list(k),"/Da*"));
    
        for j = 1:5
            tempcell{j,1} = strcat(subf(1).folder,"/",subf(j).name,"/EEG.mat");
            tempcell{j,2} = strcat(subf(1).folder,"/",subf(j).name,"/EMG.mat");
            tempcell{j,3} = strcat(subf(1).folder,"/",subf(j).name,"/labels.mat");
        end
    
    
        % Calculate the indices to insert tempcell into fileList
        idx_start = (k - 1) * size(tempcell, 1) + 1;
        idx_end = k * size(tempcell, 1);
        
        % Insert tempcell into fileList
        fileList_test(idx_start:idx_end, :) = tempcell;
    
    end

    save(strcat("test_",num2str(p),'fileList.mat'), 'fileList_test');

end 
