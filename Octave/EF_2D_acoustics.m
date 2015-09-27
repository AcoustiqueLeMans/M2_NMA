%   Program EF_2D_acoustics.m
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
% This program computes the modes of an acoustic cavity. It is a part of
% the course
% "Numerical Methods in Acoustics and Vibration"
%  given for students of the MSc Master Program in Acoustics and
%  IMDEA students
%

clear all
close all
clc

% Boolean values to indicate if we plot or not the mesh and the modes

plot_mesh=0;
plot_modes=0;
nb_mode_plot=2; % # of the mode whic is plot


% Type of the element, 1 for linear and 2 for quadratic

typ_elem=2;

% Dimension of the domain

L_x=10e-1;
L_y=1e-1;

% Number of elements in each direction

nb_element_x=10;
nb_element_y=1;

% Number of modes to be computed

nb_frequency=25;

%  Physical parameters

rho_0=1.2;
c_0=340;

% Script to create a mesh with FreeFEM++ and read it in this program

maillage_ffem

if plot_mesh
    if typ_elem==1
        visu_msl
    elseif typ_elem==2
        visu_msq
    end
end


% Creation of the global matrices

H_global=zeros(nb_noeuds,nb_noeuds);
Q_global=zeros(nb_noeuds,nb_noeuds);




for ie=1:size(kconec,1),
    
    vcore = vcor(kconec(ie,:),1:2);
    if (typ_elem==1)
        [h_elem,q_elem]=linear_triangle_acoustics(vcore);
    elseif  (typ_elem==2)
        [h_elem,q_elem]=quadratic_triangle_acoustics(vcore);
        
    end
    index_pressure=kconec(ie,:);
    
    H_global(index_pressure,index_pressure)=H_global(index_pressure,index_pressure)+h_elem;
    Q_global(index_pressure,index_pressure)=Q_global(index_pressure,index_pressure)+q_elem;
end



[P_modes lambda]=eigs(H_global/rho_0,Q_global/(rho_0*c_0^2),nb_frequency,'sm');

frequency_FEM=sqrt(diag(lambda))/(2*pi);


for nn=0:nb_frequency-1
   for mm=0:nb_frequency-1
      k_theory(nn+1,mm+1)=sqrt((nn*pi/L_x)^2+(mm*pi/L_y)^2); 
   end
end

k_theory=reshape(k_theory,[nb_frequency*nb_frequency,1]);
k_theory=sort(k_theory)';
k_theory=k_theory(1:nb_frequency)';
frequency_theory=c_0*k_theory/(2*pi);

disp('Result of the calculation')
disp('[FEM Theory Error]')

[temp, i_sort]=sort(frequency_FEM);
frequency_FEM=frequency_FEM(i_sort);
P_modes(:,:)=P_modes(:,i_sort);

%[(frequency_FEM) frequency_theory) sort(frequency_FEM)-sort(frequency_theory)]

if plot_modes==1
    if typ_elem==1
        figure
        hold on
        for ie=1:nb_elements
            x=[vcor(kconec(ie,1),1) vcor(kconec(ie,2),1) vcor(kconec(ie,3),1)];
            y=[vcor(kconec(ie,1),2) vcor(kconec(ie,2),2) vcor(kconec(ie,3),2)];
            c=[P_modes(kconec(ie,1),nb_mode_plot);P_modes(kconec(ie,2),nb_mode_plot);P_modes(kconec(ie,3),nb_mode_plot)];
            patch(x,y,abs((c)));
        end
        axis equal
        colorbar
    end
end

figure
plot(sort(frequency_theory),'r+')
hold on
plot(frequency_FEM,'b.')