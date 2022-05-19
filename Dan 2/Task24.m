%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%KONV1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fileID = fopen('Konv1.txt','r');
formatSpec = '%e';
y_1 = fscanf(fileID,formatSpec);
fileID = fopen('Kernel1.txt','r');
A_1_first = fscanf(fileID,formatSpec);
A_1 = toeplitz(A_1_first);
fileID = fopen('signal1.txt','r');
x_1 = fscanf(fileID,formatSpec);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%KONV2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fileID = fopen('Konv2.txt','r');
formatSpec = '%e';
y_2 = fscanf(fileID,formatSpec);
fileID = fopen('Kernel1.txt','r');
A_2_first = fscanf(fileID,formatSpec);
A_2 = toeplitz(A_2_first);
fileID = fopen('signal2.txt','r');
x_2 = fscanf(fileID,formatSpec);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%KONV3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fileID = fopen('Konv3.txt','r');
formatSpec = '%e';
y_3 = fscanf(fileID,formatSpec);
fileID = fopen('Kernel2.txt','r');
A_3_first = fscanf(fileID,formatSpec);
A_3 = toeplitz(A_3_first);
fileID = fopen('signal1.txt','r');
x_3 = fscanf(fileID,formatSpec);