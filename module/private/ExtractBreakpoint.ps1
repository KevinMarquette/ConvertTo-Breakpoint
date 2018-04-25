function ExtractBreakpoint
{
    <#
    .DESCRIPTION
    Extracts line number and scriptname for breakpoints

    .EXAMPLE
    $error[0].InvocationInfo | ExtractBreakpoint
    #>
    [OutputType('System.Collections.Hashtable')]
    [cmdletbinding()]
    param(
        # The InvocationInfo
        [parameter(
            ValueFromPipeline
        )]
        [AllowNull()]
        [AllowEmptyString()]
        [Alias('InputObject')]
        $InvocationInfo
    )

    process
    {
        if (-not [string]::IsNullOrEmpty($InvocationInfo.ScriptName) -and 
            (Test-Path $InvocationInfo.ScriptName))
        {
            @{
                Script = $InvocationInfo.ScriptName
                Line   = $InvocationInfo.ScriptLineNumber
            }                                
        }       
    }
}
