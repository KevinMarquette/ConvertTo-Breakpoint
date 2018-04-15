function ConvertTo-Breakpoint
{
    <#
        .DESCRIPTION
        Converts an errorrecord to a breakpoint

        .Example 
        $error[0] | ConvertTo-Breakpoint

        .Example 
        $error[0] | ConvertTo-Breakpoint -All
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        # The error record
        [parameter(
            Mandatory,
            Position = 0,
            ValueFromPipeline
        )]
        [Alias('InputObject')]
        $ErrorRecord,

        # Sets breakpoints on the entire stack
        [switch]
        $All
    )
    begin
    {
        $breakpointPattern = 'at .+, (?<Script>.+): line (?<Line>\d+)'
    }
    process
    {
        foreach($node in $ErrorRecord)
        {
            $trace = $node.ScriptStackTrace
            if(-not [string]::IsNullOrEmpty($trace))
            {
                $lineList = $trace -split [System.Environment]::NewLine
                foreach($line in $lineList)
                {
                    if($line -match $breakpointPattern)
                    {
                        if($PSCmdlet.ShouldProcess($line))
                        {
                            $breakpoint = @{
                                Script = $matches.Script
                                Line = $matches.Line
                            }
                            Set-PSBreakpoint @breakpoint
                        }
                        if(-Not $PSBoundParameters.All)
                        {
                            break
                        }
                    }
                }
            }
         }
    }
}
