function [h] = parc_plot(...
    surfStruct,annotMap,annotName,dataVec,cMap,border,viewStr,viewCmap)
% function to plot some parcellations and some data in those parcs

if nargin < 4
   error('minimally needs the first four args') 
end

if ~exist('cMap','var') || isempty(cMap)
    cMap = [ 0.5 0.5 0.5 ; % grey medial wall
            brewermap(100,'Spectral') ] ; 
else
    cMap = [ 0.5 0.5 0.5 ; % grey medial wall
            cMap ] ;
end

if ~exist('border','var') || isempty(border)
   border = 1 ;  
end

if ~exist('viewStr','var') || isempty(viewStr)
   viewStr = 'all' ;
end

if ~exist('viewCmap','var') || isempty(viewCmap)
    viewCmap = 0 ;
end

%% setup stuff

% make sure data is column
dataVec = dataVec(:) ;

% first load up the annotation 
annotStruct = annotMap(annotName) ;

%% do your thing

% init a sturct to help org
plotStruct = struct() ;

% num nodes
% numNode = length(annotStruct.combo_names) ;
numBins = size(cMap,1)-1 ;

% vals_2_nodes(vertexVec,nodeID,dataVec)
plotStruct.LH.nodeVals = ...
    vals_2_nodes(annotStruct.LH.labs,annotStruct.roi_ids,dataVec) ;
plotStruct.RH.nodeVals = ...
    vals_2_nodes(annotStruct.RH.labs,annotStruct.roi_ids,dataVec) ;

% convert values into color map inds
allNodesCmapInd = vals_2_direct_inds(...
    [plotStruct.LH.nodeVals ; plotStruct.RH.nodeVals], numBins, NaN) ;

% move up the inds for the background
allNodesCmapInd = allNodesCmapInd +1 ;

plotStruct.LH.nodeCmapInd = allNodesCmapInd(1:length(annotStruct.LH.labs));
plotStruct.RH.nodeCmapInd = allNodesCmapInd((length(annotStruct.LH.labs)+1):end);

% replace NaN with 1
plotStruct.LH.nodeCmapInd(isnan(plotStruct.LH.nodeCmapInd))=1;
plotStruct.RH.nodeCmapInd(isnan(plotStruct.RH.nodeCmapInd))=1;

%% plot borders?

if border>0
    plotStruct.LH.nodeCmapInd(annotStruct.LH.border>0) = 1 ;
    plotStruct.RH.nodeCmapInd(annotStruct.RH.border>0) = 1 ;
end

%% plot it

figure
h = viz_views(surfStruct,...
    plotStruct.LH.nodeCmapInd,...
    plotStruct.RH.nodeCmapInd,...
    viewStr,'direct') ;
colormap(cMap)

if viewCmap>0
    % another figure just for colormap?
    figure
    imagesc(dataVec)
    colormap(cMap(2:end,:)); colorbar
    axis off
end
