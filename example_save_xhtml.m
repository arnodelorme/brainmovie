%% Save 3-D mesh
h=figure, hold on;

[X,Y,Z] = sphere(20)
hh = mesh(X*30, Y*30, Z*30, 'cdata', zeros(21,21,3), 'tag', 'mesh');

dipfitdefs;
tmp = load('-mat', template_models(2).hdmfile);
g.meshdata = { 'vertices' tmp.vol.bnd(3).pnt 'faces' tmp.vol.bnd(3).tri };
hh = patch(g.meshdata{:}, 'facecolor', 'none', 'edgecolor', [0 0 0], 'FaceAlpha', 0, 'tag', 'mesh');

set(gca, 'xlim', [-110 110])
set(gca, 'ylim', [-110 110])
axis equal
figure2xhtml('example3',h)

%% Save brain movie
dipfitdefs;
coords = loadtxt('brain_coords_3d_MNI.txt');
pos = [ [ coords{2:4,17} ]; [ coords{2:4,33} ] ]*60; % visual cortex
pos = [ [ coords{2:4,15} ]; [ coords{2:4,31} ] ]*60; % Frontal eye field
pos = [ [ coords{2:4,5} ]; [ coords{2:4,21} ] ]*60; % Insular cortex
pos = [ [ coords{2:4,17} ]; [ coords{2:4,33} ]; [ coords{2:4,15} ]; [ coords{2:4,31} ]; [ coords{2:4,5} ]; [ coords{2:4,21} ] ]*60; % All of the above

ersps2 = { rand(1,1) rand(1,1) rand(1,1) rand(1,1) rand(1,1) rand(1,1) }';
crossfs_amp2 = { ...
    {} rand(1,1) rand(1,1) rand(1,1) rand(1,1) rand(1,1);
    {} {}        rand(1,1) rand(1,1) rand(1,1) rand(1,1);
    {} {}        {}        rand(1,1) rand(1,1) rand(1,1);
    {} {}        {}        {}        rand(1,1) rand(1,1);
    {} {}        {}        {}        {}        rand(1,1);
    {} {}        {}        {}        {}        {} };
brainmovie3d_causal( ersps2, ersps2, crossfs_amp2, crossfs_amp2, 1, 1, [1:6], ...
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
options.offset = [ 0 0 0 ]; % viewpoint is important. Put viewpoint to 0,0,200 and shift coordinates?
figure2xhtml('example4',gcf,options)
