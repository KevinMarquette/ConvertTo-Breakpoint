Task Clean {
    
    If (Test-Path $Output)
    {
        $null = Remove-Item $Output -Recurse -ErrorAction Ignore
    }
    $null = New-Item  -Type Directory -Path $Destination -ErrorAction Ignore
}
