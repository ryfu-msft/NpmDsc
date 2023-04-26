function Assert-Npm
{
    # Refresh session $path value before invoking 'npm'
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    try
    {
        Invoke-Npm -Command 'help'
        return
    }
    catch
    {
        throw "NodeJS is not installed"
    }
}
