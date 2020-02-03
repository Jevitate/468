%% Fixed Point Math 
% Hw 4

Fm = fimath('OverflowAction','wrap');

fileID = fopen('matlab_fixed_point.txt','w');

step = 10;

for i = 1:step
    a = fi(100*rand,1,32,16);
    fprintf(fileID,'%s\n',bin(a));
end

fclose(fileID);

% Fixed point calculations %

fileID = fopen('matlab_fixed_point.txt','r');

for i = 1:step
    b = fi(textscan(fileID, '%s'),1,32,16,Fm);
    b = b+8;
    fprintf('matlab_fixed_point_output.txt', '%s\n', bin(b));
end;

fclose(fileID);



    