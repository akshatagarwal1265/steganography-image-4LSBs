%Hiding a smaller/equal sized pic in bigger/equal sized pic

%Getting Larger/Same CANVAS Image from User Via Dialog Box
[FileName1,PathName1]=uigetfile({'*.jpg;*.jpeg;*.png;*.tif','Acceptable Types'},...
    'Select the "jpg", "jpeg", "png" or "tif" file to be used as Canvas:');
FullName1=fullfile(PathName1,FileName1);
if isequal(FileName1,0)
    disp('Selection Cancelled')
    return;
else
    disp(FullName1)
end

%Getting Smaller/Same DATA Image from User Via Dialog Box
[FileName2,PathName2]=uigetfile({'*.jpg;*.jpeg;*.png;*.tif','Acceptable Types'},...
    'Select the "jpg", "jpeg", "png" or "tif" file to be used as HiddenData:');
FullName2=fullfile(PathName2,FileName2);
if isequal(FileName2,0)
    disp('Selection Cancelled')
    return;
else
    disp(FullName2)
end

%Read input file
canvas=imread(FullName1);
data=imread(FullName2);

%Terminate if DATA bigger than CANVAS
if size(data,1)>size(canvas,1) || size(data,2)>size(canvas,2)
    disp("Data bigger than Canvas");
    return;
end

%Time the Process (tic toc)
tic

%Difference between number of rows/columns in DATA and CANVAS
diffDim1=size(canvas,1)-size(data,1);
diffDim2=size(canvas,2)-size(data,2);

%Make last 4 bits (LSB) of each pixel of CANVAS as 0
emptyCanvas=uint8(bitand(canvas,240,'uint8'));

%Shift first 4 bits (MSB) of each pixel of DATA to last 4 bits
%Also make first 4 bits of each pixel of DATA as 0
readyData=bitsrl(data,4);

%Pad DATA to be of same size as CANVAS
%Pad Method = "POST", Data starts at index (1,1), Right & Bottom Padded
readyData=padarray(readyData,[diffDim1 diffDim2],0,'post');

%Apply OR to readyData and emptyCanvas (Fit MSB of DATA as LSB of CANVAS)
secretImg=uint8(bitor(emptyCanvas,readyData,'uint8'));

%Display the COMBO
%CANVAS MSB is preserved; Hence CANVAS visible
imshow(secretImg);
imwrite(secretImg,'Encoded.png');

toc