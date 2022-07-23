figure;
% [x,y,z] = sphere(10);
% surf(x,y,z);

vert = [0 0 0;1 0 0;1 1 0;0 1 0;0 0 1;1 0 1;1 1 1;0 1 1];
vert = bsxfun(@minus, vert, [0.5 0.5 0.5])
fac = [1 2 6; 6 5 1;2 3 7;6 2 7;3 4 8; 7 3 8;4 1 5; 4 5 8;2 1 3; 1 4 3;5 6 7; 8 5 7];
fac = [2 6 5 1;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];

%fac = [1 2 6; 2 3 7;3 4 8;4 1 5;1 2 3;5 6 7];
h = patch('Vertices',vert,'Faces',fac,'FaceVertexCData',hsv(6),'FaceColor','flat')

axis equal
axis off
view(40,75)
xlim([-2 2])
ylim([-2 2])
zlim([-2 2])
%shading interp
lightangle(-45,30)
camlight right
camlight left
h.FaceLighting = 'gouraud';
h.AmbientStrength = 0.3;
h.DiffuseStrength = 0.8;
h.SpecularStrength = 0.9;
h.SpecularExponent = 25;
h.BackFaceLighting = 'unlit';
figure2xhtml('example5',gcf)