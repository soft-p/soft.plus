function Resize-Image(
    $SourceFile,
    $DestFile,
    $Width = $null,
    $Height = $null,
    $Format = "Png") {

    $sourceImage = [System.Drawing.Image]::FromFile($sourceFile)

    if ($Width) {
        $ratio = [double]$Width / $sourceImage.Width
    }

    if ($Height) {
        $ratio = [double]$Height / $sourceImage.Height
    }

    $destImage = New-Object System.Drawing.Bitmap( `
            $sourceImage, `
            [int]($sourceImage.Width * $ratio), `
            [int]($sourceImage.Height * $ratio))

    if ($Format -eq 'Icon') {
        Save-Icon $image $DestFile
    }
    else {
        $destImage.Save($DestFile, $Format)
    }

    $sourceImage.Dispose();
    $destImage.Dispose();
}

function Save-Icon($image, $DestFile) {
    $icon = [System.Drawing.Icon]::FromHandle($destImage.GetHicon());
    $stream = [System.IO.File]::Create($DestFile)
    $icon.Save($stream);
    $stream.Dispose();
    $icon.Dispose();
}