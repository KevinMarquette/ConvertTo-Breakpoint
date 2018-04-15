
TaskX BuildPSD1 @{
    Inputs  = (Get-ChildItem $Source -Recurse -File) 
    Outputs = $ManifestPath 
    Jobs    = {
    
        Write-Output "  Update [$ManifestPath]"
        Copy-Item "$source\$ModuleName.psd1" -Destination $ManifestPath


        $functions = Get-ChildItem "$source\Public\*.ps1" | Where-Object { $_.name -notmatch 'Tests'} | Select-Object -ExpandProperty basename      
        Set-ModuleFunctions -Name $ManifestPath -FunctionsToExport $functions

        Write-Output "  Detecting semantic versioning"

        Import-Module $source\$ModuleName.psd1
        $commandList = Get-Command -Module $ModuleName
        Remove-Module $ModuleName

        Write-Output "    Calculating fingerprint"
        $fingerprint = foreach ($command in $commandList )
        {
            foreach ($parameter in $command.parameters.keys)
            {
                '{0}:{1}' -f $command.name, $command.parameters[$parameter].Name
                $command.parameters[$parameter].aliases | Foreach-Object { '{0}:{1}' -f $command.name, $_}
            }
        }
        
        $fingerprint = $fingerprint | Sort-Object

        if (Test-Path .\fingerprint)
        {
            $oldFingerprint = Get-Content .\fingerprint
        }
        
        $bumpVersionType = 'Patch'
        '    Detecting new features'
        $fingerprint | Where {$_ -notin $oldFingerprint } | % {$bumpVersionType = 'Minor'; "      $_"}    
        '    Detecting breaking changes'
        $oldFingerprint | Where {$_ -notin $fingerprint } | % {$bumpVersionType = 'Major'; "      $_"}

        Set-Content -Path .\fingerprint -Value $fingerprint

        # Bump the module version
        $version = [version] (Get-Metadata -Path $manifestPath -PropertyName 'ModuleVersion')

        if ( $version -lt ([version]'1.0.0') )
        {
            # Still in beta, don't bump major version
            if ( $bumpVersionType -eq 'Major'  )
            {
                $bumpVersionType = 'Minor'
            }
            else 
            {
                $bumpVersionType = 'Patch'
            }       
        }

        $galleryVersion = Import-Clixml -Path "$output\version.xml"
        if ( $version -lt $galleryVersion )
        {
            $version = $galleryVersion
        }
        Write-Output "  Stepping [$bumpVersionType] version [$version]"
        $version = [version] (Step-Version $version -Type $bumpVersionType)
        Write-Output "  Using version: $version"
        
        Update-Metadata -Path $ManifestPath -PropertyName ModuleVersion -Value $version
    }
}