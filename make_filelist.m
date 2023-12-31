

clear all; 
clc; 

addpath(genpath("/work3/laurose/accusleep/data/")) % path to data  
addpath(genpath("/zhome/dd/4/109414/")) % path to scripts 
I = dir("/work3/laurose/accusleep/data/Mouse*");
disp("starting")

fileList = cell(30,3);


for k = 1:length(I)
    
    subf = dir(strcat(I(k).folder,"/",I(k).name,"/Da*"));

    for j = 1:length(subf)-2
        tempcell{j,1} = strcat(subf(1).folder,"/",subf(j).name,"/EEG.mat");
        tempcell{j,2} = strcat(subf(1).folder,"/",subf(j).name,"/EMG.mat");
        tempcell{j,3} = strcat(subf(1).folder,"/",subf(j).name,"/labels.mat");
    end


    % Calculate the indices to insert tempcell into fileList
    idx_start = (k - 1) * size(tempcell, 1) + 1;
    idx_end = k * size(tempcell, 1);
    
    % Insert tempcell into fileList
    fileList(idx_start:idx_end, :) = tempcell;

end
disp("saving")

save('fileList.mat', 'fileList');

