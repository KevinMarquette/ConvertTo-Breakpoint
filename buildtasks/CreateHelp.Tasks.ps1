TaskX CreateHelp @{
    Partial = $true
    Inputs  = {Get-ChildItem "$ModuleName\Public\*.ps1"}
    Outputs = {
        process
        {
            Get-ChildItem $_ | % {'{0}\{1}.md' -f $HelpRoot, $_.basename}
        }
    }    
    Jobs    = 'ImportModule', {    
        process
        {
            $null = New-Item -Path $HelpRoot -ItemType Directory -ErrorAction SilentlyContinue        
            $mdHelp = @{
                #Module                = $script:ModuleName
                OutputFolder          = $HelpRoot
                AlphabeticParamsOrder = $true
                Verbose               = $true
                Force                 = $true
                Command               = Get-Item $_ | % basename
            }
            New-MarkdownHelp @mdHelp | % fullname
        }    
    }
}
