
clc; 
clear all; 

addpath(genpath("/zhome/dd/4/109414/Validationstudy/accusleep/"))
load /zhome/dd/4/109414/Validationstudy/accusleep/trainedNetworks/trainedNetwork4secEpochs.mat
disp(net)
%load /zhome/dd/4/109414/Validationstudy/accusleep/labdata/fileList_test_5labdata.mat

SR         = 128;
epochLen   = 4;
epochs     = 9;
minBoutLen = 5;
outf       = ["Alessandro","Antoine","Kornum","Maiken","Sebastian"];


all_f   = ["/zhome/dd/4/109414/Validationstudy/accusleep/labdata/fileList_test_Alessandro.mat",...
           "/zhome/dd/4/109414/Validationstudy/accusleep/labdata/fileList_test_Antoine.mat",...
           "/zhome/dd/4/109414/Validationstudy/accusleep/labdata/fileList_test_Kornum.mat",...
           "/zhome/dd/4/109414/Validationstudy/accusleep/labdata/fileList_test_Maiken.mat",...
           "/zhome/dd/4/109414/Validationstudy/accusleep/labdata/fileList_test_Sebastian.mat"];
% 1 = REM 
% 2 = wake 
% 3 = NREM 

all_all_labels = []; 
all_all_pred   = [];

for kk = 1:length(outf)
    all_labels = []
    all_pred   = []
    load(all_f(kk));
    nFiles     = size(fileList,1);

    for i = 1:nFiles
        disp(fileList{i,1})
       
        % load the files
        data   = struct;
        data.a = load(fileList{i,1});
        data.b = load(fileList{i,2});
        data.c = load(fileList{i,3});
        fieldNamesA = fieldnames(data.a);
        fieldNamesC = fieldnames(data.c);
    
        EEG    = data.a.(fieldNamesA{1});
        EMG    = data.b.EMG; 
        labels = data.c.(fieldNamesC{1});

        if all([sum(labels==1)>=3, sum(labels==2)>=3, sum(labels==3)>=3])
           disp(size(EEG))
           disp(size(EMG)) 
           disp(size(labels))
    
           calibrationData = createCalibrationData(EEG, EMG, labels, SR, epochLen);
           pred = AccuSleep_classify(EEG, EMG, net, SR, epochLen, calibrationData, minBoutLen);
           disp(size(labels))
           disp(size(pred))
    	    
           all_labels = [all_labels labels];
           all_pred   = [all_pred   pred'];

           all_all_pred   = [all_all_pred pred'];
           all_all_labels = [all_all_labels labels];

           disp(size(all_labels))
           disp(size(all_pred))
        else 
        end
    end 
    
    YTest      = reshape(all_labels,1,size(all_labels,1)*size(all_labels,2));
    YPredicted = reshape(all_pred,1,size(all_pred,1)*size(all_pred,2));
    save(strcat("/zhome/dd/4/109414/Validationstudy/accusleep/labdata/Ytest","_",outf(kk),".mat"),"YTest")
    save(strcat("/zhome/dd/4/109414/Validationstudy/accusleep/labdata/Ypredicted","_",outf(kk),".mat"),"YPredicted")

end 
 
clear YTest YPredicted 
YTest      = reshape(all_all_labels,1,size(all_all_labels,1)*size(all_all_labels,2));
YPredicted = reshape(all_all_pred,1,size(all_all_pred,1)*size(all_all_pred,2));
save(strcat("/zhome/dd/4/109414/Validationstudy/accusleep/labdata/Ytest.mat"),"YTest")
save(strcat("/zhome/dd/4/109414/Validationstudy/accusleep/labdata/Ypredicted.mat"),"YPredicted")





