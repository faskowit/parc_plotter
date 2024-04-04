function [ TLhandle, fig_hand, tile_hand ] = viz_views(surfStruct,LH_wei,RH_wei,plotViewStr,cmapStr,vizparent,tilespan)

if ~exist('plotViewStr','var') || isempty(plotViewStr)
    plotViewStr = 'all'; % weight for unknown vertices
end 

if ~exist('cmapStr','var') || isempty(cmapStr)
   cmapStr = 'direct';
end

if ~ismember(plotViewStr, {'all' 'lh:lat' 'lh:med' 'rh:lat' 'rh:med' 'lat' 'med'})
    error('invalid "plotView" variable')
end
  
% check the weights
if ~isempty(LH_wei) && ~isvector(LH_wei)
    error('LH_wei must be a vector')
end
if ~isempty(RH_wei) && ~isvector(RH_wei)
    error('RH_wei must be a vector')
end

if nargin < 6
    vizparent = [] ;  
end

if nargin < 7
    tilespan = [1 1] ; 
end

%% viz it

% viz
% function [ fig_hand ] = viz(surfStructHemi,wei,viewAngle)

% % Left Hemisphere
% if strcmp(plotViewStr,'all')
%     % [ha, pos] = tight_subplot(Nh, Nw, gap, marg_h, marg_w)
%     % [gap_h gap_w], [lower upper], [left right]
%     ts = tight_subplot(2,2,[.001 .025],[.001 .001],[.05 .05]) ;
%     axes(ts(1)) ;
%     fig_hand = cell(4,1) ;
% end
% if strcmp(plotViewStr,'all') || strcmp(plotViewStr,'lh:lat')
%     fig_hand{1} = viz(surfStruct.LH,LH_wei,-90,cmapStr) ; 
% end
% if strcmp(plotViewStr,'all')
%     axes(ts(3)) ;
% end
% if strcmp(plotViewStr,'all') || strcmp(plotViewStr,'lh:med')
%     fig_hand{3} = viz(surfStruct.LH,LH_wei,90,cmapStr) ;     
% end
% 
% % Right Hemisphere
% if strcmp(plotViewStr,'all')
%     axes(ts(2)) ;
% end
% if strcmp(plotViewStr,'all') || strcmp(plotViewStr,'rh:lat')
%     fig_hand{2} = viz(surfStruct.RH,RH_wei,90,cmapStr) ;     
% end
% if strcmp(plotViewStr,'all')
%     axes(ts(4)) ;
% end
% if strcmp(plotViewStr,'all') || strcmp(plotViewStr,'rh:med')
% 
%     fig_hand{4} = viz(surfStruct.RH,RH_wei,-90,cmapStr) ;     
% end

if ~isempty(vizparent)
    tlargs = {vizparent} ; 
else
    tlargs = {}  ;
end

% switch true
%     case strcmp(plotViewStr,'lh:lat') || strcmp(plotViewStr,'rh:lat') || ...
%             strcmp(plotViewStr,'lh:med') || strcmp(plotViewStr,'rh:med')
%         TLhandle = tiledlayout(1,1,'Padding','tight') ; 
%     case strcmp(plotViewStr,'lat') | strcmp(plotViewStr,'med')
%         TLhandle = tiledlayout(1,2,'TileSpacing','tight','Padding','tight') ;
%     case strcmp(plotViewStr,'all')
%         TLhandle = tiledlayout(2,2,'TileSpacing','tight','Padding','tight') ;
%     otherwise
%         error([ 'cant read it: ' plotViewStr ])
% end

switch true
    case strcmp(plotViewStr,'lh:lat') || strcmp(plotViewStr,'rh:lat') || ...
            strcmp(plotViewStr,'lh:med') || strcmp(plotViewStr,'rh:med')
        tlargs = [ tlargs ; 1 ; 1 ]; 
    case strcmp(plotViewStr,'lat') | strcmp(plotViewStr,'med')
        tlargs = [ tlargs ; 1 ; 2 ; 'TileSpacing' ; 'tight' ] ;
    case strcmp(plotViewStr,'all')
        tlargs = [ tlargs ; 2 ; 2 ; 'TileSpacing' ; 'tight' ] ; 
    otherwise
        error([ 'cant read it: ' plotViewStr ])
end

tlargs = [ tlargs(:) ; 'Padding' ; 'tight' ] ; 
TLhandle = tiledlayout(tlargs{:}) ; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lateral 

if strcmp(plotViewStr,'all') || strcmp(plotViewStr,'lh:lat') || ...
        strcmp(plotViewStr,'lat')
    tile_hand{1} = nexttile(TLhandle,tilespan) ; 
    fig_hand{1} = viz(surfStruct.LH,LH_wei,-90,cmapStr) ; 
end

if strcmp(plotViewStr,'all') || strcmp(plotViewStr,'rh:lat') || ...
        strcmp(plotViewStr,'lat')
    tile_hand{2} = nexttile(TLhandle,tilespan) ; 
    fig_hand{2} = viz(surfStruct.RH,RH_wei,90,cmapStr) ;     
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% medial 

if strcmp(plotViewStr,'all') || strcmp(plotViewStr,'lh:med') || ...
        strcmp(plotViewStr,'med')
    tile_hand{3} = nexttile(TLhandle,tilespan) ; 
    fig_hand{3} = viz(surfStruct.LH,LH_wei,90,cmapStr) ;     
end


if strcmp(plotViewStr,'all') || strcmp(plotViewStr,'rh:med') || ...
        strcmp(plotViewStr,'med')
    tile_hand{4} = nexttile(TLhandle,tilespan) ; 
    fig_hand{4} = viz(surfStruct.RH,RH_wei,-90,cmapStr) ;     
end

% need to set a shape so that the vertical gap is not so small
% set(gcf, 'Units', 'centimeters', 'OuterPosition', [0 0 24 17]);
