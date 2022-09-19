clear all; clc
%////////////////////reading Data///////////////////////
clear all
clc
SizeG=1200;  
fid=fopen('trajectory.xyz'); 
%A00=fscanf(fid,'%d    %f  ',[2 1]);
tam=0;
while (tam<101)
A0=fscanf(fid,'%d ',[1 1]);
A1=fscanf(fid,'%s %s %ld ',[3 1]);
A2=fscanf(fid,'%d %f %f %f ',[4 A0]);
tam=tam+1;
end
%n=A1(1); l=A1(2);
A=A2';j=1;
n=length(A(:,1));


for i=1:n
    xb(j)=A(i,2);
    yb(j)=A(i,3);
    zb(j)=A(i,4);
    id(j)=A(i, 1);
    if(id(j)==1)
        q(j)=2.4;
    else q(j)=-1.2;
    end
    j=j+1;
end

N=length(xb); L=max(xb)-min(xb);
f1=fopen('md0.dat','w');
 fprintf(f1,'%6d %8.4f \n', N, L);  


for i=1:N
          
       fprintf(f1,'%6d  %7.5f  %9.5f  %9.5f  %9.1f  %3d \n',i-1, xb(i), yb(i), zb(i), q(i), id(i)); 
       
end


for i=1:N
              
         fprintf(f1,'%6d %8.5f  %8.5f  %8.5f   \n ',i-1, xb(i)+0.05*randn, yb(i)+0.05*randn, zb(i)+0.05*randn); 
   
end

for i=1:N
              
         fprintf(f1,'%6d %8.5f  %8.5f  %8.5f   \n ',i-1, 0.1*randn, 0.1*randn,0.1*randn);
     
end
fclose all;
