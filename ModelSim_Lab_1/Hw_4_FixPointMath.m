%% Fixed Point Math 
% Hw 4


W = 32;
F = 16;

Fm = fimath('RoundingMethod','Floor',...
            'OverflowAction','wrap',...
            'ProductMode','SpecifyPrecision',...
            'ProductWordLength',W,...
            'ProductFractionLength',F,...
            'SumMode','SpecifyPrecision',...
            'SumWordLength',W,...
            'SumFractionLength',F);

fileID = fopen('matlab_fixed_point.txt','w');
fileID2 = fopen('matlab_fixed_point_output.txt','w');
step = 5;
zero_count = -1;
bit = 0;
place = 1;
three = fi(3,1,W,F,Fm);
for i = 1:step
    x = fi(100*rand+1,1,32,16);
    bin_x = bin(x);
    while bit ~= '1'
       bit = bin_x(place);
       place = place + 1;
       zero_count = zero_count + 1;
    end
    
    beta = W - F - zero_count - 1;
    
    if(mod(beta,2) == 0) 
        alpha = (-2)*beta+(.5)*beta;
    elseif(mod(beta,2) == 1)
        alpha = (-2)*beta+(.5)*beta+(.5);
    end
    
    x_alpha = fi(x*(2)^(alpha),1,W,F,Fm);
    x_beta = fi(x*(2)^(-beta),1,W,F,Fm);
    x_beta_double = double(x_beta);
    
    if(mod(beta,2) == 0)
        y0 = fi(x_alpha*(1/(x_beta_double)^(3/2)),1,W,F,Fm);
    elseif(mod(beta,2) == 1)
        y0 = fi(x_alpha*(1/(x_beta_double)^(3/2))*(1/sqrt(2)),1,W,F,Fm);
    end
    
    y_squared = y0^2;
    x_y0_squared = x*y_squared;
    three_x_y0_squared = three - x_y0_squared;
    y0_threexy0_squared = y0 * three_x_y0_squared;
    y0_rest_divide_2 = y0_threexy0_squared/2;
    
    b = fi(y0_rest_divide_2,1,32,16,Fm);
    fprintf(fileID,'%s\n',bin(x));
    fprintf(fileID2,'%s\n', bin(b));
    
    bit = 0;
    place = 1;
    zero_count = 0;
end

fclose(fileID);
fclose(fileID2);

% Leading zero comp


