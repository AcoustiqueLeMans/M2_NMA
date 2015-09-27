clear all
close all
clc

nb_elem=250;
L=1;

nb_modes=25;

size_elem=L/nb_elem;


M_global=zeros(nb_elem+1,nb_elem+1);
K_global=zeros(nb_elem+1,nb_elem+1);

for ie=1:nb_elem

   k_elem=(1/size_elem)*[1 -1;-1 1];
   m_elem=(size_elem/6)*[2  1; 1 2];
    
   dof_1=ie;
   dof_2=ie+1;
   M_global(dof_1:dof_2,dof_1:dof_2)=M_global(dof_1:dof_2,dof_1:dof_2)+m_elem;
   K_global(dof_1:dof_2,dof_1:dof_2)=K_global(dof_1:dof_2,dof_1:dof_2)+k_elem;
end

k_FEM=sqrt(eigs(K_global,M_global,nb_modes,'SR'));

k_analytical=[0:nb_modes-1]'*pi/L;

figure
hold on
plot([1:nb_modes]-1,sort(k_FEM),'.')
plot([1:nb_modes]-1,k_analytical,'r+')