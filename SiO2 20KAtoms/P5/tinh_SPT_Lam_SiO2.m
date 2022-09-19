clear all
clc 
fid=fopen('trajectory.xyz'); 
tam=0;
while (tam<101)
A0=fscanf(fid,'%d',[1  1]);
A1=fscanf(fid,'%s %s %ld ',[3 1]);
A2=fscanf(fid,'%d %f %f %f ',[4 A0]);
tam=tam+1; % vi cach 50000 step ghi mot lan 
end
A=A2';
sh=A0;
j=1;
n=sh;
for i=1:n
    x(j)=A(i,2);
    y(j)=A(i,3);
    z(j)=A(i,4);
    c(j)=A(i, 1);
    j=j+1;
end
 lx=max(x)-min(x);ly=max(y)-min(y);lz=max(z)-min(z);lx2=lx/2; ly2=ly/2; lz2=lz/2; 
r1=2.3;
n=19
CN_O=zeros(n, 1);
CN_Si=zeros(n, 1);

sh1=sum(c==1);sh2=sum(c==2)
sh=sh1+sh2;

% tinh so phoi tri

xx=0;
for i=1:sh1
    NSi=0;
   for j=sh1+1:sh
           kc(i+j)=khoangcach(x(i), y(i), z(i), x(j), y(j), z(j), lx, ly, lz);
        if(kc(i+j)<r1)
            NSi=NSi+1;
      end
   end
   if(NSi>0)
       CN_Si(NSi)=CN_Si(NSi)+1;
   end
  
   
end   

for i=sh1+1:sh
    NO=0; 
   for j=1:sh1
           kc=khoangcach(x(i), y(i), z(i), x(j), y(j), z(j), lx, ly, lz);
        if(kc<r1)
            NO=NO+1;
       end
   end
   if(NO>0)
       CN_O(NO)=CN_O(NO)+1;
   end
  
   
end   

M=[CN_Si, CN_O]

p=fopen('pbsptSiO_OSi.dat','w');
fprintf(p,'\n SPT   Si   O'),
for i=1:n
fprintf(p,'\n %12d %12d %12d',i, CN_Si(i), CN_O(i));
end

fclose all
