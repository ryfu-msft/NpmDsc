function Get-InstalledNpmPackages
{
    param (
        [Parameter()]
        [bool]$Global
    )

    $command = [List[string]]::new()
    $command.Add('list')
    $command.Add('--json')

    if ($Global)
    {
        $command.Add('-g')
    }

    Invoke-Npm -command $command
}
