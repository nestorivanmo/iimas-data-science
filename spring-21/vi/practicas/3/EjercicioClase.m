%
% Several visualizations of a scalar 3D field
% A dataset representing the speed profile of a 
% submerged jet within an infinite tank.
% This dataset is part of Matlab
%

%[x,y,z,v] = flow % Not octave
clear 
close all
clc

[x, y, z] = meshgrid(-3:0.25:3);
v = x.*exp(-x.^2 - y.^2 - z.^2);

%[x, y, z] = meshgrid (linspace (-8, 8, 32));
%v = sin (sqrt (x.^2 + y.^2 + z.^2)) ./ (sqrt (x.^2 + y.^2 + z.^2));

figure,
slice (x, y, z, v, [], 0, []);


% Visualization as slices
figure
clf(figure(1))
xslice = 2;
yslice = 0;
zslice = 0;
slice(x,y,z,v,xslice,yslice,zslice);
view(3);
axis on;
grid on;
light;
lighting gouraud;
camlight('left');
shading interp;

% Same visualization with a different Color Map
figure
clf(figure(2))
slice(x,y,z,v,xslice,yslice,zslice);
view(3);
axis([-4 4 -4 4 -3 3]);
grid on;
%colormap(jet(128));
colormap jet
colorbar;
shading interp;

% A New Color Map
figure
clf(figure(3))
slice(x,y,z,v,xslice,yslice,zslice);
view(3);
axis([-4 4 -4 4 -3 3]);
grid on;
%colormap(flipud(jet(128)));
colormap(flipud(jet))
colorbar;
shading interp;

%% Isocontours
%figure(4);
%clf(figure(4))
%xslice = (1:3:9);
%yslice = 0;
%zslice = 0;
%isovalues = (-3.0:0.25:3.0);
%%isovalues = (-0.5:0.05:0.5);
%s = contourslice(x,y,z,v,xslice,yslice,zslice,isovalues);
%set(s,'linewidth',2.0)
%view([-10 40]);
%axis on;
%grid on;
%colorbar;

% A single isosurface
isovalue = 0.1;
purple = [1.0 0.5 1.0];
figure,
clf(figure(5))
[f, vert] = isosurface (x, y, z, v, isovalue);
%p = patch(isosurface(x,y,z,v,isovalue));
p = patch ("Faces", f, "Vertices", vert, "EdgeColor", "none");
pbaspect ([1 1 1]);
isonormals(x,y,z,v,p)
set(p,'FaceColor',purple,'EdgeColor','none');
view([-10 40]);
axis on;
grid on;
light;
lighting gouraud;
camlight('left');

% Two isosurface
% First isosurface
isovalue = .05;
colors = v;
figure(6)
clf(figure(6))
[faces,verts,fcolors] = isosurface(x,y,z,v,isovalue,colors);
p = patch('Vertices',verts,'Faces',faces,'FaceVertexCData',fcolors, ...
'FaceColor','interp','EdgeColor','none');
isonormals(x,y,z,v,p);

% Second isosurface
isovalue2 = 0;
[faces,verts,fcolors] = isosurface(x,y,z,v,isovalue2,colors);
p2 = patch('Vertices',verts,'Faces',faces,'FaceVertexCData',fcolors, ...
'FaceColor','interp','EdgeColor','none');
isonormals(x,y,z,v,p2);
view([-10 40]);
axis on;
grid on;
colormap jet;
light;
lighting gouraud;
camlight('left');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[x, y, z] = meshgrid (1:5, 1:5, 1:5);
v = rand (5, 5, 5);
figure(7)
isosurface (x, y, z, v, .5);

N = 50;    % Increase number of vertices in each direction
iso = .2;  % Change isovalue to .1 to display a sphere
lin = linspace (0, 2, N);
[x, y, z] = meshgrid (lin, lin, lin);
v = abs ((x-.5).^2 + (y-.5).^2 + (z-.5).^2);


 figure,
view (-38, 20);
[f, vert] = isosurface (x, y, z, v, iso);
p = patch ("Faces", f, "Vertices", vert, "EdgeColor", "none");
pbaspect ([1 1 1]);
isonormals (x, y, z, v, p)
set (p, "FaceColor", "green", "FaceLighting", "gouraud");
light ("Position", [1 1 5]);

figure,
 view (-38, 20);
p = patch ("Faces", f, "Vertices", vert, "EdgeColor", "blue");
pbaspect ([1 1 1]);
isonormals (x, y, z, v, p)
set (p, "FaceColor", "none", "EdgeLighting", "gouraud");
light ("Position", [1 1 5]);

figure,
view (-38, 20);
[f, vert, c] = isosurface (x, y, z, v, iso, y);
p = patch ("Faces", f, "Vertices", vert, "FaceVertexCData", c, ...
           "FaceColor", "interp", "EdgeColor", "none");
pbaspect ([1 1 1]);
isonormals (x, y, z, v, p)
set (p, "FaceLighting", "gouraud");
light ("Position", [1 1 5]);

figure,
view (-38, 20);
p = patch ("Faces", f, "Vertices", vert, "FaceVertexCData", c, ...
           "FaceColor", "interp", "EdgeColor", "blue");
pbaspect ([1 1 1]);
isonormals (x, y, z, v, p)
set (p, "FaceLighting", "gouraud");
light ("Position", [1 1 5]);
