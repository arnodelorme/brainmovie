% roi_plotbrainmovie() - plot connectivity in Brain movie
%
% Usage:
%     roi_plotbrainmovie(array, 'key', val);
%
% Input:
%     array   - [n x n] square array indicating which cell are connected
%
% Optional inputs:
%    'labels'  - [cell] name for each row/column
%    'threshold' - [real] only show connections above a given threshold
%
% Author: Arnaud Delorme

% Copyright (C) Arnaud Delorme, arnodelorme@gmail.com
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%
% 1. Redistributions of source code must retain the above copyright notice,
% this list of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright notice,
% this list of conditions and the following disclaimer in the documentation
% and/or other materials provided with the distribution.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
% THE POSSIBILITY OF SUCH DAMAGE.

% Test
% roi_plotbrainmovie(rand(8,8), 'labels', { 'Dorso_lateral_prefrontal_cortex_L' 'Parietal_lobe_L' 'Thalamus_L' 'Visual_cortex_L' 'Dorso_lateral_prefrontal_cortex_R' 'Parietal_lobe_R' 'Thalamus_R' 'Visual_cortex_R' });
% roi_plotbrainmovie(rand(4,4), 'labels', { 'Dorso_lateral_prefrontal_cortex_L' 'Parietal_lobe_L' 'Thalamus_L' 'Visual_cortex_L' });

function roi_plotbrainmovie(array, varargin)

if nargin < 2
    help roi_plotbrainmovie
    return
end

radius = 0.5;
linewidth = 1;

g = finputcheck(varargin, { ...
    'labels'      'cell'      { }             {};
    'threshold'   'real'      {}              0.25;
    }, 'roi_network');
if isstr(g)
    error(g);
end


coords = loadtxt('brain_coords_3d_MNI.txt');
coords(:,1) = [];
for indLab = 1:length(g.labels)
    indCoord = strmatch( lower(g.labels{indLab}), lower(coords(1,:)) );
    if isempty(indCoord)
        error('Could not find brain areas')
    else
        x(indLab) = coords{2,indCoord};
        y(indLab) = coords{3,indCoord};
        z(indLab) = coords{4,indCoord};
    end
end
pos = [x' y' z']*60;

% make the matrix symetrical
for ind1 = 1:size(array,1)
    for ind2 = 1:ind1-1
        if array(ind1,ind2) == 0
            array(ind1,ind2) = array(ind2,ind1);
        end
    end
end
    
% get power
ersp = {};
for indLab = 1:length(g.labels)
    ersp{indLab} = array(indLab, indLab);
    if ersp{indLab} == 0 
        ersp{indLab} = sun(array(indLab, :));
    end
end
ersp = ersp';

% get connectivity
array = mattocell(array);
dipfitdefs;
brainmovie3d_causal( ersp, ersp, array, array, 1, 1, [1:length(ersp)], ...
    'coordinates', pos, ...
    'latency', 1, ...
    'dipplotopt', {'meshdata' template_models(2).hdmfile 'coordformat' 'mni' ,'meshedgecolor',[0.3 0.3 0.3] 'meshoptions' {'facealpha',0,'edgealpha',1}}, ...
    'modulateEdgeSize', 'on', ...
    'nodeSizeLimits', [0.05 0.15], ...
    'edgeSizeLimits', [0.05 0.15], ...
    'caption', false);
%    'nodeSizeDataRange', [-100 100], ...
delete(findobj(gcf, 'tag', 'img'))
set(findobj(gcf, 'tag', 'mesh'), 'visible', 'on')
figure2xhtml('test/example4',gcf)
