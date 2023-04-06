$useNpmCmd = $false
$defaultNpmCmdPath = "$env:ProgramFiles\nodejs\npm.cmd"
function Assert-Npm
{
    # Try invoking npm help with the alias. If it fails, switch to calling npm.cmd directly.
    # This may occur if npm is installed in the same shell window and the alias is not updated until the shell window is restarted.
    try
    {
        Invoke-Npm -command 'help'
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
