function ConvertTo-Breakpoint
{
    <#
        .DESCRIPTION
        Converts an errorrecord to a breakpoint

        .Example
        $error[0] | ConvertTo-Breakpoint

        .Example
        $error[0] | ConvertTo-Breakpoint -All

        .NOTES
        This works the best in the ISE
        VSCode requires the debugger to be running for Set-PSBreakpoint to work
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

    process
    {
        foreach ($node in $ErrorRecord)
        {
            $breakpointList = $node.ScriptStackTrace | ExtractBreakpoint

            foreach ($breakpoint in $breakpointList)
            {
                $message = '{0}:{1}' -f $breakpoint.Script,$breakpoint.Line
                if($PSCmdlet.ShouldProcess($message))
                {
                    Set-PSBreakpoint @breakpoint
                    if (-Not $PSBoundParameters.All)
                    {
                        break
                    }
                }
            }                
        }
    }
}
