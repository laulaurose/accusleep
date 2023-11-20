
clc; 
clear all; 
load fileList
SR       = 128;
epochLen = 2.5;
epochs   = 13;
imageLocation = '/work3/laurose/accusleep/data_preprocessed/'
addpath(genpath("/zhome/dd/4/109414/Validationstudy/accusleep"))
addpath(genpath("/zhome/dd/4/109414/Validationstudy/accusleep/helper_files"))
[net] = AccuSleep_train(fileList, SR, epochLen, epochs, imageLocation)
