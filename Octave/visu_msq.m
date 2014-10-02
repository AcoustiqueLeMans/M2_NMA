%   Program visu_msq.m
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
% This program draws a FEM mesh for a quadratic elements. It is a part of 
% the course
% "Numerical Methods in Acoustics and Vibration"
%  given for students of the MSc Master Program in Acoustics and 
%  IMDEA students
% 

figure
hold on

for ii=1:nb_elements
    line([vcor(kconec(ii,1),1) vcor(kconec(ii,2),1)],[vcor(kconec(ii,1),2) vcor(kconec(ii,2),2)],'Color','r');
    line([vcor(kconec(ii,2),1) vcor(kconec(ii,3),1)],[vcor(kconec(ii,2),2) vcor(kconec(ii,3),2)],'Color','r');
    line([vcor(kconec(ii,3),1) vcor(kconec(ii,4),1)],[vcor(kconec(ii,3),2) vcor(kconec(ii,4),2)],'Color','r');
    line([vcor(kconec(ii,4),1) vcor(kconec(ii,5),1)],[vcor(kconec(ii,4),2) vcor(kconec(ii,5),2)],'Color','r');
    line([vcor(kconec(ii,5),1) vcor(kconec(ii,6),1)],[vcor(kconec(ii,5),2) vcor(kconec(ii,6),2)],'Color','r');
    line([vcor(kconec(ii,6),1) vcor(kconec(ii,1),1)],[vcor(kconec(ii,6),2) vcor(kconec(ii,1),2)],'Color','r');    
    text(mean(vcor(kconec(ii,:),1)),mean(vcor(kconec(ii,:),2)),num2str(ii),'Fontsize',15);
end

plot(vcor(:,1),vcor(:,2),'.','Markersize',20);
for ii=1:nb_noeuds
    text(vcor(ii,1),vcor(ii,2),num2str(ii),'Fontsize',15);
end

