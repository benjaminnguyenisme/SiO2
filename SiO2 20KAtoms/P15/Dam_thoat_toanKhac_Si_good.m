clear all; clc; fclose all;
fid=fopen('Si_6.dat'); 
A=fscanf(fid,'%d    %f   %f    %f    %f   %d',[6 inf]);
A=A';
stt=A(:, 1); x=A(:, 2); y=A(:, 3); z=A(:, 4);
q=A(:,6);
id=A(:,5);

    NCL=17;
    sh1=sum(id==1);
    sh2=sum(id==2);
    sh=sh1+sh2;
    rmin=2.401;
    SPTO(sh1, 7)=0;
    SPT(1,8)=0;
%     fid=fopen('md0.dat'); 
%     A1=fscanf(fid,'%d  %f',[2 1]);
     l= 56.9005; l2=l/2; 
% assign id for clusters   
for i=1:sh1
    idcl(i)=i;
end
%==========================
for i=1:sh1
    dem(i)=0; k=0;
   for j=sh1+1:sh1+sh2
           rx=x(i)-x(j); 
           if (rx>l2) rx=rx-l;
           elseif (rx<(-l2)) rx=rx+l;
           end
           ry=y(i)-y(j);
           if (ry>l2) ry=ry-l;
           elseif (ry<(-l2)) ry=ry+l;
           end
           rz=z(i)-z(j);
           if (rz>l2) rz=rz-l;
           elseif (rz<(-l2)) rz=rz+l;
           end
           kc=sqrt(rx*rx+ry*ry+rz*rz);
              if((kc>0.001)&(kc<rmin))
                  dem(i)=dem(i)+1;  k=k+1;  SPTO(i,k)=j;idcl(j)=i;
              end
   end
   
   SPT(k)=SPT(k)+1;
 end
% assign id for clusters   
for i=1:sh1
    idcl(i)=i;
end
%==========================

  for i=1:sh1
   for j=i+1:sh1
        for k= SPTO(i,1:7) 
             for k1= SPTO(j,1:7) 
                        if (k==k1)&(k>0)
                              
                              b=idcl(i);
                              c=idcl(j); 
                              a=min(b,c);
                              for i1=1:sh
                                    if ((idcl(i1)==b)|(idcl(i1)==c))  
                                     idcl(i1)=a;
                                    end                                            
                                  end

                                  for i2=1:7
                                      if (SPTO(i, i2)>0)
                                      idcl(SPTO(i,i2)) =a;  
                                      end

                                      if (SPTO(j, i2)>0)
                                      idcl(SPTO(j,i2))=a;
                                      end 
                                  end   
                              idcl(i)=a; 
                              idcl(j)=a;
                              break; 
                          end
             end
                        
        end 
        %=================
   end
  end
  
  k=0;
  for i=1:sh
      tam=sum(idcl==i);
            if (tam>0)
                k=k+1; 
                Nat_cl(k)=tam;
                id_cl(k)=i;
            end
                
  end
  M=[Nat_cl; id_cl];
 
 
  k=0;
for i=1: max(Nat_cl)
    k=k+1;
    Nth(k)=sum(Nat_cl==i); Natom(k)=i;      
end
M2=[ Nth; Natom ];
M=M';    
M2=M2';
j=0;
for i=1: max(Nat_cl)
      if M2(i, 1)>0
         j=j+1;
        M3(j, :)= M2(i,:);
    end
end
%phan bo dam
PBD=fopen('pbd.dat', 'a');
fid=fopen('ghidam.dat', 'w');
for i=1:length(M3(:, 1))
     
    fprintf(PBD, '% 10d  %10d \n', M3(i, 1), M3(i, 2));
end
    fprintf(PBD, '\n  \n') ;
          
  
  %==========================================================
 mau2=[0 0 0];mau3= [1 1 0]; mau1=[1 0 1];
 [Sx Sy Sz]=sphere(40);
 ii=0;
 N=sh;
for i=1:N
    if (idcl(i)==NCL)
     if(id(i)==1)
         Ray=.45; mau=mau1;
     elseif (id(i)==2)
         Ray=.35; mau=mau2;
     elseif (id(i)==3)
         Ray=.55; mau=mau3;
    end
          surface((Ray*Sx + x(i)),(Ray*Sy + y(i)),(Ray*Sz + z(i)),'FaceColor',mau, 'EdgeColor','none'); 
          ii=ii+1
          fprintf(fid, '%6d  %12.3f  %12.3f% 12.3f %6d  %6d \n', ii, x(i), y(i), z(i), id(i), q(i));
          
    end
end
%+++++++++++++++++++++++
[xcyl,ycyl,zcyl]=cylinder(1,40); %z-oriented
dirc=[1e-10 1e-10 100000']; %Create a vector with a z-direction
Ray=0.15;
colorbond2=mau2;
                                        
  for i=1:N
    for j=1:N
        if(idcl(i)==NCL)&(idcl(j)==NCL)
     r=sqrt((x(i)-x(j))*(x(i)-x(j))+(y(i)-y(j))*(y(i)-y(j))+(z(i)-z(j))*(z(i)-z(j))); 
        if (((r<3.6)&(id(i)==3)&(id(j)==2))|((r<rmin)&(id(i)==1)&(id(j)==2)))
            a=xcyl*Ray;
            b=ycyl*Ray;
            c=zcyl;
            
                     if((id(i)==1))
                                           
                         colorbond1=mau1; 
                     end
                       if((id(i)==3))
                                           
                         colorbond1=mau3; 
                     end
                     
                    %first atom position
                    pc(1,1:3)= [x(i), y(i), z(i) ];
                    %second atom position
                    pc(2,1:3)= [(x(j)+x(i))/2, (y(j)+y(i))/2,(z(j)+z(i))/2];
                    %Bond creation
                    [m,I]=sort(pc(:,3));
                     a1=I(1);
                     b1=I(2);
                     h=surface(a+pc(a1,1),b+pc(a1,2),r*c/2+pc(a1,3),'FaceColor',colorbond1, 'EdgeColor','none');
                     a=pc(b1,:)-pc(a1,:);
                     b=dirc;
                     cr(1) = b(3)*a(2) - b(2)*a(3);
                     cr(2) = b(1)*a(3) - b(3)*a(1);
                     cr(3) = b(2)*a(1) - b(1)*a(2);
                     dir=pc(a1,:)+cr;
                     alfa=(180/pi)*(atan2(pc(b1,3)-pc(a1,3),((pc(b1,1)-pc(a1,1))^2+(pc(b1,2)-pc(a1,2))^2)^(1/2))-pi/2);                               
                     rotate(h,dir,alfa,pc(a1,:)+1e-9)
                     % ve nua tru sau
                     a=xcyl*Ray;
                     b=ycyl*Ray;
                     c=zcyl;
                    %first atom position
                    pc(1,1:3)= pc(2,1:3);
                    %second atom position
                    pc(2,1:3)= [x(j), y(j),z(j)];
                    %Bond creation
                    [m,I]=sort(pc(:,3));
                     a1=I(1);
                     b1=I(2);
                     h=surface(a+pc(a1,1),b+pc(a1,2),r*c/2+pc(a1,3),'FaceColor',colorbond2, 'EdgeColor','none');
                     a=pc(b1,:)-pc(a1,:);
                     b=dirc;
                     cr(1) = b(3)*a(2) - b(2)*a(3);
                     cr(2) = b(1)*a(3) - b(3)*a(1);
                     cr(3) = b(2)*a(1) - b(1)*a(2);
                     dir=pc(a1,:)+cr;
                     alfa=(180/pi)*(atan2(pc(b1,3)-pc(a1,3),((pc(b1,1)-pc(a1,1))^2+(pc(b1,2)-pc(a1,2))^2)^(1/2))-pi/2);                               
                     rotate(h,dir,alfa,pc(a1,:)+1e-9)
       
        end 
        end
                end 
  end

%====================
  mau3=[0 0 0];
  k1=1;
  Lx1=0;  Ly1=0;  Lz1=0;
  Lx2=l;  Ly2=l;  Lz2=l;
line([Lx1, Lx2],[Ly1, Ly1], [Lz1, Lz1],'Color',mau3,'LineWidth',k1*Ray);
line([Lx1, Lx2],[Ly1, Ly1], [Lz2, Lz2],'Color',mau3,'LineWidth',k1*Ray);
line([Lx1, Lx2],[Ly2, Ly2], [Lz1, Lz1],'Color',mau3,'LineWidth',k1*Ray);
line([Lx1, Lx2],[Ly2, Ly2], [Lz2, Lz2],'Color',mau3,'LineWidth',k1*Ray);

line([Lx2, Lx2],[Ly1, Ly1], [Lz1, Lz2],'Color',mau3,'LineWidth',k1*Ray);
line([Lx2, Lx2],[Ly2, Ly2], [Lz1, Lz2],'Color',mau3,'LineWidth',k1*Ray);
line([Lx1, Lx1],[Ly1, Ly1], [Lz1, Lz2],'Color',mau3,'LineWidth',k1*Ray);
line([Lx1, Lx1],[Ly2, Ly2], [Lz1, Lz2],'Color',mau3,'LineWidth',k1*Ray);

line([Lx2, Lx2],[Ly1, Ly2], [Lz1, Lz1],'Color',mau3,'LineWidth',k1*Ray);
line([Lx2, Lx2],[Ly1, Ly2], [Lz2, Lz2],'Color',mau3,'LineWidth',k1*Ray);
line([Lx1, Lx1],[Ly1, Ly2], [Lz1, Lz1],'Color',mau3,'LineWidth',k1*Ray);
line([Lx1, Lx1],[Ly1, Ly2], [Lz2, Lz2],'Color',mau3,'LineWidth',k1*Ray);
%//////////////////////////////////////////////////////////////////////////

 view(67, 12)                  
lighting gouraud
camlight
rotate3d on
set(gca,'DataAspectRatio',[ 1 1 1 ])
set(gca,'PlotBoxAspectRatio',[ 1 1 1 ])
set(gca,'CameraViewAngleMode','manual')
set(gcf,'Color',[1 1 1]);                %[0.1 0.2 0.8])
set(gcf,'Name','atomic viewer creat by HONGNV')
set(gca,'XTick',[])
set(gca,'YTick',[])
set(gca,'ZTick',[])
axis off
hold off
fclose(fid);

%======================================================================
    
   fclose all
       
       
   
 



