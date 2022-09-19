%////////////////////reading Data///////////////////////
clear all
clc
SizeG=1200;  
fid=fopen('trajectory.xyz'); 
tam=0;
while (tam<101)
A0=fscanf(fid,'%d ',[1 1]);
A1=fscanf(fid,'%s %s %ld ',[3 1]);
A2=fscanf(fid,'%d %f %f %f ',[4, A0]);
tam=tam+1; % vi cach 50000 step ghi mot lan 
end
A=A2';

sh=A0;
j=1;
n=sh;


for i=1:n
    xb(j)=A(i,2);
    yb(j)=A(i,3);
    zb(j)=A(i,4);
    c(j)=A(i, 1);
    j=j+1;
end
lx=max(xb)-min(xb); ly=max(yb)-min(yb); lz=max(zb)-min(zb);
na=sum(c==1); % so Si
nb=sum(c==2);  % So O
nc=sum(c==3);  % so Si
nd=sum(c==4);  % so O

%///////////////////////////////////////////////////
gav=zeros(SizeG, 1);
g11=zeros(SizeG, 1);g12=g11; g13=g11;g14=g11; 
g22=g11;g23=g11; g24=g11;
g33=g11;g34=g11;  g44=g11;
dg=0.02; lm=dg*(SizeG-1);
if lm>lx/2 ;
    lm=lx/2;
end

for i=1:n-1
    for j=(i+1):n
        r=khoangcach(xb(i), yb(i), zb(i), xb(j), yb(j), zb(j), lx, ly, lz);
        if(r<lm) k=round(1+r/dg); 
          if(c(i)==1&&c(j)==1) g11(k)=g11(k)+1.0; end
          if(c(i)==1&&c(j)==2) g12(k)=g12(k)+1.0; end             
          if(c(i)==2&&c(j)==2) g22(k)=g22(k)+1.0; end
         end
    end
end

for i=1:SizeG
    g11(i)=g11(i)/na/(2*pi*dg*dg*i*i*dg+1.e-20)/(na/lx/ly/lz);
    g12(i)=g12(i)/na/(4*pi*dg*dg*i*i*dg+1.e-20)/(nb/lz/ly/lz);
    g22(i)=g22(i)/nb/(2*pi*dg*dg*i*i*dg+1.e-20)/(nb/lx/ly/lz);
  end
set(gca,'fontsize',15)
for i=1:SizeG
    R(i)=i*dg;
end

p1=fopen('PBXT_2n.dat','w');
for i=1:SizeG
fprintf(p1,'%5.2f %5.2f %5.2f %5.2f  \n',R(i), g11(i), g12(i), g22(i));
end

a=[min(xb), max(xb); min(yb) max(yb); min(zb), max(zb)]
%plot(R, g11,'r', R, g12,'b', R, g22, 'k','linewidth', 2)
plot(R, g22, 'k','linewidth', 2)
xlabel('r(angstrom)','fontsize',15)
ylabel('g(r)','fontsize',15)
axis([0 8 0 5])
fclose all;




