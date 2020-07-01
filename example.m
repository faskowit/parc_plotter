clc 
clearvars

%% setup paths

addpath(strcat(pwd,'/src/'))
addpath(strcat(pwd,'/data/'))
addpath(genpath(strcat(pwd,'/src/external/')))

%% get data

surf = load([pwd '/data/fsaverage/mat/' 'fsaverage_inflated.mat']) ;
surfStruct = surf.surfStruct ;

annots = load([pwd '/data/fsaverage/mat/' 'fsaverage_annots.mat']) ;
annotMap = annots.allAnnots ;

%% plot some data

annotName = 'schaefer200-yeo17' ;

%dataVec = rand(200,1) ;
dataVec = 1:200 ;

parc_plot(surfStruct,annotMap,annotName,dataVec)

%% plot some data with a cmap

annotName = 'schaefer400-yeo17' ;

dataVec = 1:400 ;

parc_plot(surfStruct,annotMap,annotName,dataVec,brewermap(15,'PiYG'))

%% plot the parc plot

annotName = 'hcp-mmp-b' ;

cmap = annotMap(annotName).combo_table(:,1:3) ./ 255 ;

% function [h] = parc_plot(surfStruct,annotMap,annotName,dataVec,cMap,viewStr)
parc_plot(surfStruct,annotMap,annotName,1:(size(cmap,1)),cmap)

