function ExtractBreakpoint
{
    <#
    .DESCRIPTION
    Parses a script stack trace for breakpoints

    .EXAMPLE
    $error[0].ScriptStackTrace | ExtractBreakpoint
    #>
    [OutputType('System.Collections.Hashtable')]
    [cmdletbinding()]
    param(
        # The ScriptStackTrace
        [parameter(
            ValueFromPipeline
        )]
        [AllowNull()]
        [AllowEmptyString()]
        [Alias('InputObject')]
        [string]
        $ScriptStackTrace
    )

    begin
    {
        $breakpointPattern = 'at .+, (?<Script>.+): line (?<Line>\d+)'
    }

    process
    {
        if (-not [string]::IsNullOrEmpty($ScriptStackTrace))
        {
            $lineList = $ScriptStackTrace -split [System.Environment]::NewLine
            foreach($line in $lineList)
            {
                if ($line -match $breakpointPattern)
                {
                    if ($matches.Script -ne '<No file>' -and 
                        (Test-Path $matches.Script))
                    {
                        @{
                            Script = $matches.Script
                            Line   = $matches.Line
                        }                                
                    }
                }
            }
        }
    }
}
