clear alll 
clc 

%% Load imds 
%addpath(genpath("/Users/qgf169/Documents/MATLAB/AccuSleep/"))
addpath(genpath("/zhome/dd/4/109414/Validationstudy/accusleep/"))

imsize = [9   185];

%% Load data for training 
% labs 
lab_names = ["Alessandro","Antoine","Kornum","Maiken","Sebastain"];

% Training 
Train_Ale = load('/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/imdsTrain_Alessandro.mat');
Train_Ant = load('/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/imdsTrain_Antoine.mat');
Train_Kor = load('/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/imdsTrain_Kornum.mat');
Train_Mai = load('/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/imdsTrain_Maiken.mat');
Train_Seb = load('/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/imdsTrain_Sebastian.mat');

% Validation 
Val_Ale   = load('/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/imdsValidation_Alessandro.mat');
Val_Ant   = load('/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/imdsValidation_Antoine.mat');
Val_Kor   = load('/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/imdsValidation_Kornum.mat');
Val_Mai   = load('/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/imdsValidation_Maiken.mat');
Val_Seb   = load('/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/imdsValidation_Sebastian.mat');

%outf = "/Users/qgf169/Documents/MATLAB/AccuSleep/test_5labdata/";
outf = "/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/predictions/";

%% Load data for testing 

testsets = {['/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/files_for_testing/test_fileList_Alessandro.mat'],...
            ['/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/files_for_testing/test_fileList_Antoine.mat'],...
            ['/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/files_for_testing/test_fileList_Kornum.mat'],...
            ['/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/files_for_testing/test_fileList_Maiken.mat'],...
            ['/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/files_for_testing/test_fileList_Sebastian.mat']}; 

%% LOLO 

CV1_train  = imageDatastore(cat(1,Train_Ant.imdsTrain.Files,Train_Kor.imdsTrain.Files,Train_Mai.imdsTrain.Files,Train_Seb.imdsTrain.Files));
CV2_train  = imageDatastore(cat(1,Train_Ale.imdsTrain.Files,Train_Kor.imdsTrain.Files,Train_Mai.imdsTrain.Files,Train_Seb.imdsTrain.Files));
CV3_train  = imageDatastore(cat(1,Train_Ale.imdsTrain.Files,Train_Ant.imdsTrain.Files,Train_Mai.imdsTrain.Files,Train_Seb.imdsTrain.Files));
CV4_train  = imageDatastore(cat(1,Train_Ale.imdsTrain.Files,Train_Ant.imdsTrain.Files,Train_Kor.imdsTrain.Files,Train_Seb.imdsTrain.Files));
CV5_train  = imageDatastore(cat(1,Train_Ale.imdsTrain.Files,Train_Ant.imdsTrain.Files,Train_Kor.imdsTrain.Files,Train_Mai.imdsTrain.Files));

CV1_train.Labels = cat(1,Train_Ant.imdsTrain.Labels,Train_Kor.imdsTrain.Labels,Train_Mai.imdsTrain.Labels,Train_Seb.imdsTrain.Labels);
CV2_train.Labels = cat(1,Train_Ale.imdsTrain.Labels,Train_Kor.imdsTrain.Labels,Train_Mai.imdsTrain.Labels,Train_Seb.imdsTrain.Labels);
CV3_train.Labels = cat(1,Train_Ale.imdsTrain.Labels,Train_Ant.imdsTrain.Labels,Train_Mai.imdsTrain.Labels,Train_Seb.imdsTrain.Labels);
CV4_train.Labels = cat(1,Train_Ale.imdsTrain.Labels,Train_Ant.imdsTrain.Labels,Train_Kor.imdsTrain.Labels,Train_Seb.imdsTrain.Labels);
CV5_train.Labels = cat(1,Train_Ale.imdsTrain.Labels,Train_Ant.imdsTrain.Labels,Train_Kor.imdsTrain.Labels,Train_Mai.imdsTrain.Labels);

CV1_val       = imageDatastore(cat(1,Val_Ant.imdsValidation.Files,Val_Kor.imdsValidation.Files,Val_Mai.imdsValidation.Files,Val_Seb.imdsValidation.Files));
CV2_val       = imageDatastore(cat(1,Val_Ale.imdsValidation.Files,Val_Kor.imdsValidation.Files,Val_Mai.imdsValidation.Files,Val_Seb.imdsValidation.Files));
CV3_val       = imageDatastore(cat(1,Val_Ale.imdsValidation.Files,Val_Ant.imdsValidation.Files,Val_Mai.imdsValidation.Files,Val_Seb.imdsValidation.Files));
CV4_val       = imageDatastore(cat(1,Val_Ale.imdsValidation.Files,Val_Ant.imdsValidation.Files,Val_Kor.imdsValidation.Files,Val_Seb.imdsValidation.Files));
CV5_val       = imageDatastore(cat(1,Val_Ale.imdsValidation.Files,Val_Ant.imdsValidation.Files,Val_Kor.imdsValidation.Files,Val_Mai.imdsValidation.Files));

CV1_train.Labels = cat(1,Val_Ant.imdsValidation.Labels,Val_Kor.imdsValidation.Labels,Val_Mai.imdsValidation.Labels,Val_Seb.imdsValidation.Labels);
CV2_train.Labels = cat(1,Val_Ale.imdsValidation.Labels,Val_Kor.imdsValidation.Labels,Val_Mai.imdsValidation.Labels,Val_Seb.imdsValidation.Labels);
CV3_train.Labels = cat(1,Val_Ale.imdsValidation.Labels,Val_Ant.imdsValidation.Labels,Val_Mai.imdsValidation.Labels,Val_Seb.imdsValidation.Labels);
CV4_train.Labels = cat(1,Val_Ale.imdsValidation.Labels,Val_Ant.imdsValidation.Labels,Val_Kor.imdsValidation.Labels,Val_Seb.imdsValidation.Labels);
CV5_train.Labels = cat(1,Val_Ale.imdsValidation.Labels,Val_Ant.imdsValidation.Labels,Val_Kor.imdsValidation.Labels,Val_Mai.imdsValidation.Labels);

CV_train_all = {CV1_train,CV2_train,CV3_train,CV4_train, CV5_train};
CV_val_all   = {CV1_val,CV2_val,CV3_val,CV4_val, CV5_val};

vf         = 200;
SR         = 128;
minBoutLen = 5;
epochLen   = 4;

for i = 1:5 % loops across crossvalidation sets 
    imdsTrainArrary    = CV_train_all{i}; 
    imdsValArrary      = CV_val_all{i}; 

    imdsValCombined    = shuffle(imdsValArrary); 
    imdsTrainCombined  = shuffle(imdsTrainArrary); 

    % Set training options
    options = trainingOptions('sgdm', ...
        'LearnRateSchedule','piecewise', ...
        'LearnRateDropFactor',0.85, ...
        'LearnRateDropPeriod',1, ...
        'InitialLearnRate',0.015, ...
        'MaxEpochs',10, ...
        'Shuffle','every-epoch', ...
        'ValidationData',imdsValCombined, ...
        'ValidationFrequency',vf, ...
        'ValidationPatience',15,...
        'Verbose',true, ...
        'ExecutionEnvironment','auto',...
        'MiniBatchSize',256,...
        'Plots','none');
    
    layers = [
    imageInputLayer([imsize(1) imsize(2) 1]);%,'AverageImage',ai)
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(3)
    softmaxLayer
    classificationLayer];

    disp('Training network')
    [net, trainInfo] = trainNetwork(Train_Ant.imdsTrain,layers,options);
    save(strcat('trained_network_',lab_names(i),'.mat'), 'net', 'trainInfo');
    
    disp('Training complete: Final validation accuracy:')
    disp([num2str(trainInfo.ValidationAccuracy(end)),'%'])
    

    % load test files ! 
    load(testsets{1})
    nFiles        = size(fileList,1);
    all_pred      = [];
    all_labels    = [];
    animal_all    = [];
    animalPredictions = cellfun(@(x) split(x, '/'), fileList(:,1), 'UniformOutput', false);
    animalPredictions = cellfun(@(x) x{end-1}, animalPredictions, 'UniformOutput', false);
    animalPredictions = string(animalPredictions);

    nnID = unique(animalPredictions);

    for kk = 1:length(nnID)
        clear pred 
        animalID    = nnID(kk);
        animalIndex = find(strcmp(animalPredictions, animalID));
        an_prob = 0;

        for jj = 1:length(animalIndex)
            disp(fileList{animalIndex(jj),1})
            data            = struct ; 
            data.a          = load(fileList{animalIndex(jj),1});
            data.b          = load(fileList{animalIndex(jj),2});
            data.c          = load(fileList{animalIndex(jj),3});
            fieldNamesA     = fieldnames(data.a);
            fieldNamesC     = fieldnames(data.c);
            EEG             = data.a.(fieldNamesA{1});
            EMG             = data.b.EMG; 
            labels          = data.c.(fieldNamesC{1}); 
            calibrationData = createCalibrationData(EEG, EMG, labels, SR, epochLen);
            [~,probs]       = AccuSleep_classify(EEG, EMG, net, SR, epochLen, calibrationData, minBoutLen);
            an_prob         = an_prob + probs;
         end

         [~,pred]   = max(an_prob); 

         if size(pred,1)>1 % if pred is a column vector => row 
            pred = pred'; 
         else 
         end

         pred = enforceMinDuration(pred, ones(1,3) * ceil(minBoutLen / epochLen), [2 1 3], 0);

         all_pred   = [all_pred pred];
         all_labels = [all_labels labels];
         animal_all = [animal_all animalID];
    
    end 
    
    YTest      = reshape(all_labels,1,size(all_labels,1)*size(all_labels,2));
    YPredicted = reshape(all_pred,1,size(all_pred,1)*size(all_pred,2));
    save(strcat(outf,"_",num2str(i),".mat"),"YTest")
    save(strcat(outf,"_",num2str(i),".mat"),"YPredicted")
    

end 