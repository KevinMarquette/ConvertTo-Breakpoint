$moduleName = 'ConvertTo-Breakpoint'

Describe "Help tests for $moduleName" -Tags Build {

    $functions = Get-Command -Module $moduleName
    $help = $functions | ForEach-Object {Get-Help $_.name}
    foreach ($node in $help)
    {
        Context $node.name {

            it "has a description" {
                $node.description | Should -Not -BeNullOrEmpty -Because 'Every public function should have a description'
            }
            it "has an example" {
                $node.examples | Should -Not -BeNullOrEmpty -Because 'Every public function should have an example'
            }
            foreach ($parameter in $node.parameters.parameter)
            {
                if ($parameter -notmatch 'whatif|confirm')
                {
                    it "parameter $($parameter.name) has a description" {
                        $parameter.Description.text | Should -Not -BeNullOrEmpty -Because 'Every public function parameter should have a description'
                    }
                }
            }
        }
    }
}

