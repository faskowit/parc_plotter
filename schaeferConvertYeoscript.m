
schaeferConvertYeo = struct() ;
schaeferConvertYeo.x7to17 = containers.Map ;
schaeferConvertYeo.x17to7 = containers.Map ;

for idx = [ 100 200 300 400 500 600 800 1000 ] 

    disp(idx)
    
    annot1 = [ 'schaefer' num2str(idx) '-yeo17' ] ;
    annot2 = [ 'Schaefer2018_' num2str(idx) 'Parcels_7Networks_order' ] ;
    
    dat1 = annotMap(annot1) ;
    dat2 = annotMap(annot2) ;

    lh_dat1_origlab = dat1.LH.labs ;
    lh_dat2_origlab = dat2.LH.labs ;

    rh_dat1_origlab = dat1.RH.labs ;
    rh_dat2_origlab = dat2.RH.labs ;

    lh_dat1_bk = dat1.LH.ct.table(1,5) ;
    rh_dat1_bk = dat1.RH.ct.table(1,5) ;

    lh_dat2_bk = dat2.LH.ct.table(1,5) ;
    rh_dat2_bk = dat2.RH.ct.table(1,5) ;

    % remove background
    lh_dat1_origlab(lh_dat1_origlab==lh_dat1_bk) = nan ;
    rh_dat1_origlab(rh_dat1_origlab==rh_dat1_bk) = nan ;

    lh_dat2_origlab(lh_dat2_origlab==lh_dat2_bk) = nan ;
    rh_dat2_origlab(rh_dat2_origlab==rh_dat2_bk) = nan ;

    lh_labs1 = remaplabs(lh_dat1_origlab,dat1.LH.ct.table(2:end,5)) ;
    rh_labs1 = remaplabs(rh_dat1_origlab,dat1.RH.ct.table(2:end,5)) ;

    lh_labs2 = remaplabs(lh_dat2_origlab,dat2.LH.ct.table(2:end,5)) ;
    rh_labs2 = remaplabs(rh_dat2_origlab,dat2.RH.ct.table(2:end,5)) ;

    %%

    % function [output, assign, cost, dice_overlap] = CBIG_HungarianClusterMatch(ref_labels, input_labels, disp_flag)
    [~,lh_reorder2to1] = CBIG_HungarianClusterMatch(lh_labs1,lh_labs2) ;

    % function [output, assign, cost, dice_overlap] = CBIG_HungarianClusterMatch(ref_labels, input_labels, disp_flag)
    [~,rh_reorder2to1] = CBIG_HungarianClusterMatch(rh_labs1,rh_labs2) ;

    % function [output, assign, cost, dice_overlap] = CBIG_HungarianClusterMatch(ref_labels, input_labels, disp_flag)
    [~,lh_reorder1to2] = CBIG_HungarianClusterMatch(lh_labs2,lh_labs1) ;

    % function [output, assign, cost, dice_overlap] = CBIG_HungarianClusterMatch(ref_labels, input_labels, disp_flag)
    [~,rh_reorder1to2] = CBIG_HungarianClusterMatch(rh_labs2,rh_labs1) ;

    schaeferConvertYeo.x7to17(num2str(idx)) = [ lh_reorder2to1  rh_reorder2to1+length(lh_reorder2to1) ] ;
    schaeferConvertYeo.x17to7(num2str(idx)) = [ lh_reorder1to2  rh_reorder1to2+length(lh_reorder1to2) ] ;

end

%% save file

save('./data/fsaverage/mat/schaeferConvertYeo.mat','schaeferConvertYeo')

%%

% dataVec = -150:49 ;
% 
% annotName = 'schaefer200-yeo17' ;
% [~,o1 ] = parc_plot(surfStruct,annotMap,annotName,dataVec,...
%     'viewcMap',0) ; 
% annotName = 'Schaefer2018_200Parcels_7Networks_order' ;
% [~,o2 ] = parc_plot(surfStruct,annotMap,annotName,dataVec(schaefer200yeo7_2_schaefer200yeo17),...
%     'viewcMap',0) ;
% 
% annotName = 'Schaefer2018_200Parcels_7Networks_order' ;
% [~,o2 ] = parc_plot(surfStruct,annotMap,annotName,dataVec,...
%     'viewcMap',0) ;
% 
% %%
% 
% annotName = 'Schaefer2018_200Parcels_7Networks_order' ;
% [~,o1 ] = parc_plot(surfStruct,annotMap,annotName,dataVec,...
%     'viewcMap',0) ;
% annotName = 'schaefer200-yeo17' ;
% [~,o2 ] = parc_plot(surfStruct,annotMap,annotName,dataVec(schaefer200yeo17_2_schaefer200yeo7),...
%     'viewcMap',0) ;
% 
% annotName = 'schaefer200-yeo17' ;
% parc_plot(surfStruct,annotMap,annotName,dataVec(schaefer200yeo7_2_schaefer200yeo17),...
%     'viewcMap',0)

