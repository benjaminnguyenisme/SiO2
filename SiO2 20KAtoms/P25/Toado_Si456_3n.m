clear all
clc
%mo file va doc toa do, sh=so hat= so nguyen tu
fid=fopen('md0.dat'); 
A1=fscanf(fid,'%d  %f',[2 1]);
l=A1(2,1);
sh=A1(1, 1);
l2=l/2.0;
A=fscanf(fid,'%d  %f  %f    %f  %f  %f ',[6 sh]);
A=A';
j=0;
%thay doi kich thuoc hinh hop o day
Lx1=min(A(:,2))-0.01;Lx2=max(A(:,2))+0.01;
Ly1=min(A(:,3))-0.01;Ly2=max(A(:,3))+0.01;
Lz1=min(A(:,4))-0.01;Lz2=max(A(:,4))+0.01;
rmin1=2.3;
% Kich thuoc duong bien
k1=5;
%Kich thuoc duong lien ket 
k=4;
%/////////////////////////////////////
for i=1:sh
   if((A(i,2)>Lx1)&(A(i,2)<Lx2)&((A(i,3)>Ly1)&(A(i,3)<Ly2))&((A(i,4)>Lz1)&(A(i,4)<Lz2)))
    j=j+1;
    x(j)=A(i,2);
    y(j)=A(i,3);
    z(j)=A(i,4);
    c(j)=A(i,6);
    id(j)=A(i,6);
    
   end
end
sh1=sum(id==1);
sh2=sum(id==2);
x=x';
y=y';
z=z';
%c=c';
n=19;
%sh=length(x);
P=fopen('TD_O.dat', 'w');
AA=sum(c<2);
BB=sum(c==2)
SPT=zeros(n, 1);
for i=1:sh1
    dem(i)=0;k=0;
   for j=sh1+1:sh1+sh2
           rx=x(i)-x(j); 
            if(rx>l2) rx=rx-l; %end;% bien tuan hoan 
            elseif(rx<-l2) rx=rx+l;
            end
           ry=y(i)-y(j);
            if(ry>l2) ry=ry-l; %end; % bien tuan hoan 
            elseif(ry<-l2) ry=ry+l;
            end
           rz=z(i)-z(j);
            if(rz>l2) rz=rz-l; %end; % bien tuan hoan 
            elseif(rz<-l2) rz=rz+l;
            end
            kc=sqrt(rx*rx+ry*ry+rz*rz);
           if((kc>0.001)&(kc<rmin1)&(c(i)==1)&((c(j)==2)))
               k=k+1; dem(i)=dem(i)+1; xt(k)=j; 
           end
   end
          %SPT(dem)=SPT(dem)+1;
          fprintf(P, '%12d %12.4f %12.4f %12.4f %12.4f %12d\n', i, x(i), y(i), z(i), c(i), dem(i));
          for ii=1:k
              fprintf(P,'%12d %12.4f %12.4f %12.4f %12.4f %12d\n',xt(ii), x(xt(ii)), y(xt(ii)), z(xt(ii)), c(xt(ii)), dem(i));
                 
          end
end
    fclose(P)

%title('Si large Sphere, O small Sphere')
fclose(fid)
%ii=1:n;
%plot(ii, SPT-1)
clear x y z A A1 id c; 
fid=fopen('TD_O.dat');
A=fscanf(fid,'%d    %f  %f    %f %f %d ',[6 inf]);
A=A';
P1=fopen('Si_4.dat', 'w');
P2=fopen('Si_5.dat', 'w');
P3=fopen('Si_6.dat', 'w');
P4=fopen('Si_7.dat', 'w');
P456=fopen('Si456.dat', 'w');

K4=0;
K5=0;
K6=0;
for i=1:sh1+sh2
    for j=1:length(A(:,1))
        if ((A(j,1)==i))
        fprintf(P456, '%12d %12.4f %12.4f %12.4f %12.4f %12d\n', A(j,1),A(j,2),A(j,3),A(j,4),A(j,5),A(j,6)); 
        K4=K4+1;
        break;
        end
    end
      
    for j=1:length(A(:,1))
        if ((A(j,1)==i)&(A(j,6)==4))
        fprintf(P1, '%12d %12.4f %12.4f %12.4f %12.4f %12d\n', A(j,1),A(j,2),A(j,3),A(j,4),A(j,5),A(j,6)); 
        K4=K4+1;
        break;
        end
    end
     
    for j=1:length(A(:,1))
        if ((A(j,1)==i)&(A(j,6)==5))
        fprintf(P2, '%12d %12.4f %12.4f %12.4f %12.4f %12d\n', A(j,1),A(j,2),A(j,3),A(j,4),A(j,5),A(j,6)); 
        K5=K5+1;
        break;
        end
    end
     for j=1:length(A(:,1))
        if ((A(j,1)==i)&(A(j,6)==6))
        fprintf(P3, '%12d %12.4f %12.4f %12.4f %12.4f %12d\n', A(j,1),A(j,2),A(j,3),A(j,4),A(j,5),A(j,6)); 
        K6=K6+1;
        break;
        end
     end
     for j=1:length(A(:,1))
        if ((A(j,1)==i)&(A(j,6)==7))
        fprintf(P4, '%12d %12.4f %12.4f %12.4f %12.4f %12d\n', A(j,1),A(j,2),A(j,3),A(j,4),A(j,5),A(j,6)); 
        K6=K6+1;
        break;
        end
     end
        
end
fclose(P3)
fclose(P4)
fclose(P1)
fclose(P2)
fclose(P456)
fclose(fid)






