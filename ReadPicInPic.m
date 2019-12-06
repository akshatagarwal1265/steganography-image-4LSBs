%Reading a previously Crypted Pic

%Getting Crypted Image from User Via Dialog Box
[FileName,PathName]=uigetfile({'*.jpg;*.jpeg;*.png;*.tif','Acceptable Types'},...
    'Select the "jpg", "jpeg", "png" or "tif" file to be Decrypted:');
FullName=fullfile(PathName,FileName);
if isequal(FileName,0)
    disp('Selection Cancelled')
    return;
else
    disp(FullName)
end

%Read input file
crypted=imread(FullName);

%Time the Process (tic toc)
tic

%Make last 4 bits (LSB) of each pixel of Crypted as 0
canvas=uint8(bitand(crypted,240,'uint8'));

%Shift last 4 bits (MSB) of each pixel of Crypted to first 4 bits
%Also make last 4 bits of each pixel of Crypted as 0
hiddenMsg=bitsll(crypted,4);

%Find first/last non zero Column
nonZeroColumns = any(hiddenMsg(:,:,1),1).*any(hiddenMsg(:,:,2),1).*any(hiddenMsg(:,:,3),1);
firstNonZeroColumn = find(nonZeroColumns,1,'first');
lastNonZeroColumn = find(nonZeroColumns,1,'last');

%Find first/last non zero Row
nonZeroRows = any(hiddenMsg(:,:,1),2).*any(hiddenMsg(:,:,2),2).*any(hiddenMsg(:,:,3),2);
firstNonZeroRow = find(nonZeroRows,1,'first');
lastNonZeroRow = find(nonZeroRows,1,'last');

%Removing Bordering Zeros
hiddenMsg(1:firstNonZeroRow-1,:,:)=[];
hiddenMsg(lastNonZeroRow+1:end,:,:)=[];
hiddenMsg(:,1:firstNonZeroColumn-1,:)=[];
hiddenMsg(:,lastNonZeroColumn+1:end,:)=[];

%Display the Canvas
imshow(canvas)
imwrite(canvas,'Canvas.png');

%Display the Hidden Message
figure;imshow(hiddenMsg)
imwrite(hiddenMsg,'Hidden.png');

toc