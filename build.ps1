$global:ErrorActionPreference = "Stop"

Get-Item "$PSScriptRoot/scripts/*.psm1" | Import-Module -Force

# Styles
Write-Host "Build CSS"
. "$PSScriptRoot/node_modules/.bin/sass.ps1" `
    "$PSScriptRoot/scss/index.scss" `
    "$PSScriptRoot/dist/index.css" `
    --no-source-map #--watch

# Scripts
Write-Host "Build Scripts"
(
    (Get-Content -Raw "$PSScriptRoot/node_modules/jquery/dist/jquery.js") + "`n" +
    (Get-Content -Raw "$PSScriptRoot/js/jquery.easing.js") + "`n" +
    (Get-Content -Raw "$PSScriptRoot/node_modules/jquery-sticky/jquery.sticky.js") + "`n" +
    (Get-Content -Raw "$PSScriptRoot/node_modules/bootstrap/dist/js/bootstrap.js") + "`n" +
    (Get-Content -Raw "$PSScriptRoot/node_modules/aos/dist/aos.js") + "`n" +
    (Get-Content -Raw "$PSScriptRoot/node_modules/isotope-layout/dist/isotope.pkgd.js") + "`n" +
    (Get-Content -Raw "$PSScriptRoot/node_modules/tiny-slider/dist/tiny-slider.js") + "`n" +
    (Get-Content -Raw "$PSScriptRoot/js/custom.js")
) | Set-Content "$PSScriptRoot/dist/index.js"

. "$PSScriptRoot/node_modules/.bin/minify.ps1" `
    "$PSScriptRoot/dist/index.js" `
    --out-file "$PSScriptRoot/dist/index.min.js"

# Images
Write-Host "Generate Images"
Resize-Image `
    -Source $PSScriptRoot/assets/icon-full.png `
    -Dest $PSScriptRoot/favicon.ico `
    -Height 32 `
    -Format Icon
Resize-Image `
    -Source $PSScriptRoot/assets/logo-full.png `
    -Dest $PSScriptRoot/images/logo-32.png `
    -Height 32

Write-Host "Done"
