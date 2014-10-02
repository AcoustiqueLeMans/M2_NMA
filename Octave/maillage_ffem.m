%   Program maillage_ffem.m
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
% This program computes askt to FreeFEM++ to create a mesh and import this mesh. 
% It is a part of the course
% "Numerical Methods in Acoustics and Vibration"
%  given for students of the MSc Master Program in Acoustics and 
%  IMDEA students
% 



fid=fopen('mesh.inp','w');
fprintf(fid,'%12.8f\n',L_x);
fprintf(fid,'%12.8f\n',L_y);
fprintf(fid,'%d\n',nb_element_x);
fprintf(fid,'%d\n',nb_element_y);
fclose(fid);

if ismac
    system('/usr/local/bin/FreeFem++ mesh.edp')
elseif ispc
    system('FreeFem++ mesh.edp')
elseif (isunix&(~ismac))
    system('/usr/local/bin/FreeFem++ mesh.edp')    
end

fid=fopen('mesh.msh','r');
nb_noeuds=fscanf(fid,'%i',1);
nb_elements=fscanf(fid,'%i',1);
nb_edge=fscanf(fid,'%i',1);

for ii=1:nb_noeuds
    vcor(ii,1)=fscanf(fid,'%f',1);
    vcor(ii,2)=fscanf(fid,'%f',1);
    vcor(ii,3)=0;
    node_label(ii)=fscanf(fid,'%f',1);
end
for ii=1:nb_elements
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
fclose(fid);

if (typ_elem==2)
    msl2msq
end