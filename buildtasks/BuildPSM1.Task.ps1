

TaskX BuildPSM1 @{
    Inputs  = (Get-Item "$source\*\*.ps1") 
    Outputs = $ModulePath 
    Jobs    = {
        [System.Text.StringBuilder]$stringbuilder = [System.Text.StringBuilder]::new()    
        foreach ($folder in $imports )
        {
            [void]$stringbuilder.AppendLine( "Write-Verbose 'Importing from [$Source\$folder]'" )
            if (Test-Path "$source\$folder")
            {
                $fileList = Get-ChildItem "$source\$folder\*.ps1" | Where Name -NotLike '*.Tests.ps1'
                foreach ($file in $fileList)
                {
                    $shortName = $file.fullname.replace($PSScriptRoot, '')
                    "  Importing [.$shortName]"
                    [void]$stringbuilder.AppendLine( "# .$shortName" ) 
                    [void]$stringbuilder.AppendLine( [System.IO.File]::ReadAllText($file.fullname) )
                }
            }
        }
        
        "  Creating module [$ModulePath]"
        Set-Content -Path  $ModulePath -Value $stringbuilder.ToString() 
    }
}
