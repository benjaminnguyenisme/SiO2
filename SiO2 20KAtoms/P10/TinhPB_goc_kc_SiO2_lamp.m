clear all
clc ;
global x y z lx ly lz lx2 ly2 lz2
fid=fopen('trajectory.xyz'); 
tam=0;
while (tam<10)
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
 
 sh1=sum(c==1)

r1=2.3;

%%%%%%%%%%%%%%%%%%%%%%%%%
dg=2; sgoc=round(180/dg);sr=300; dr=0.02;
rt=zeros(20,1);
kt=zeros(20,1);
goc2O=zeros(sgoc,1);goc3O=goc2O; goc4O=goc2O;
goc4=zeros(sgoc,1); goc5=goc4; goc6=goc4; 
r4=zeros(sr,1); 
r5=r4;r6=r4;r2O=r4;r3O=r4;r4O=r4;
%%%%%%%%%%%%%%% phan bo goc va khoang cach


for i=1:sh1
    k=0;
    for j=1:sh 
          if c(i)~=c(j)
             rt(k+1)=KC_rij(i,j);
             if rt(k+1)>0.4 &rt(k+1)<r1
                k=k+1; kt(k)=j;
             end
          end
    end
   %%%%%%%%%%   pb khoang cach
   for j=1:k  
      t1=round(rt(j)/dr);
      if(c(i)==1) 
          if(k==4) 
              r4(t1)=r4(t1)+1.;
           elseif (k==5)
                r5(t1)=r5(t1)+1;
           elseif(k==6)
              r6(t1)=r6(t1)+1;
          end
       else
          if(k==2)r2O(t1)=r2O(t1)+1;
            elseif(k==3)r3O(t1)=r3O(t1)+1;
            elseif(k==4)r4O(t1)=r4O(t1)+1;        
          end
      end
   end
  %%%%%%%%%%%%%%%%% tinh phan bo goc   
      
   for t1=1:k-1          
     for t2=t1+1:k
        t3=kt(t1);t4=kt(t2);j=round(Tinhgoc(i,t3,t4)/dg)+1;
        if j>180/dg; j=180/dg; end % loai bo loi vuot kich thuoc
        
       if c(i)==1
                if(k==4) 
                 goc4(j)=goc4(j)+1.;
                elseif(k==5)
                    goc5(j)=goc5(j)+1;
                elseif(k==6)
                    goc6(j)=goc6(j)+1;
                end
             
       elseif c(i)==2
              if(k==2)
                  goc2O(j)=goc2O(j)+1;
              elseif(k==3)
                  goc3O(j)=goc3O(j)+1;
              elseif(k==4)
                  goc4O(j)=goc4O(j)+1;
              end
         end         
      end          
   end
end


p=fopen('pbGOC.dat', 'w');
 for i=1:sgoc

 fprintf(p,'%8.2f %8.2f %8.2f %8.2f %8.2f %8.2f %8.2f\n',i*dg,goc4(i),goc5(i),goc6(i),goc2O(i),goc3O(i),goc4O(i));
end

for(i=1:sr)
fprintf(p,'%8.2f %8.2f %8.2f %8.2f %8.2f %8.2f %8.2f\n',i*dr,r4(i),r5(i),r6(i),r2O(i),r3O(i),r4O(i));
end

fclose all
