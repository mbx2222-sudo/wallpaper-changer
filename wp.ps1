param([string]$Url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKy_Ya8vfR2Kd6J2fGAf7yDlhK1gtO9hvA2xpGwa4w4Q&s')
$dest = Join-Path $env:USERPROFILE 'Pictures\wp.jpg'
Invoke-WebRequest -Uri $Url -OutFile $dest -UseBasicParsing
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name WallpaperStyle -Value '10'
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name TileWallpaper -Value '0'
Add-Type -TypeDefinition @'
using System.Runtime.InteropServices;
public class Wallpaper {
  [DllImport("user32.dll", CharSet = CharSet.Auto)]
  public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
'@
[Wallpaper]::SystemParametersInfo(20, 0, $dest, 3) | Out-Null
