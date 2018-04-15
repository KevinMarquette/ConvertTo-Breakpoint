Describe "function ConvertTo-Breakpoint" {
    It "Does not throw when there is no input" {
        ConvertTo-Breakpoint
    }

    It "Does not throw" {
        $obj = [pscustomobject]@{
            ScriptStackTrace = @'
at New-Error, C:\workspace\ConvertTo-Breakpoint\testing.ps1: line 2
at Get-Error, C:\workspace\ConvertTo-Breakpoint\testing.ps1: line 6
at <ScriptBlock>, C:\workspace\ConvertTo-Breakpoint\testing.ps1: line 9
'@
        }
        $obj | ConvertTo-Breakpoint -WhatIf
        $obj | ConvertTo-Breakpoint -WhatIf -All
        ConvertTo-Breakpoint $obj -WhatIf
        ConvertTo-Breakpoint -ErrorRecord $obj -WhatIf
        ConvertTo-Breakpoint $obj -WhatIf -All

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
        $array | ConvertTo-Breakpoint -WhatIf
        $array | ConvertTo-Breakpoint -WhatIf -All
        ConvertTo-Breakpoint $array -WhatIf
        ConvertTo-Breakpoint -ErrorRecord $array -WhatIf
        ConvertTo-Breakpoint $array -WhatIf -All
    }
}