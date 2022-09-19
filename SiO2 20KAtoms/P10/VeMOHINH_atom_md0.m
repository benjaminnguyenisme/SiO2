clear all;
clc;
%========= mo file va doc toa do, sh=so hat= so nguyen tu==
fid=fopen('mdP0.dat'); 
A00=fscanf(fid,'%d    %f  ',[2 1]);
l=A00(2)
A=fscanf(fid,'%d    %f  %f    %f    %f  %d',[6 inf]);
A=A';
sh=length(A(:,1))
Lx1=0; Lx2=24;
Ly1=0; Ly2=10;
Lz1=0; Lz2=24;
U=size(A)
j=0;
for i=1:sh
 if((A(i, 2)>Lx1)&(A(i,2)<Lx2)&((A(i,3)>Ly1)&(A(i,3)<Ly2))&((A(i,4)>Lz1)&(A(i,4)<Lz2)))
    j=j+1;
    x(j)=A(i,2);
    y(j)=A(i,3);
    z(j)=A(i,4);
    id(j)=A(i,6);
    c(j)=A(i,5);
   end
end
clear A;
sh=length(x);
  %/////////////////////////////////////
% draw atomics general for 3 different atomics

mau1=[1 0. 0.];
mau2=[0 0 1];
mau3=[0 1 0];
 [Sx Sy Sz]=sphere(40);
  for i=1:sh
     if(id(i)==1)
         Ray=.6; mau=mau1;
     elseif (id(i)==2)
         Ray=.4; mau=mau2;
     elseif (id(i)==3)
         Ray=.6; mau=mau3;
    end
          surface((Ray*Sx + x(i)),(Ray*Sy + y(i)),(Ray*Sz + z(i)),'FaceColor',mau, 'EdgeColor','none'); 
     
  end
   view(3)
 %+++++++++++++++++ ++++++ ve tru lien ket+++++++
[xcyl,ycyl,zcyl]=cylinder(1,40); %z-oriented
dirc=[1e-10 1e-10 100000']; %Create a vector with a z-direction
Ray=0.15
%colorbond1=mau2; 
colorbond2=mau2;
                                        
  for i=1:sh
    for j=2:sh
     r=sqrt((x(i)-x(j))*(x(i)-x(j))+(y(i)-y(j))*(y(i)-y(j))+(z(i)-z(j))*(z(i)-z(j))); 
        if ((r<2.6)&(id(j)==2)&((id(i)==1)|(id(i)==3)))
            if(id(i)==1); colorbond1=mau1;
                
            end
            if(id(i)==3); colorbond1=mau3;
                
           end
            a=xcyl*Ray;
            b=ycyl*Ray;
            c=zcyl;
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
     
  view(-13.5, 6)
  
  % ve duong bao hinh hop
  mau3=[0 0 0];
  k1=1;
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
% %//////////////////////////////////////////////////////////////////////////

                    
lighting gouraud
camlight
rotate3D on
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

fclose all;