#!/bin/bash
#BSUB -q gpua100
#BSUB -J cv_train_accusleep
#BSUB -n 4
#BSUB -R "span[hosts=1]"
#BSUB -gpu "num=1:mode=exclusive_process"
#BSUB -R "rusage[mem=4GB]"
#BSUB -W 48:00
#BSUB -u laurarose@sund.ku.dk 
#BSUB -N 
#BSUB -o jobfiles/Output_%J.out 
#BSUB -e jobfiles/Output_%J.err 

ml load matlab/R2022a
matlab nodesktop < train_accusleep.m
