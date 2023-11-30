
clc; 
clear all;
I        = "/zhome/dd/4/109414/Validationstudy/accusleep/cv/"; 
trainset = ["train_1fileList.mat","train_2fileList.mat","train_3fileList.mat","train_4fileList.mat","train_5fileList.mat"];
testset  = ["test_1fileList.mat","test_2fileList.mat","test_3fileList.mat","test_4fileList.mat","test_5fileList.mat"];

%imageLocation = '/work3/laurose/accusleep/data_preprocessed/';
addpath(genpath("/zhome/dd/4/109414/Validationstudy/accusleep"));
addpath(genpath("/zhome/dd/4/109414/Validationstudy/accusleep/helper_files"));

for j = 1:5
    clear net YTest YPredicted
    load(strcat(trainset(j)))
    SR       = 512;
    epochLen = 4;
    epochs   = 9;
    disp(j)
    [net] = AccuSleep_train(fileList_train, SR, epochLen, epochs); 
    save(strcat(I,"net_",num2str(j)), 'net');
    
    load(strcat(testset(j)))

    nFiles     = size(fileList_test,1);
    all_pred = [];
    all_y    = [];

    for i = 1:nFiles 
        % load the files
        data   = struct;
        data.a = load(fileList_test{i,1});
        data.b = load(fileList_test{i,2});
        data.c = load(fileList_test{i,3});
        fieldNamesA = fieldnames(data.a);
        fieldNamesC = fieldnames(data.c);
    
        EEG    = data.a.(fieldNamesA{1});
        EMG    = data.b.EMG; 
        labels = data.c.(fieldNamesC{1}); 
    
        calibrationData = createCalibrationData(EEG, EMG, labels, SR, epochLen);
        pred = AccuSleep_classify(EEG, EMG, net, SR, epochLen, calibrationData, minBoutLen);

        if size(pred,1)>1 % if pred is a column vector => row 
            pred = pred'; 
        else 
        end 
        
        all_labels = [all_labels labels];
        all_pred   = [all_pred   pred];
    end 

    YTest      = reshape(all_labels,1,size(all_labels,1)*size(all_labels,2));
    YPredicted = reshape(all_pred,1,size(all_pred,1)*size(all_pred,2));
    save(strcat("/zhome/dd/4/109414/Validationstudy/accusleep/cv/Ytest","_",num2str(j),".mat"),"YTest")
    save(strcat("/zhome/dd/4/109414/Validationstudy/accusleep/cv/Ypredicted","_",num2str(j),".mat"),"YPredicted")

end 
