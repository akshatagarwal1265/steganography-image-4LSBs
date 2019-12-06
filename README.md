# steganography-image-4LSBs
Using MATLAB to embed the secret-image's each pixel's first 4 MSBs in the cover-image's pixel's last 4 LSBs

## HidePicInPic
* The secret-image (or DATA) is hidden in the cover-image (or CANVAS)
* The DATA's resolution should be lesser-than/equal-to the CANVAS' resolution, Else Terminate
* DATA's first 4 MSBs are embedded in CANVAS' last 4 LSBs
* Therefore, both image's 50% bits are preserved
* Binary operations used to enhance speed

## ReadPicInPic
* The stego-image (or CRYPTED) is used to recover the DATA and the CANVAS
* Binary operations and built-in functions instead of loops - used to enhance speed
