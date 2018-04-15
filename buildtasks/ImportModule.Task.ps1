Task ImportModule {
    if ( -Not ( Test-Path $ManifestPath ) )
    {
        "  Modue [$ModuleName] is not built, cannot find [$ManifestPath]"
        Write-Error "Could not find module manifest [$ManifestPath]. You may need to build the module first"
    }
    else
    {
        if (Get-Module $ModuleName)
        {
            "  Unloading Module [$ModuleName] from previous import"
            Remove-Module $ModuleName
        }
        "  Importing Module [$ModuleName] from [$ManifestPath]"
        Import-Module $ManifestPath -Force
    }
}