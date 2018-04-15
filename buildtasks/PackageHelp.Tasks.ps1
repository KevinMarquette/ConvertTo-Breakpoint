TaskX PackageHelp  @{
    Inputs  = {Get-ChildItem $HelpRoot -Recurse -File}
    Outputs = "$Destination\en-us\$ModuleName-help.xml"
    Jobs    = 'CreateHelp', {
        New-ExternalHelp -Path $HelpRoot -OutputPath "$Destination\en-us" -force | % fullname
    }
}
