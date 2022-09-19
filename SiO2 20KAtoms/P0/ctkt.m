%binh ph??ng toi thieu;
%doc file;
fid=fopen('kq.dat');
A=fscanf(fid,'%lf    %lf  %lf    %lf    %lf  %lf   %lf',[7 inf]);

A=A';
fclose(fid);
[m,n]=size(A);
j=1;
for i=1:m
   if((mod(i,100)==1)&(i>4999)&(i<=10001))
    %if((i>=50)&(i<=250))
    x(j)=A(i,1);
    y1(j)=A(i,6);
    y2(j)=A(i,7);
    j=j+1;
    end
  end
    
p1=polyfit(x,y1,1);% p1 la da thuc he so a, b noi suy cua Si
p2=polyfit(x,y2,1);%p2 la da thuc he so a, b noi suy cua O
yy=p1(1)*x+p1(2);
yy2=p2(1)*x+p2(2);
plot(x, y1, x, yy); hold on;
plot(x, y2, x, yy2)


%tinh he so khuech tan cua SiO2
h=0.885e-2;
r0=1e-10;
Na=6.023e23;
na=666; nb=1332
efxnon=1.602e-19;
%ma=28.085*1e-3/Na; %for Si
%mb=15.999*1e-3/Na;
ma=72.61*1e-3/Na; %for Ge
mb=15.999*1e-3/Na;
mo=ma;
t0=sqrt(mo*r0*r0/efxnon);
t0=t0*h;
%D_Si=p1(1)*1e-16/na/6/t0
%D_O=p2(1)*1e-16/nb/6/t0
D_Ge=p1(1)*1e-16/na/6/t0
D_O=p2(1)*1e-16/nb/6/t0
