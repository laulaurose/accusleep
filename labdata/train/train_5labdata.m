
clc; 
clear all; 
addpath(genpath("/zhome/dd/4/109414/Validationstudy/accusleep/"))

SR       = 128;
epochLen = 4;
epochs   = 13;

I_base    = "/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/filelist/";
fileLists = ["fileList_Alessandro.mat","fileList_Antoine.mat","fileList_Kornum.mat",...
            "fileList_Maiken.mat","fileList_Sebastian.mat"]; 
outdir    = "/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/";
m_names   = ["trained_NeuralNetwork_Alessandro.mat","trained_NeuralNetwork_Antoine.mat",...
             "trained_NeuralNetwork_Kornum.mat","trained_NeuralNetwork_Maiken.mat",...
             "trained_NeuralNetwork_Sebastian.mat"] ;
imageLocation_sf ={'Alessandro','Antoine','Kornum','Maiken','Sebastian'};

for j = 1:5
    load(strcat(I_base,fileLists(j)))
    disp(strcat(I_base,fileLists(j)))
    imageLocation = strcat('/zhome/dd/4/109414/Validationstudy/accusleep/labdata/train/prep_data/',imageLocation_sf{j});
    [net] = AccuSleep_train_v2(fileList, SR, epochLen, epochs, imageLocation);
    save(strcat(outdir,m_names(j)), 'net');

end
