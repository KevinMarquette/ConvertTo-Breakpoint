. .\ConvertTo-Breakpoint.ps1

$obj = [pscustomobject]@{
    ScriptStackTrace = @'
at New-Error, C:\workspace\ConvertTo-Breakpoint\testing.ps1: line 2
at Get-Error, C:\workspace\ConvertTo-Breakpoint\testing.ps1: line 6
at <ScriptBlock>, C:\workspace\ConvertTo-Breakpoint\testing.ps1: line 9
'@
}
$obj | ConvertTo-Breakpoint -WhatIf