using namespace System.Collections.Generic

function Install-NpmPackage
{
    param (
        [Parameter()]
        [string]$PackageName,

        [Parameter()]
        [bool]$Global,

        [Parameter()]
        [bool]$Version,

        [Parameter()]
        [string]$Arguments
    )

    $command = [List[string]]::new()
    $command.Add("install")

    if ($Version)
    {
        $command.Add($PackageName + '@' + $Version)
    }
    else
    {
        $command.Add($PackageName)
    }

    if ($Global)
    {
        $command.Add("-g")
    }

    $command.Add($Arguments)

    return Invoke-Npm -command $command
}
