
Task UpdateSource {
    Copy-Item $ManifestPath -Destination "$source\$ModuleName.psd1"
}