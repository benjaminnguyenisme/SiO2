%% Intial

% This is the program to reduce the size
% of the original trajectory
% Convert trajectorya.xyz -> a.xyz

clear;
clc;
numberStep = 101;
natoms = 19998;   
fileIndex = [0, 2, 5, 7, 10, 15, 20,...
   25, 30, 45, 60, 80, 100];

fprintf("Running\n\n");
for index = fileIndex
   fprintf("Converting File Index: %d.xyz\n", index);
   fileName = strcat('trajectory', num2str(index),'.xyz');
   fid=fopen(fileName); 

   tmp=0;
   while (tmp < numberStep)
      A0 = fscanf(fid, '%d ', [1 1]);
      A1 = fscanf(fid, '%s %s %ld', [3 1]);
      A2 = fscanf(fid, '%d %f %f %f ', [4 A0]);
      tmp = tmp+1;
      if mod(tmp, 5) == 0
         fprintf("/");
      end
   end
   fprintf("\n");
   A = A2';
   fileName = strcat(num2str(index),'.dat');
   fid = fopen(fileName, 'w');
   
   for i = 1 : natoms
      fprintf(fid, "%-5d %-10.6f %-10.6f %-10.6f\n", ...
         A(i,1), A(i,2), A(i,3), A(i,4));
   end
end

fprintf("\nFinish!");
