#Manually flip every 8th bit inside of a file. Run it again to unflip the file.

$SourceFile = "./file.zip.txt"
Get-FileHash $SourceFile | Format-List
$FileSize = (Get-Item $SourceFile).length
$SourceBytes = [System.IO.File]::ReadAllBytes($SourceFile)
$BitArray = [System.Collections.BitArray]($SourceBytes)

$bitIndex = 0
for($i=0;$i -le $BitArray.Length;$i++)
{
    $perc = [math]::Round(($i / ($BitArray.Length - 1) * 100) * 100,2)
    Write-Progress -Activity "Flipping every 8th bit inside $SourceFile" -Status 'Progress' -PercentComplete $perc
    $bitIndex++
    if ($bitIndex -eq 8) {
        if($BitArray.Get($i) -eq "True") {
            $BitArray.Set($i, 0)
        } else {
            $BitArray.Set($i, 1)
        }
        $bitIndex = 0
    }
}
$ByteArray = New-Object Byte[] $FileSize
$BitArray.Copyto($ByteArray,0)
[System.IO.File]::WriteAllBytes($SourceFile , $ByteArray)