%   Program visu_msl.m
%
%   Copyright (C) 2014 LAUM UMR CNRS 6613 (France)
% 	   Olivier DAZEL <olivier.dazel@univ-lemans.fr>
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

%
% This program draws a FEM mesh for a linear elements. It is a part of 
% the course
% "Numerical Methods in Acoustics and Vibration"
%  given for students of the MSc Master Program in Acoustics and 
%  IMDEA students
% 

fid=fopen('mesh.msh','r');
nb_vertice=fscanf(fid,'%i',1);
nb_element=fscanf(fid,'%i',1);
nb_edge=fscanf(fid,'%i',1);

for ii=1:nb_vertice
   vcor(ii,1)=fscanf(fid,'%f',1);
   vcor(ii,2)=fscanf(fid,'%f',1);
   node_label(ii)=fscanf(fid,'%f',1);
end
for ii=1:nb_element
   kconec(ii,1)=fscanf(fid,'%i',1);
   kconec(ii,2)=fscanf(fid,'%i',1);
   kconec(ii,3)=fscanf(fid,'%i',1);
   element_label(ii)=fscanf(fid,'%f',1);
end
for ii=1:nb_edge
   edge(ii,1)=fscanf(fid,'%i',1);
   edge(ii,2)=fscanf(fid,'%i',1);
   edge(ii,3)=fscanf(fid,'%i',1);
end
figure
hold on

for ii=1:nb_element
    line([vcor(kconec(ii,1),1) vcor(kconec(ii,2),1)],[vcor(kconec(ii,1),2) vcor(kconec(ii,2),2)],'Color','r');
    line([vcor(kconec(ii,1),1) vcor(kconec(ii,3),1)],[vcor(kconec(ii,1),2) vcor(kconec(ii,3),2)],'Color','r');
    line([vcor(kconec(ii,3),1) vcor(kconec(ii,2),1)],[vcor(kconec(ii,3),2) vcor(kconec(ii,2),2)],'Color','r');
    text(mean(vcor(kconec(ii,:),1)),mean(vcor(kconec(ii,:),2)),num2str(ii),'Fontsize',15);
end

plot(vcor(:,1),vcor(:,2),'.','Markersize',20);
for ii=1:nb_vertice
    text(vcor(ii,1),vcor(ii,2),num2str(ii),'Fontsize',15);
end
axis equal

figure
hold on

for ii=1:nb_element
    line([vcor(kconec(ii,1),1) vcor(kconec(ii,2),1)],[vcor(kconec(ii,1),2) vcor(kconec(ii,2),2)],'Color','r');
    line([vcor(kconec(ii,1),1) vcor(kconec(ii,3),1)],[vcor(kconec(ii,1),2) vcor(kconec(ii,3),2)],'Color','r');
    line([vcor(kconec(ii,3),1) vcor(kconec(ii,2),1)],[vcor(kconec(ii,3),2) vcor(kconec(ii,2),2)],'Color','r');
    text(mean(vcor(kconec(ii,:),1)),mean(vcor(kconec(ii,:),2)),num2str(element_label(ii)),'Fontsize',15);
end

plot(vcor(:,1),vcor(:,2),'.','Markersize',20);
for ii=1:nb_vertice
    text(vcor(ii,1),vcor(ii,2),num2str(node_label(ii)),'Fontsize',15);
end
for ii=1:nb_edge
    line([vcor(edge(ii,1),1) vcor(edge(ii,2),1)],[vcor(edge(ii,1),2) vcor(edge(ii,2),2)],'Color','g');
    text(mean(vcor(edge(ii,1:2),1)),mean(vcor(edge(ii,1:2),2)),num2str(edge(ii,3)),'Fontsize',15);
end
axis equal