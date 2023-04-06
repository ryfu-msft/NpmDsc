function Uninstall-NpmPackage
{
    param (
        [Parameter(Mandatory = $true)]
        [string]$PackageName,

        [Parameter()]
        [bool]$Global,

        [Parameter()]
        [string]$Arguments
    )

    $command = [List[string]]::new()
    $command.Add("uninstall")
    $command.Add($PackageName)

    if ($Global)
    {
        $command.Add('-g')
    }

    $command.Add($Arguments)

    return Invoke-Npm -command $command
}
