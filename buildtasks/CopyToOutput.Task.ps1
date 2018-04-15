
Task CopyToOutput {

    "  Create Directory [$Destination]"
    $null = New-Item -Type Directory -Path $Destination -ErrorAction Ignore

    Get-ChildItem $source -File |
        where name -NotMatch "$ModuleName\.ps[dm]1" |
        Copy-Item -Destination $Destination -Force -PassThru |
        ForEach-Object { "  Create [.{0}]" -f $_.fullname.replace($PSScriptRoot, '')}

    Get-ChildItem $source -Directory |
        where name -NotIn $imports |
        Copy-Item -Destination $Destination -Recurse -Force -PassThru |
        ForEach-Object { "  Create [.{0}]" -f $_.fullname.replace($PSScriptRoot, '')}
}