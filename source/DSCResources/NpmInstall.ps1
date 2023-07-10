using namespace System.Collections.Generic
[DSCResource()]
class NpmInstall
{
    [DscProperty()]
    [Ensure]$Ensure = [Ensure]::Present

    [DscProperty(Key)]
    [string]$SID

    [DscProperty()]
    [bool]$Global

    [DscProperty()]
    [string]$PackageDirectory

    [DscProperty()]
    [string]$Arguments

    [NpmInstall] Get()
    {
        Assert-Npm

        if (-not([string]::IsNullOrEmpty($this.PackageDirectory)))
        {
            Set-PackageDirectory -PackageDirectory $this.PackageDirectory
        }

        $currentState = [NpmInstall]::new()
        $currentState.Ensure = [Ensure]::Present

        $errorResult = Get-InstalledNpmPackages -Global $this.Global | ConvertFrom-Json | Select-Object -ExpandProperty error
        if ($errorResult.PSobject.Properties.Name -contains 'code')
        {
            $errorCode = $errorResult | Select-Object -ExpandProperty code
            if ($errorCode -eq 'ELSPROBLEMS')
            {
                $currentState.Ensure = [Ensure]::Absent
            }
        }

        $currentState.Global = $this.Global
        $currentstate.PackageDirectory = $this.PackageDirectory
        $currentState.Arguments = $this.Arguments
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
                Install-NpmPackage -Arguments $this.Arguments -Global $this.Global
            }
        }
        else
        {
            if (-not $inDesiredState)
            {
                $nodeModulesFolder = 'node_modules'
                if (Test-Path -Path $nodeModulesFolder)
                {
                    Remove-Item $nodeModulesFolder -Recurse
                }
            }
        }
    }
}
