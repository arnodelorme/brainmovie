% eegplugin_brainmovie() - EEGLAB plugin for importing ASC INStep files.
%
% Usage:
%   >> eegplugin_brainmovie(menu);
%   >> eegplugin_brainmovie(menu, trystrs, catchstrs);
%
% Inputs:
%   menu       - [float]  EEGLAB menu handle
%   trystrs    - [struct] "try" strings for menu callbacks. See notes on EEGLab plugins.
%                (http://www.sccn.ucsd.edu/eeglab/contrib.html)
%   catchstrs  - [struct] "catch" strings for menu callbacks. See notes on EEGLab plugins. 
%                (http://www.sccn.ucsd.edu/eeglab/contrib.html)
%
% Authors: Arnaud Delorme, SCCN, INC, UCSD, 2001-

% Copyright (C) 2001 Arnaud Delorme
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

function vers = eegplugin_brainmovie(fig, trystrs, catchstrs)

    vers = 'brainmovie1.0';
    
    if nargin < 3
        error('eegplugin_brainmovie requires 3 arguments');
    end
  
    % add folder to path
    % ------------------
    if ~exist('brainmovie')
        p = fileparts(which('eegplugin_brainmovie.m'));
        addpath( p );
    end
    if ~exist('figure2xhtml')
        p = fileparts(which('eegplugin_brainmovie.m'));
        addpath(fullfile(p, 'x3d_version3g'));
    end
