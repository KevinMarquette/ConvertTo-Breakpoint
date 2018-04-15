function New-Error {
    throw 'this is an error'
}

function Get-Error {
    New-Error
}

Get-Error
