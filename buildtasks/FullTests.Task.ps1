
Task FullTests {
    $TestResults = Invoke-Pester -Path Tests -PassThru -OutputFormat NUnitXml -OutputFile $testFile -Tag Build
    if ($TestResults.FailedCount -gt 0)
    {
        Write-Error "Failed [$($TestResults.FailedCount)] Pester tests"
    }
}
