# Description:
# Iterates over every single bit in the file and flips every 8th bit. Run it again to reverse the process.

####################################
$SourceFile = "./test.txt"
####################################

$beforeFileHash = (Get-FileHash $SourceFile).Hash
$FileSize = (Get-Item $SourceFile).Length
$SourceBytes = [System.IO.File]::ReadAllBytes($SourceFile)

# The bits will be in reverse order
$BitArray = [System.Collections.BitArray]($SourceBytes)

$bitIndex = 0
# Iterate over each bit and flip the first bit every 8 bits. This will result in the last bit in each byte being flipped (because order is reversed)
Write-Host "Now flipping every 8th bit in" $BitArray.Length "bits. Please wait..."
for($i=0;$i -lt $BitArray.Length;$i++)
{
    if ($bitIndex -eq 0) {
        # If the bit is 0 then set it to 1, else set it to 0
        $BitArray.Set($i, $(if ($BitArray.Get($i) -eq 1) { 0 } else { 1 }))
        # Start the bit index at 8 because it gets decremented immediately after
        $bitIndex = 8
    }
    $bitIndex--
}
Write-Host "Finished."
# Create a new Byte Array that is the size of the file
$ByteArray = New-Object Byte[] $FileSize
# Copy the array of bits to the ByteArray
$BitArray.CopyTo($ByteArray,0)

# Write the new contents to the file
[System.IO.File]::WriteAllBytes($SourceFile , $ByteArray)

Write-Host "File Hash Before: " $beforeFileHash
$afterFileHash = (Get-FileHash $SourceFile).Hash
Write-Host "File Hash After: " $afterFileHash
