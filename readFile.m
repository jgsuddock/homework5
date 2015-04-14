%% Reads input file
str = fopen('hw5db1.txt');
c = textscan(str,'%s %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(str);

%% Remove First 3 columns (Unneeded Data)
c(:,1) = [];
c(:,1) = [];
c(:,1) = [];

%% Converts cell array to 2D matrix
mat = cell2mat(c);
active = mat(1:1347,:);
nonactive = mat(1348:43347,:);
