<# 
CYBER-THEMED VISUAL DEMO (SAFE)
- Visual-only "movie terminal" + demo restart + demo BSOD
- Does NOT touch files, does NOT encrypt anything, does NOT read your disk, no network
- Press ESC any time to exit

Note: I can't help make a script that convincingly tells someone they're hacked or simulates ransomware.
This is a clearly-labeled demo for your own PC / content creation / training.
#>

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase

# ---------------- QR (embedded) ----------------
$QrBase64 = @'
iVBORw0KGgoAAAANSUhEUgAABIMAAASDCAIAAABlaWigAAAABmJLR0QA/wD/AP+gvaeTAAAdiElEQVR4
nO3dS47jSBaA4c7//2x2sQwQm2iQd8mE5lBq0mGq3GJc6b2u9f7qHfYqk9c0yqz7v1v6c3c0AAAAA
[...snip...]
AAAAwF9HiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQY
AABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAA
QE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBN
iQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkB
AADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA
1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSU
GAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgA
AEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABA
TYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2J
AQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEA
ANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADU
lBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQY
AABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAA
QE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBN
iQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkB
AADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA
1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSU
GAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgA
AEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABA
TYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2J
AQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEA
ANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADU
lBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQY
AABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAA
QE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBN
iQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkB
AADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA
1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSU
GAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgA
AEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABA
TYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2J
AQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEA
ANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADU
lBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQY
AABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAA
QE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBN
iQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkB
AADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA
1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSU
GAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgA
AEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABA
TYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2J
AQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEA
ANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADU
lBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQY
AABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAA
QE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBN
iQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkB
AADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA
1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSU
GAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgA
AEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABA
TYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2J
AQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEA
ANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADU
lBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQY
AABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAA
QE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBN
iQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkB
AADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA
1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSU
GAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgA
AEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABA
TYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2J
AQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEA
ANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADU
lBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQY
AABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAA
QE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBN
iQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkB
AADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA
1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSU
GAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgA
AEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABA
TYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2J
AQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEA
ANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADU
lBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQY
AABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAA
QE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBN
iQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkB
AADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA
1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSU
GAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgA
AEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABA
TYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2J
AQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEA
ANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADU
lBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQY
AABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAA
QE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBN
iQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkB
AADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA
1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSU
GAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgA
AEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABA
TYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2J
AQAA1JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADUlBgAAEBNiQEA
'@

function New-BitmapFromBase64([string]$b64) {
    $clean = $b64 -replace "\s",""
    $bytes = [Convert]::FromBase64String($clean)
    $ms = New-Object System.IO.MemoryStream(,$bytes)
    $bmp = New-Object Windows.Media.Imaging.BitmapImage
    $bmp.BeginInit()
    $bmp.CacheOption = [Windows.Media.Imaging.BitmapCacheOption]::OnLoad
    $bmp.StreamSource = $ms
    $bmp.EndInit()
    $bmp.Freeze()
    $ms.Dispose()
    return $bmp
}

function Stamp { (Get-Date).ToString("HH:mm:ss.fff") }
function RHex([int]$len=8){ -join ((1..$len) | ForEach-Object { "{0:X}" -f (Get-Random -Min 0 -Max 16) }) }

function Trim-Textbox([Windows.Controls.TextBox]$Box, [int]$KeepLast=900) {
    if ($Box.LineCount -gt 1200) {
        $lines = $Box.Text -split "`r`n"
        if ($lines.Count -gt $KeepLast) {
            $Box.Text = ($lines[-$KeepLast..-1] -join "`r`n")
            $Box.CaretIndex = $Box.Text.Length
            $Box.ScrollToEnd()
        }
    }
}

$script:termWin = $null
$script:restartWin = $null
$script:bsodWin = $null

function Close-All {
    foreach ($w in @($script:bsodWin, $script:restartWin, $script:termWin)) {
        try { if ($w -and $w.IsVisible) { $w.Close() } } catch {}
    }
}

# ---------------- 1) Fake CMD-style demo window ----------------
$term = New-Object Windows.Window
$script:termWin = $term
$term.WindowStyle = 'None'
$term.ResizeMode = 'NoResize'
$term.Topmost = $true
$term.WindowState = 'Maximized'
$term.Background = [Windows.Media.Brushes]::Black
$term.Title = "Command Prompt"
$term.Cursor = [System.Windows.Input.Cursors]::Arrow

$g = New-Object Windows.Controls.Grid
$g.Margin = "18"
$term.Content = $g

$r1 = New-Object Windows.Controls.RowDefinition; $r1.Height = "9*"
$r2 = New-Object Windows.Controls.RowDefinition; $r2.Height = "1*"
$g.RowDefinitions.Add($r1) | Out-Null
$g.RowDefinitions.Add($r2) | Out-Null

$cmd = New-Object Windows.Controls.TextBox
$cmd.IsReadOnly = $true
$cmd.BorderThickness = 0
$cmd.Background = [Windows.Media.Brushes]::Black
$cmd.Foreground = [Windows.Media.Brushes]::White
$cmd.FontFamily = "Consolas"
$cmd.FontSize = 16
$cmd.VerticalScrollBarVisibility = "Hidden"
$cmd.HorizontalScrollBarVisibility = "Hidden"
$cmd.TextWrapping = "NoWrap"
[Windows.Controls.Grid]::SetRow($cmd, 0)
$g.Children.Add($cmd) | Out-Null

$bottom = New-Object Windows.Controls.Grid
[Windows.Controls.Grid]::SetRow($bottom, 1)
$g.Children.Add($bottom) | Out-Null

$sim = New-Object Windows.Controls.TextBlock
$sim.Text = "DEMO / SIMULATION - NO FILES TOUCHED"
$sim.FontFamily = "Consolas"
$sim.FontSize = 12
$sim.Foreground = (New-Object Windows.Media.SolidColorBrush([Windows.Media.Color]::FromArgb(150,255,255,255)))
$sim.HorizontalAlignment = "Right"
$sim.VerticalAlignment = "Center"
$sim.Margin = "0,0,4,0"
$bottom.Children.Add($sim) | Out-Null

$status = New-Object Windows.Controls.TextBlock
$status.Text = "Press ENTER to start. ESC to exit."
$status.FontFamily = "Consolas"
$status.FontSize = 12
$status.Foreground = (New-Object Windows.Media.SolidColorBrush([Windows.Media.Color]::FromArgb(200,255,255,255)))
$status.HorizontalAlignment = "Left"
$status.VerticalAlignment = "Center"
$status.Margin = "4,0,0,0"
$bottom.Children.Add($status) | Out-Null

function Cmd-AddLine([string]$s) {
    $cmd.AppendText($s + "`r`n")
    $cmd.ScrollToEnd()
}

$hostName = $env:COMPUTERNAME
$userName = $env:USERNAME

Cmd-AddLine "Microsoft Windows [Version 10.0.$(Get-Random -Min 19041 -Max 26100).$(Get-Random -Min 1 -Max 9999)]"
Cmd-AddLine "(c) Microsoft Corporation. All rights reserved."
Cmd-AddLine ""
Cmd-AddLine "C:\Users\$userName> echo DEMO / SIMULATION - NO FILES TOUCHED"
Cmd-AddLine "DEMO / SIMULATION - NO FILES TOUCHED"
Cmd-AddLine ""
Cmd-AddLine "C:\Users\$userName> whoami"
Cmd-AddLine "$hostName\$userName"
Cmd-AddLine ""
Cmd-AddLine "C:\Users\$userName> cd \Windows\System32"
Cmd-AddLine "C:\Windows\System32>"

$script:started = $false
$script:phase = "idle"

$verbs = @("Indexing","Profiling","Tracing","Mapping","Inspecting","Correlating","Verifying","Cataloging","Diffing","Linking","Staging","Auditing")
$targets = @("process table","loaded modules","event stream","device graph","policy store","network stack (simulated)","driver set","services","scheduled tasks","memory map (simulated)")
$results = @("OK","OK","OK","WARN","OK","OK","OK","WARN","OK","OK")

$script:demoTimer = New-Object Windows.Threading.DispatcherTimer
$script:demoTimer.Interval = [TimeSpan]::FromMilliseconds(35)
$script:linesLeft = 380

$term.Add_KeyDown({
    param($sender, $e)
    if ($e.Key -eq 'Escape') { Close-All; return }

    if (-not $script:started -and $e.Key -eq 'Enter') {
        $script:started = $true
        $script:phase = "running"
        $status.Text = "Running demo... (ESC to exit)"
        Cmd-AddLine ""
        Cmd-AddLine (("C:\Windows\System32> democtl --mode training --session {0}" -f (RHex 8)))
        Cmd-AddLine (("[{0}] Session opened (SIMULATION)" -f (Stamp)))
        Cmd-AddLine (("[{0}] No files will be accessed or modified." -f (Stamp)))
        Cmd-AddLine ""
        $script:demoTimer.Start()
        return
    }

    if ($script:phase -eq "prompt" -and $e.Key -eq 'R') {
        $script:phase = "restart"
        try { if ($script:promptTimer) { $script:promptTimer.Stop() } } catch {}
        $status.Text = "Restarting (demo)..."
        $term.Hide()
        $script:restartWin.Show()
        return
    }
})

$script:demoTimer.Add_Tick({
    if ($script:phase -ne "running") { return }

    $n = Get-Random -Min 6 -Max 14
    1..$n | ForEach-Object {
        if ($script:linesLeft -le 0) { return }
        $script:linesLeft--

        $v = $verbs | Get-Random
        $t = $targets | Get-Random
        $r = $results | Get-Random
        $id = RHex 6
        Cmd-AddLine (("[{0}] {1} {2}  id={3}  {4}" -f (Stamp), $v, $t, $id, $r))

        if ((Get-Random -Min 1 -Max 28) -eq 1) {
            Cmd-AddLine (("[{0}] checkpoint saved  token={1}  (SIMULATION)" -f (Stamp), (RHex 10)))
        }
    }
    Trim-Textbox $cmd 950

    $done = 380 - $script:linesLeft
    $pct = [Math]::Floor(($done / 380.0) * 100)
    $status.Text = ("Running demo... {0}%  ESC to exit" -f $pct)

    if ($script:linesLeft -le 0) {
        $script:demoTimer.Stop()
        Cmd-AddLine ""
        Cmd-AddLine (("[{0}] Demo pass complete. (SIMULATION)" -f (Stamp)))
        Cmd-AddLine (("[{0}] Displaying restart flow (SIMULATION)." -f (Stamp)))
        Cmd-AddLine ""
        Cmd-AddLine "C:\Windows\System32> restartctl --prompt"
        Cmd-AddLine "Restart now? (R) Restart   (ESC) Exit"
        $script:phase = "prompt"
        $status.Text = "Press R to show demo restart (auto in 6s). ESC to exit."

        $script:promptTimer = New-Object Windows.Threading.DispatcherTimer
        $script:promptTimer.Interval = [TimeSpan]::FromSeconds(6)
        $script:promptTimer.Add_Tick({
            $script:promptTimer.Stop()
            if ($script:phase -eq "prompt") {
                $script:phase = "restart"
                $status.Text = "Restarting (demo)..."
                $term.Hide()
                $script:restartWin.Show()
            }
        })
        $script:promptTimer.Start()
    }
})

# ---------------- 2) Fake "Restarting..." screen ----------------
$restart = New-Object Windows.Window
$script:restartWin = $restart
$restart.WindowStyle = 'None'
$restart.ResizeMode = 'NoResize'
$restart.Topmost = $true
$restart.WindowState = 'Maximized'
$restart.Background = [Windows.Media.Brushes]::Black
$restart.Title = "Restarting"
$restart.Cursor = [System.Windows.Input.Cursors]::None

$rg = New-Object Windows.Controls.Grid
$restart.Content = $rg

$rt = New-Object Windows.Controls.TextBlock
$rt.Foreground = [Windows.Media.Brushes]::White
$rt.FontFamily = "Segoe UI"
$rt.FontSize = 34
$rt.Text = "Restarting"
$rt.HorizontalAlignment = "Center"
$rt.VerticalAlignment = "Center"
$rg.Children.Add($rt) | Out-Null

$rSim = New-Object Windows.Controls.TextBlock
$rSim.Text = "DEMO / SIMULATION"
$rSim.FontFamily = "Consolas"
$rSim.FontSize = 12
$rSim.Foreground = (New-Object Windows.Media.SolidColorBrush([Windows.Media.Color]::FromArgb(120,255,255,255)))
$rSim.HorizontalAlignment = "Right"
$rSim.VerticalAlignment = "Bottom"
$rSim.Margin = "0,0,10,10"
$rg.Children.Add($rSim) | Out-Null

$restart.Add_KeyDown({
    param($sender, $e)
    if ($e.Key -eq 'Escape') { Close-All }
})

$script:restartDotsTimer = New-Object Windows.Threading.DispatcherTimer
$script:restartDotsTimer.Interval = [TimeSpan]::FromMilliseconds(320)
$script:dots = 0

$script:restartOneShot = New-Object Windows.Threading.DispatcherTimer
$script:restartOneShot.Interval = [TimeSpan]::FromMilliseconds(2400)

$restart.Add_ContentRendered({
    $script:dots = 0
    $rt.Text = "Restarting"
    $script:restartDotsTimer.Start()
    $script:restartOneShot.Start()
})

$script:restartDotsTimer.Add_Tick({
    $script:dots = ($script:dots + 1) % 4
    $rt.Text = "Restarting" + ("." * $script:dots)
})

$script:restartOneShot.Add_Tick({
    $script:restartOneShot.Stop()
    $script:restartDotsTimer.Stop()
    $restart.Hide()
    $script:bsodWin.Show()
})

# ---------------- 3) Demo BSOD with your QR + delayed hint ----------------
$bsod = New-Object Windows.Window
$script:bsodWin = $bsod
$bsod.WindowStyle = 'None'
$bsod.ResizeMode = 'NoResize'
$bsod.Topmost = $true
$bsod.WindowState = 'Maximized'
$bsod.Background = (New-Object Windows.Media.SolidColorBrush([Windows.Media.Color]::FromRgb(0,120,215)))
$bsod.Title = " "
$bsod.ShowInTaskbar = $false
$bsod.Cursor = [System.Windows.Input.Cursors]::None

$bg = New-Object Windows.Controls.Grid
$bg.Margin = "90,70,90,70"
$bsod.Content = $bg

$col1 = New-Object Windows.Controls.ColumnDefinition; $col1.Width = "3*"
$col2 = New-Object Windows.Controls.ColumnDefinition; $col2.Width = "2*"
$bg.ColumnDefinitions.Add($col1) | Out-Null
$bg.ColumnDefinitions.Add($col2) | Out-Null

$left = New-Object Windows.Controls.StackPanel
$left.Orientation = "Vertical"
$left.VerticalAlignment = "Top"
$left.HorizontalAlignment = "Left"
[Windows.Controls.Grid]::SetColumn($left, 0)
$bg.Children.Add($left) | Out-Null

$face = New-Object Windows.Controls.TextBlock
$face.Foreground = [Windows.Media.Brushes]::White
$face.FontFamily = "Segoe UI"
$face.FontSize = 86
$face.Text = ":("
$left.Children.Add($face) | Out-Null

$main = New-Object Windows.Controls.TextBlock
$main.Foreground = [Windows.Media.Brushes]::White
$main.FontFamily = "Segoe UI"
$main.FontSize = 28
$main.TextWrapping = "Wrap"
$main.Margin = "0,12,0,0"
$main.Text = @"
Your PC ran into a problem and needs to restart.
We're just collecting some error info, and then we'll restart for you.
"@.TrimEnd()
$left.Children.Add($main) | Out-Null

$prog = New-Object Windows.Controls.TextBlock
$prog.Foreground = [Windows.Media.Brushes]::White
$prog.FontFamily = "Segoe UI"
$prog.FontSize = 26
$prog.Margin = "0,18,0,0"
$prog.Text = "0% complete"
$left.Children.Add($prog) | Out-Null

$more = New-Object Windows.Controls.TextBlock
$more.Foreground = [Windows.Media.Brushes]::White
$more.FontFamily = "Segoe UI"
$more.FontSize = 18
$more.Margin = "0,18,0,0"
$more.TextWrapping = "Wrap"
$more.Text = "For more information about this issue and possible fixes, visit https://www.windows.com/stopcode"
$left.Children.Add($more) | Out-Null

$stop = New-Object Windows.Controls.TextBlock
$stop.Foreground = [Windows.Media.Brushes]::White
$stop.FontFamily = "Segoe UI"
$stop.FontSize = 18
$stop.Margin = "0,18,0,0"
$stop.TextWrapping = "Wrap"
$stop.Text = "If you call a support person, give them this info:`nStop code: KERNEL_DATA_INPAGE_ERROR`nWhat failed: win32kfull.sys"
$left.Children.Add($stop) | Out-Null

$img = New-Object Windows.Controls.Image
$img.Source = (New-BitmapFromBase64 $QrBase64)
$img.Width = 280
$img.Height = 280
$img.HorizontalAlignment = "Right"
$img.VerticalAlignment = "Top"
$img.Margin = "0,150,0,0"
[Windows.Controls.Grid]::SetColumn($img, 1)
$bg.Children.Add($img) | Out-Null

$sim2 = New-Object Windows.Controls.TextBlock
$sim2.Text = "DEMO"
$sim2.FontFamily = "Consolas"
$sim2.FontSize = 10
$sim2.Foreground = (New-Object Windows.Media.SolidColorBrush([Windows.Media.Color]::FromArgb(90,255,255,255)))
$sim2.HorizontalAlignment = "Left"
$sim2.VerticalAlignment = "Bottom"
$sim2.Margin = "10,0,0,10"
[Windows.Controls.Grid]::SetColumnSpan($sim2, 2)
$bg.Children.Add($sim2) | Out-Null

$hint = New-Object Windows.Controls.TextBlock
$hint.Foreground = (New-Object Windows.Media.SolidColorBrush([Windows.Media.Color]::FromArgb(170,255,255,255)))
$hint.FontFamily = "Consolas"
$hint.FontSize = 10
$hint.Text = "Press ESC to continue using PC"
$hint.HorizontalAlignment = "Right"
$hint.VerticalAlignment = "Bottom"
$hint.Margin = "0,0,12,10"
$hint.Visibility = "Hidden"
[Windows.Controls.Grid]::SetColumnSpan($hint, 2)
$bg.Children.Add($hint) | Out-Null

$bsod.Add_KeyDown({
    param($sender, $e)
    if ($e.Key -eq 'Escape') { Close-All }
})

$script:bsProgTimer = $null
$script:bsHintTimer = $null

$bsod.Add_ContentRendered({
    $pct = 0
    $prog.Text = "0% complete"
    $hint.Visibility = "Hidden"

    $script:bsProgTimer = New-Object Windows.Threading.DispatcherTimer
    $script:bsProgTimer.Interval = [TimeSpan]::FromMilliseconds(140)
    $script:bsProgTimer.Add_Tick({
        if ($pct -lt 100) {
            $step = if ($pct -lt 60) { Get-Random -Min 1 -Max 4 }
                    elseif ($pct -lt 90) { Get-Random -Min 0 -Max 3 }
                    else { Get-Random -Min 0 -Max 2 }
            $pct = [Math]::Min(100, $pct + $step)
            $prog.Text = "$pct% complete"
        }
    })
    $script:bsProgTimer.Start()

    $script:bsHintTimer = New-Object Windows.Threading.DispatcherTimer
    $script:bsHintTimer.Interval = [TimeSpan]::FromSeconds(10)
    $script:bsHintTimer.Add_Tick({
        $hint.Visibility = "Visible"
        $script:bsHintTimer.Stop()
    })
    $script:bsHintTimer.Start()
})

$bsod.Add_Closed({
    try { if ($script:bsProgTimer) { $script:bsProgTimer.Stop() } } catch {}
    try { if ($script:bsHintTimer) { $script:bsHintTimer.Stop() } } catch {}
    try { $script:restartDotsTimer.Stop() } catch {}
    try { $script:restartOneShot.Stop() } catch {}
})

$null = $term.ShowDialog()
Close-All
