
clear all; 
clc; 
currentFolder = pwd;
addpath(genpath(pwd))

AccuSleep_GUI


data = edfread("/Users/qgf169/Documents/python/Usleep/datasets/sedf_sc/SC4011E0/SC4011EH-Hypnogram.edf")