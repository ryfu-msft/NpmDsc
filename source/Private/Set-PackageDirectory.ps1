function Set-PackageDirectory
{
    param (
        [Parameter(Mandatory = $true)]
        [string]$PackageDirectory
    )

    if (Test-Path -Path $PackageDirectory -PathType Container)
    {
        Set-Location -Path $PackageDirectory
    }
    else
    {
        throw "$($PackageDirectory) does not point to a valid directory."
    }
}
