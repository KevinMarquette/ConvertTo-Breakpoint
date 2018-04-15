
TaskX NextPSGalleryVersion @{
    If     = (-Not ( Test-Path "$output\version.xml" ) ) 
    Before = 'BuildPSD1'
    Jobs   = {
        $galleryVersion = Get-NextPSGalleryVersion -Name $ModuleName
        $galleryVersion | Export-Clixml -Path "$output\version.xml"
    }
}