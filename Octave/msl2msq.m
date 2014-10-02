%   Program msl2msq.m
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
% This program converts a linear mesh into a quadratic one. It is a part of 
% the course
% "Numerical Methods in Acoustics and Vibration"
%  given for students of the MSc Master Program in Acoustics and 
%  IMDEA students
% 


nb_noeuds_lin=nb_noeuds;
 nb_segments=3*nb_elements;


 segments=zeros(2,nb_segments);
 segment_ok=ones(nb_segments,1);
 
 
 
 
 for ii=1:nb_elements
    segments(1,1+3*(ii-1))=kconec(ii,1);
    segments(2,1+3*(ii-1))=kconec(ii,2);
    segments(1,2+3*(ii-1))=kconec(ii,2);
    segments(2,2+3*(ii-1))=kconec(ii,3);
    segments(1,3+3*(ii-1))=kconec(ii,3);
    segments(2,3+3*(ii-1))=kconec(ii,1);
 end
 
 
 
 for ii=1:nb_segments
    if (segments(1,ii)>segments(2,ii))
       jj=segments(2,ii);
       segments(2,ii)=segments(1,ii);
       segments(1,ii)=jj;
    end
 end
 

 for ii=1:(nb_segments-1)
    if (segment_ok(ii)==1)
       for jj=ii+1:nb_segments
            if (segments(1,ii)==segments(1,jj))&(segments(2,ii)==segments(2,jj))
                segment_ok(jj)=0;
            end
       end
    end
 end
 
  
 
 nvcbis=0;
 for ii=1:nb_segments
    if (segment_ok(ii)==1) 
       nvcbis=nvcbis+1; 
    end
 end
 
 
 vcl=zeros(nb_noeuds+nvcbis,3);
 til=zeros(nb_elements,6);
 

for ii=1:nb_elements
    for jj=1:3
       til(ii,jj)=kconec(ii,jj); 
    end
end
for ii=1:nb_noeuds
    vcl(ii,1)=vcor(ii,1);
    vcl(ii,2)=vcor(ii,2);
end 
 
for ii=1:nb_elements
   til(ii,5)=til(ii,3);
   til(ii,3)=til(ii,2);
   til(ii,2)=0;
end


nvc_add=0;
for ii=1:nb_elements
   jj=1;
   noeud_1=til(ii,1);
   noeud_2=til(ii,3);
   
   if (segment_ok(jj+3*(ii-1))==1)
        nvc_add=nvc_add+1;
        vcl(nb_noeuds+nvc_add,1)=(vcl(noeud_1,1)+vcl(noeud_2,1))/2;
        vcl(nb_noeuds+nvc_add,2)=(vcl(noeud_1,2)+vcl(noeud_2,2))/2;
        til(ii,2)=nb_noeuds+nvc_add;
   else
       x_temp=(vcl(noeud_1,1)+vcl(noeud_2,1))/2;
       y_temp=(vcl(noeud_1,2)+vcl(noeud_2,2))/2;
       [min_noeud i_noeud]=min(abs((vcl(:,1)-x_temp).^2+(vcl(:,2)-y_temp).^2));
       til(ii,2)=i_noeud;
   end
   jj=2;
   noeud_1=til(ii,3);
   noeud_2=til(ii,5);
   
   if (segment_ok(jj+3*(ii-1))==1)
        nvc_add=nvc_add+1;
        vcl(nb_noeuds+nvc_add,1)=(vcl(noeud_1,1)+vcl(noeud_2,1))/2;
        vcl(nb_noeuds+nvc_add,2)=(vcl(noeud_1,2)+vcl(noeud_2,2))/2;
        til(ii,4)=nb_noeuds+nvc_add;
   else
       x_temp=(vcl(noeud_1,1)+vcl(noeud_2,1))/2;
       y_temp=(vcl(noeud_1,2)+vcl(noeud_2,2))/2;
       [min_noeud i_noeud]=min(abs((vcl(:,1)-x_temp).^2+(vcl(:,2)-y_temp).^2));
       til(ii,4)=i_noeud;
   end
   jj=3;
   noeud_1=til(ii,5);
   noeud_2=til(ii,1);
   
   if (segment_ok(jj+3*(ii-1))==1)
        nvc_add=nvc_add+1;
        vcl(nb_noeuds+nvc_add,1)=(vcl(noeud_1,1)+vcl(noeud_2,1))/2;
        vcl(nb_noeuds+nvc_add,2)=(vcl(noeud_1,2)+vcl(noeud_2,2))/2;
        til(ii,6)=nb_noeuds+nvc_add;
   else
       x_temp=(vcl(noeud_1,1)+vcl(noeud_2,1))/2;
       y_temp=(vcl(noeud_1,2)+vcl(noeud_2,2))/2;
       [min_noeud i_noeud]=min(abs((vcl(:,1)-x_temp).^2+(vcl(:,2)-y_temp).^2));
       til(ii,6)=i_noeud;
   end
   
   
end


nb_noeuds=nb_noeuds+nvcbis;
kconec=til;
vcor=vcl;


clear x_temp
clear y_temp
clear i_noeud
clear min_noeud
clear nvc_add
 clear nvcbis
 clear nb_segments
 clear segments_ok
 clear segments
 