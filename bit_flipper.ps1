# Manually flip every 8th bit inside of a file. Run it again to unflip the file.

$SourceFile = "./test.txt"
Get-FileHash $SourceFile | Format-List
$FileSize = (Get-Item $SourceFile).Length
$SourceBytes = [System.IO.File]::ReadAllBytes($SourceFile)

# The bits will be in reverse order
$BitArray = [System.Collections.BitArray]($SourceBytes)

$bitIndex = 0
# Flip the first bit in each byte which will translate to the last bit in each byte being flipped (because order is reversed)
for($i=0;$i -lt $BitArray.Length;$i++)
{
    if ($bitIndex -eq 0) {
        # If the bit is 0 then set it to 1, else set it to 0
        Write-Host "flipping" $i
        $BitArray.Set($i, $(if ($BitArray.Get($i) -eq 1) { 0 } else { 1 }))
        # Start the bit index at 8 because it gets decremented immediately after
        $bitIndex = 8
    }
    $bitIndex--
}

# Create a new Byte Array that is the size of the file
$ByteArray = New-Object Byte[] $FileSize
# Copy the array of bits to the ByteArray
$BitArray.CopyTo($ByteArray,0)

# Write the new contents to the file
[System.IO.File]::WriteAllBytes($SourceFile , $ByteArray)
