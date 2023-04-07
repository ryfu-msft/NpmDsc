$useNpmCmd = $false
$defaultNpmCmdPath = "$env:ProgramFiles\nodejs\npm.cmd"
function Assert-Npm
{
    # Try calling Start-Process with 'npm help' using the alias. If it fails, switch to calling npm.cmd directly.
    # This may occur if npm is installed in the same shell window and the alias is not updated until the shell window is restarted.
    try
    {
        Start-Process -FilePath npm -ArgumentList 'help' -Wait -PassThru -WindowStyle hidden
        return
    }
    catch
    {
        Write-Debug "Failed to invoke npm alias."
    }

    $useNpmCmd = Test-Path -Path $defaultNpmCmdPath
    if ($useNpmCmd)
    {
        Write-Output "Calling npm.cmd directly located at: $defaultNpmCmdPath"
    }
    else
    {
        throw "NodeJS is not installed"
    }
}
