function Install-NpmPackage
{
    param (
        [Parameter()]
        [string]$PackageName,

        [Parameter()]
        [bool]$Global,

        [Parameter()]
        [string]$Arguments
    )

    $command = [List[string]]::new()
    $command.Add("install")
    $command.Add($PackageName)

    if ($Global)
    {
        $command.Add("-g")
    }

    $command.Add($Arguments)

    return Invoke-Npm -command $command
}
