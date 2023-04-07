function Invoke-Npm
{
    param (
        [Parameter(Mandatory = $true)]
        [string]$Command
    )

    if ($useNpmCmd)
    {
        return Invoke-Expression -Command "& '$defaultNpmCmdPath' $Command"
    }
    else
    {
        return Invoke-Expression -Command "npm $Command"
    }
}
