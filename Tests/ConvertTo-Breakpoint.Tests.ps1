Describe "function ConvertTo-Breakpoint" {
    Mock Set-PSBreakpoint {return $true}
    It "Does not throw when there is no input" {
        ConvertTo-Breakpoint -ErrorRecord @{ScriptStackTrace=''}
    }

    It "Does not throw" {
        $obj = [pscustomobject]@{
            ScriptStackTrace = @'
at New-Error, C:\workspace\ConvertTo-Breakpoint\testing.ps1: line 2
at Get-Error, C:\workspace\ConvertTo-Breakpoint\testing.ps1: line 6
at <ScriptBlock>, C:\workspace\ConvertTo-Breakpoint\testing.ps1: line 9
'@
        }
        $obj | ConvertTo-Breakpoint
        $obj | ConvertTo-Breakpoint -All
        ConvertTo-Breakpoint $obj
        ConvertTo-Breakpoint -ErrorRecord $obj
        ConvertTo-Breakpoint $obj -All
    }

    It "Does not throw with multiple objects" {
        $obj = [pscustomobject]@{
            ScriptStackTrace = @'
at New-Error, C:\workspace\ConvertTo-Breakpoint\testing.ps1: line 2
at Get-Error, C:\workspace\ConvertTo-Breakpoint\testing.ps1: line 6
at <ScriptBlock>, C:\workspace\ConvertTo-Breakpoint\testing.ps1: line 9
'@
        }
        $array = @($obj,$obj,$obj)
        $array | ConvertTo-Breakpoint
        $array | ConvertTo-Breakpoint -All
        ConvertTo-Breakpoint $array
        ConvertTo-Breakpoint -ErrorRecord $array
        ConvertTo-Breakpoint $array -All
    }
}