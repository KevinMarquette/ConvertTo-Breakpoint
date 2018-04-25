Describe "function ConvertTo-Breakpoint" {
    Mock Set-PSBreakpoint {return $true}
    It "Does not throw when there is no input" {
        ConvertTo-Breakpoint -ErrorRecord @{InvocationInfo=''}
    }

    It "Does not throw" {
        $obj = [pscustomobject]@{
            InvocationInfo = [pscustomobject]@{
                ScriptLineNumber = 2
                ScriptName = "C:\workspace\ConvertTo-Breakpoint\testing.ps1" 
            }
        }
        $obj | ConvertTo-Breakpoint
        $obj | ConvertTo-Breakpoint -All
        ConvertTo-Breakpoint $obj
        ConvertTo-Breakpoint -ErrorRecord $obj
        ConvertTo-Breakpoint $obj -All
    }

    It "Does not throw with multiple objects" {
        $obj = [pscustomobject]@{
            InvocationInfo = [PSCustomObject]@{
                ScriptLineNumber = 2
                ScriptName = "C:\workspace\ConvertTo-Breakpoint\testing.ps1" 
            }
        }
        $array = @($obj,$obj,$obj)
        $array | ConvertTo-Breakpoint
        $array | ConvertTo-Breakpoint -All
        ConvertTo-Breakpoint $array
        ConvertTo-Breakpoint -ErrorRecord $array
        ConvertTo-Breakpoint $array -All
    }
}