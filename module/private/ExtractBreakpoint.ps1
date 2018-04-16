function ExtractBreakpoint
{
    [cmdletbinding()]
    param(
        [parameter(
            ValueFromPipeline
        )]
        [AllowNull()]
        [AllowEmptyString()]
        [string]
        $InputObject
    )

    begin
    {
        $breakpointPattern = 'at .+, (?<Script>.+): line (?<Line>\d+)'
    }

    process
    {
        if (-not [string]::IsNullOrEmpty($InputObject))
        {
            $lineList = $InputObject -split [System.Environment]::NewLine
            foreach($line in $lineList)
            {
                if ($line -match $breakpointPattern)
                {
                    if ($matches.Script -ne '<No file>' -and (Test-Path $matches.Script))
                    {
                        [pscustomobject]@{
                            Script = $matches.Script
                            Line   = $matches.Line
                        }                                
                    }
                }
            }
        }
    }
}
