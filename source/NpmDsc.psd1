@{
    # Script module or binary module file associated with this manifest.
    RootModule           = 'NpmDsc.psm1'

    # Version number of this module.
    ModuleVersion        = '0.2.0'

    # ID used to uniquely identify this module
    GUID                 = '3f5b94bc-6b26-4263-871d-6226bdc85cea'

    # Author of this module
    Author               = 'Dsc Community'

    # Company or vendor of this module
    CompanyName          = 'Dsc Community'

    # Copyright statement for this module
    Copyright            = 'Copyright the DSC Community contributors. All rights reserved.'

    # Description of the functionality provided by this module
    Description          = 'DSC Resources for managing npm packages.'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion    = '5.0'

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport    = @(
        'Get-InstalledNpmPackages'
        'Install-NpmPackage'
        'Uninstall-NpmPackage'
    )

    # DSC resources to export from this module
    DscResourcesToExport = @(
        'NpmPackage'
        'NpmInstall'
    )

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData          = @{

        PSData = @{

            # Prerelease string of this module
            Prerelease   = 'alpha'

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags         = @('PSDscResource_NpmPackage', 'PSDscResource_NpmInstall')

            # A URL to the license for this module.
            LicenseUri   = 'https://github.com/dsccommunity/NpmDsc/blob/main/LICENSE'

            # A URL to the main website for this project.
            ProjectUri   = 'https://github.com/dsccommunity/NpmDsc'

            # ReleaseNotes of this module
            ReleaseNotes = ''
        } # End of PSData hashtable
    } # End of PrivateData hashtable
}
