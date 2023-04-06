function Invoke-Npm
{
    param (
        [Parameter(Mandatory = $true)]
        [string]$Command
    )

    if ($useNpmCmd)
    {
        return & $defaultNpmCmdPath $Command
    }
    else
    {
        return npm $Command
    }
}
