%% Fixed Point Math 
% Hw 4


W = 32;
F = 16;

Fm = fimath('RoundingMethod','Floor',...
            'OverflowAction','wrap',...
            'ProductMode','SpecifyPrecision',...
            'ProductWordLength',W,...
            'SumFractionLength',F,...
            'SumMode','SpecifyPrecision',...
            'SumWordLength',W,...
            'SumFractionLength',F);

fileID = fopen('matlab_fixed_point.txt','w');
fileID2 = fopen('check.txt','w');
fileID3 = fopen('matlab_fixed_point_output.txt','w');
step = 5000;

for i = 1:step
    a = fi(3*rand,1,32,16);
    b = fi(bitsra(2*(3-(a)*4),1),1,32,16,Fm);
    fprintf(fileID,'%s\n',bin(a));
    fprintf(fileID2, '%s\n', hex(b));
    fprintf(fileID3,'%s\n', bin(b));
end

fclose(fileID);



