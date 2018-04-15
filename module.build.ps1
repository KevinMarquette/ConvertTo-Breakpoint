#requires -Modules InvokeBuild, PSDeploy, BuildHelpers, PSScriptAnalyzer, PlatyPS, Pester
$script:ModuleName = 'ConvertTo-Breakpoint'

$script:Source = Join-Path $BuildRoot 'Module'
$script:Output = Join-Path $BuildRoot output
$script:Destination = Join-Path $Output $ModuleName
$script:ModulePath = "$Destination\$ModuleName.psm1"
$script:ManifestPath = "$Destination\$ModuleName.psd1"
$script:Imports = ( 'private', 'public', 'classes' )
$script:TestFile = "$PSScriptRoot\output\TestResults_PS$PSVersion`_$TimeStamp.xml"
$script:HelpRoot = Join-Path $Output 'help'

function TaskX($Name, $Parameters) {task $Name @Parameters -Source $MyInvocation}

Task Default Clean, Build, Pester, UpdateSource, Publish
Task Build CopyToOutput, BuildPSM1, BuildPSD1
Task Pester Build, ImportModule, UnitTests, FullTests
Task Local Build, Pester, UpdateSource

$taskList = Get-ChildItem $PSScriptRoot\BuildTasks\*.Task.ps1

$taskList | ForEach-Object{$_.fullname; . $_}
