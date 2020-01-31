%% Fixed Point Math 
% Hw 4

Fm = fimath();

fileID = fopen('matlab_fixed_point.txt','w');



step = 10;

for i = 1:step
    b = fi(100*rand,1,32,16);
    fprintf(fileID,'%f\n',b);
end

fclose(fileID);
