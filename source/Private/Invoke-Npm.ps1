function Invoke-Npm
{
    param (
        [Parameter(Mandatory = $true)]
        [string]$Command
    )

    return Invoke-Expression -Command "npm $Command"
}
