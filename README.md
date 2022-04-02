# Introduction
Does your file keep getting blocked during file transfer? Is it impossible to install new software but Powershell scripting is available? Introducing the powershell bit flipper: the last resort for attempting to bypass useless security protocols. 

# Powershell Bit Flipper
1. Add .txt extension to any filename, thereby making it text. 
2. Put this script inside that same directory and set the $SourceFile to that file name.
3. Run the script and wait for it to process.
4. Transfer the file through and see if it bypasses security limitations.
5. Run this script again exactly the same way to unflip the bit thereby showing the real file contents.
6. Remove the .txt extension on the end of the file name.

# TODO:

Improve Performance

1. Instead of processing every bit one at a time, find a way to create a bit mask and do one gigantic -bxor operation. This should greatly improve the performance of the bit flipping operation.
