%% Intial
% This program produces paths to calcualate rings in C/Linux

clear; clc;

fileIndex = [0, 2, 5, 7, 10, 15, 20,...
   25, 30, 45, 60, 80, 100];

natoms = 19998;

fprintf("Running\n\n");
warning("Change R-cutoff");
rcutoff = 2.35;

for index = fileIndex
   fprintf("Processing File ID: %d.dat\n", index);
   fileName = strcat(num2str(index), '.dat');
   
   A = importdata(fileName);
   
   x = A(:,2);
   y = A(:,3);
   z = A(:,4);

   id = A(:,1);
   
   n1 = sum(id == 1);
   n2 = sum(id == 2);
   
   lx = max(x) - min(x);
   ly = max(y) - min(y);
   lz = max(z) - min(z);
   fileName = strcat('paths', num2str(index), '.dat');
   fid=fopen(fileName,'w');
   fprintf(fid,'@NGPH\n');
   fprintf(fid,'%d\n',natoms + 1);
   
   for i = 1 : n1
      for j = n1 + 1 : natoms
         rij = Dist(x(i), y(i), z(i), ...
            x(j), y(j), z(j), lx, ly, lz);
         if rij < rcutoff
            fprintf(fid,'%-5d  %-15d \n', i, j);
         end
      end
      if mod(i, 300) == 0
         fprintf("/")
      end
   end

   fprintf("\n");
   fprintf(fid,'-1 -1');
   fclose all;
end

fprintf("\nFinish!");


