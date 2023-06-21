$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$archiveFileName = 'Crushee-v2.4.5-win-portable.zip'
$archiveFilePath = Join-Path -Path $toolsDir -ChildPath $archiveFileName 

$packageArgs = @{
  fileFullPath64 = $archiveFilePath
  destination    = $toolsDir
  packageName    = $env:ChocolateyPackageName
}
Get-ChocolateyUnzip @packageArgs

#Clean up ZIP archive post-extraction to prevent unnecessary disk bloat
Remove-Item -Path $archiveFilePath -Force -ErrorAction SilentlyContinue

$binaryFileName = 'Crushee.exe'
$pp = Get-PackageParameters
if ($pp.NoShim) {
  #Create shim ignore file
  $ignoreFilePath = Join-Path -Path $toolsDir -ChildPath "$binaryFileName.ignore"
  Set-Content -Path $ignoreFilePath -Value $null -ErrorAction SilentlyContinue
}

$linkName = 'Crushee (Portable).lnk'
$targetPath = Join-Path -Path $toolsDir -ChildPath $binaryFileName
if (!$pp.NoDesktopShortcut) {
  $desktopDirectory = [Environment]::GetFolderPath([Environment+SpecialFolder]::DesktopDirectory)
  $shortcutFilePath = Join-Path -Path $desktopDirectory -ChildPath $linkName
  Install-ChocolateyShortcut -ShortcutFilePath $shortcutFilePath -TargetPath $targetPath -ErrorAction SilentlyContinue
}

if (!$pp.NoProgramsShortcut) {
  $programsDirectory = [Environment]::GetFolderPath([Environment+SpecialFolder]::Programs)
  $shortcutFilePath = Join-Path -Path $programsDirectory -ChildPath $linkName
  Install-ChocolateyShortcut -ShortcutFilePath $shortcutFilePath -TargetPath $targetPath -ErrorAction SilentlyContinue
}

if ($pp.Start) {
  #Spawn a separate temporary PowerShell instance to prevent display of debug output
  $statement = "Start-Process -FilePath ""$targetPath"""
  Start-ChocolateyProcessAsAdmin -Statements $statement -NoSleep -ErrorAction SilentlyContinue
}
