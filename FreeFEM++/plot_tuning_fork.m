clear all
close all


load('normu2_PML.txt');
load('normu2_FSI.txt');
load('normu2_invacuo.txt');

figure(1)

semilogy(normu2_invacuo(:,1),sqrt(normu2_invacuo(:,2)),'b','Linewidth',3)
set(gca,'Fontsize',15)
hold on
semilogy(normu2_PML(:,1),sqrt(normu2_PML(:,2)),'m','Linewidth',3)
semilogy(normu2_FSI(:,1),sqrt(normu2_FSI(:,2)),'r','Linewidth',3)



figure(2)
semilogy(normu2_PML(:,1),sqrt(normu2_PML(:,3)),'m','Linewidth',3)
set(gca,'Fontsize',15)
hold on
semilogy(normu2_FSI(:,1),sqrt(normu2_FSI(:,3)),'r','Linewidth',3)
