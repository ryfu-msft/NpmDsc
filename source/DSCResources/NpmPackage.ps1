[DSCResource()]
class NpmPackage
{
    [DscProperty()]
    [Ensure]$Ensure = [Ensure]::Present

    [DscProperty(Key)]
    [string]$Name

    [DscProperty()]
    [string]$Version

    [DscProperty()]
    [string]$PackageDirectory

    [DscProperty()]
    [bool]$Global

    [DscProperty()]
    [string]$Arguments

    [NpmPackage] Get()
    {
        Assert-Npm

        if (-not([string]::IsNullOrEmpty($this.PackageDirectory)))
        {
            Set-PackageDirectory -PackageDirectory $this.PackageDirectory
        }

        $currentState = [NpmPackage]::new()
        $currentState.Ensure = [Ensure]::Absent

        $installedPackages = Get-InstalledNpmPackages -Global $this.Global | ConvertFrom-Json | Select-Object -ExpandProperty dependencies
        if ($installedPackages.PSobject.Properties.Name -contains $this.Name)
        {
            $installedPackage = $installedPackages | Select-Object -ExpandProperty $this.Name

            # Check if version matches if specified.
            if (-not([string]::IsNullOrEmpty($this.Version)))
            {
                $installedVersion = $installedPackage.Version
                if ([System.Version]$installedVersion -eq [System.Version]$this.Version)
                {
                    $currentState.Ensure = [Ensure]::Present
                }
            }
            else
            {
                $currentState.Ensure = [Ensure]::Present
            }
        }

        $currentState.Name = $this.Name
        $currentState.Version = $this.Version
        $currentState.Global = $this.Global
        $currentState.Arguments = $this.Arguments
        $currentState.PackageDirectory = $this.PackageDirectory
        return $currentState
    }

    [bool] Test()
    {
        $currentState = $this.Get()
        return $this.Ensure -eq $currentState.Ensure
    }

    [void] Set()
    {
        $inDesiredState = $this.Test()
        if ($this.Ensure -eq [Ensure]::Present)
        {
            if (-not $inDesiredState)
            {
                Install-NpmPackage -PackageName $this.Name -Version $this.Version -Arguments $this.Arguments -Global $this.Global
            }
        }
        else
        {
            if (-not $inDesiredState)
            {
                Uninstall-NpmPackage -PackageName $this.Name -Arguments $this.Arguments -Global $this.Global
            }
        }
    }
}
