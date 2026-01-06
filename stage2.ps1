<# 
CYBER VISUAL DEMO (SAFE)
- Visual only: does NOT read C:\, does NOT encrypt files, does NOT touch data
- Fake terminal autoscrolls, then "Restarting..." (demo), then blue-screen style (demo)
- ESC exits instantly at any time
#>

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase

# ---------------- Embedded QR (your image) ----------------
$QrBase64 = @'
iVBORw0KGgoAAAANSUhEUgAABIMAAASDCAIAAABlaWigAAAABmJLR0QA/wD/AP+gvaeTAAAdiElEQVR4
nO3dS47jSBaA4c7//2x2sQwQm2iQd8mE5lBq0mGq3GJc6b2u9f7qHfYqk9c0yqz7v1v6c3c0AAAAA
AAAAAAAgv0d6AAAA0JQYAABATYkBAADUlBgAAEBNiQEAANSUGAAAQE2JAQAA1JQYAABATYkBAADU
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
ANSUGAAAQE2JAQAA
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

# ---------------- Common helpers ----------------
function Stamp { (Get-Date).ToString("HH:mm:ss.fff") }
function RHex([int]$len=8){ -join ((1..$len) | ForEach-Object { "{0:X}" -f (Get-Random -Min 0 -Max 16) }) }

function Cap-Textbox([Windows.Controls.TextBox]$Box, [int]$KeepLast=900) {
    if ($Box.LineCount -gt 1400) {
        $lines = $Box.Text -split "`r`n"
        if ($lines.Count -gt $KeepLast) {
            $Box.Text = ($lines[-$KeepLast..-1] -join "`r`n")
            $Box.CaretIndex = $Box.Text.Length
            $Box.ScrollToEnd()
        }
    }
}

$global:W1 = $null
$global:W2 = $null
$global:W3 = $null

function Close-All {
    foreach ($w in @($global:W3,$global:W2,$global:W1)) {
        try { if ($w -and $w.IsVisible) { $w.Close() } } catch {}
    }
}

# ---------------- Window 1: Auto-scrolling terminal demo ----------------
$w = New-Object Windows.Window
$global:W1 = $w
$w.WindowStyle = 'None'
$w.ResizeMode = 'NoResize'
$w.Topmost = $true
$w.WindowState = 'Maximized'
$w.Background = [Windows.Media.Brushes]::Black
$w.Title = "Demo Terminal"
$w.Cursor = [System.Windows.Input.Cursors]::Arrow

$grid = New-Object Windows.Controls.Grid
$grid.Margin = "18"
$w.Content = $grid

$r1 = New-Object Windows.Controls.RowDefinition; $r1.Height = "9*"
$r2 = New-Object Windows.Controls.RowDefinition; $r2.Height = "1*"
$grid.RowDefinitions.Add($r1) | Out-Null
$grid.RowDefinitions.Add($r2) | Out-Null

$tb = New-Object Windows.Controls.TextBox
$tb.IsReadOnly = $true
$tb.BorderThickness = 0
$tb.Background = [Windows.Media.Brushes]::Black
$tb.Foreground = (New-Object Windows.Media.SolidColorBrush([Windows.Media.Color]::FromRgb(0,255,110)))
$tb.FontFamily = "Consolas"
$tb.FontSize = 16
$tb.VerticalScrollBarVisibility = "Hidden"
$tb.HorizontalScrollBarVisibility = "Hidden"
$tb.TextWrapping = "NoWrap"
[Windows.Controls.Grid]::SetRow($tb, 0)
$grid.Children.Add($tb) | Out-Null

$bottom = New-Object Windows.Controls.Grid
[Windows.Controls.Grid]::SetRow($bottom, 1)
$grid.Children.Add($bottom) | Out-Null

$left = New-Object Windows.Controls.TextBlock
$left.Text = "DEMO / VISUAL ONLY — ESC to exit"
$left.FontFamily = "Consolas"
$left.FontSize = 12
$left.Foreground = (New-Object Windows.Media.SolidColorBrush([Windows.Media.Color]::FromArgb(190,0,255,110)))
$left.HorizontalAlignment = "Left"
$left.VerticalAlignment = "Center"
$left.Margin = "4,0,0,0"
$bottom.Children.Add($left) | Out-Null

$right = New-Object Windows.Controls.TextBlock
$right.Text = "Auto-scroll ON"
$right.FontFamily = "Consolas"
$right.FontSize = 12
$right.Foreground = (New-Object Windows.Media.SolidColorBrush([Windows.Media.Color]::FromArgb(140,0,255,110)))
$right.HorizontalAlignment = "Right"
$right.VerticalAlignment = "Center"
$right.Margin = "0,0,4,0"
$bottom.Children.Add($right) | Out-Null

function Add-TermLine([string]$s) {
    $tb.AppendText($s + "`r`n")
    $tb.CaretIndex = $tb.Text.Length
    $tb.ScrollToEnd()
}

# Fake path generator (still fake; no disk access)
function FakePath {
    $u = $env:USERNAME
    $roots = @(
        "C:\Users\$u\Documents","C:\Users\$u\Downloads","C:\Users\$u\AppData\Local",
        "C:\ProgramData","C:\Windows\System32","C:\Program Files","C:\Program Files (x86)"
    )
    $a = @("Cache","Logs","Config","Profiles","Sessions","Temp","Packages","Data","Runtime","Reports")
    $b = @("Default","UserData","LocalStorage","IndexedDB","CrashDumps","Telemetry","Backup","Staging")
    $n = @("manifest","index","bundle","settings","report","session","archive","db","snapshot","state")
    $e = @(".log",".json",".dat",".db",".bin",".tmp",".cfg",".ini",".zip")
    "{0}\{1}\{2}\{3}_{4}{5}" -f ($roots|Get-Random),($a|Get-Random),($b|Get-Random),($n|Get-Random),(Get-Random -Min 10 -Max 9999),($e|Get-Random)
}

# Autoscrolling demo stream
$verbs = @("Linking","Indexing","Profiling","Tracing","Mapping","Auditing","Verifying","Cataloging","Staging","Synthesizing")
$objs  = @("runtime graph","service map","driver set","event stream","policy store","module table","memory map (sim)","packet flow (sim)")
$tags  = @("OK","OK","OK","WARN","OK","OK","OK")

$demoTimer = New-Object Windows.Threading.DispatcherTimer
$demoTimer.Interval = [TimeSpan]::FromMilliseconds(35)
$script:ticks = 0

$demoTimer.Add_Tick({
    $script:ticks++

    $n = Get-Random -Min 7 -Max 16
    1..$n | ForEach-Object {
        $v = $verbs | Get-Random
        $o = $objs  | Get-Random
        $t = $tags  | Get-Random
        $id = RHex 6
        Add-TermLine ("[{0}] {1} {2}  id={3}  {4}" -f (Stamp),$v,$o,$id,$t)

        # Occasionally show clearly-labeled simulated "payload" line (not encryption)
        if ((Get-Random -Min 1 -Max 22) -eq 1) {
            Add-TermLine ("[{0}] SIMULATION: processing sample item -> {1}" -f (Stamp),(FakePath))
        }
    }

    Cap-Textbox $tb 950

    # After ~10 seconds, go to restart screen
    if ($script:ticks -ge 300) {
        $demoTimer.Stop()
        $w.Hide()
        $global:W2.Show()
    }
})

$w.Add_KeyDown({
    param($sender,$e)
    if ($e.Key -eq 'Escape') { Close-All }
})

# Start
Add-TermLine ("[{0}] DEMO SESSION OPENED (VISUAL ONLY)" -f (Stamp))
Add-TermLine ("[{0}] NOTE: No files are accessed or modified." -f (Stamp))
Add-TermLine ("[{0}] Press ESC to exit at any time." -f (Stamp))
Add-TermLine "------------------------------------------------------------"
$demoTimer.Start()

# ---------------- Window 2: Restarting (demo) ----------------
$restart = New-Object Windows.Window
$global:W2 = $restart
$restart.WindowStyle = 'None'
$restart.ResizeMode = 'NoResize'
$restart.Topmost = $true
$restart.WindowState = 'Maximized'
$restart.Background = [Windows.Media.Brushes]::Black
$restart.Title = "Restarting (Demo)"
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

$rHint = New-Object Windows.Controls.TextBlock
$rHint.Text = "DEMO — Press ESC to exit"
$rHint.FontFamily = "Consolas"
$rHint.FontSize = 12
$rHint.Foreground = (New-Object Windows.Media.SolidColorBrush([Windows.Media.Color]::FromArgb(160,255,255,255)))
$rHint.HorizontalAlignment = "Right"
$rHint.VerticalAlignment = "Bottom"
$rHint.Margin = "0,0,10,10"
$rg.Children.Add($rHint) | Out-Null

$restart.Add_KeyDown({ param($s,$e) if ($e.Key -eq 'Escape') { Close-All } })

$dotsTimer = New-Object Windows.Threading.DispatcherTimer
$dotsTimer.Interval = [TimeSpan]::FromMilliseconds(320)
$script:dots = 0
$dotsTimer.Add_Tick({
    $script:dots = ($script:dots + 1) % 4
    $rt.Text = "Restarting" + ("." * $script:dots)
})

$toBsod = New-Object Windows.Threading.DispatcherTimer
$toBsod.Interval = [TimeSpan]::FromMilliseconds(2400)
$toBsod.Add_Tick({
    $toBsod.Stop()
    $dotsTimer.Stop()
    $restart.Hide()
    $global:W3.Show()
})

$restart.Add_ContentRendered({
    $script:dots = 0
    $rt.Text = "Restarting"
    $dotsTimer.Start()
    $toBsod.Start()
})

# ---------------- Window 3: Blue-screen style demo + QR ----------------
$bsod = New-Object Windows.Window
$global:W3 = $bsod
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

$stack = New-Object Windows.Controls.StackPanel
$stack.Orientation = "Vertical"
$stack.VerticalAlignment = "Top"
$stack.HorizontalAlignment = "Left"
[Windows.Controls.Grid]::SetColumn($stack, 0)
$bg.Children.Add($stack) | Out-Null

$face = New-Object Windows.Controls.TextBlock
$face.Foreground = [Windows.Media.Brushes]::White
$face.FontFamily = "Segoe UI"
$face.FontSize = 86
$face.Text = ":("
$stack.Children.Add($face) | Out-Null

$main = New-Object Windows.Controls.TextBlock
$main.Foreground = [Windows.Media.Brushes]::White
$main.FontFamily = "Segoe UI"
$main.FontSize = 28
$main.TextWrapping = "Wrap"
$main.Margin = "0,12,0,0"
$main.Text = @"
This is a DEMO screen (visual only).
Press ESC to exit.
"@.TrimEnd()
$stack.Children.Add($main) | Out-Null

$prog = New-Object Windows.Controls.TextBlock
$prog.Foreground = [Windows.Media.Brushes]::White
$prog.FontFamily = "Segoe UI"
$prog.FontSize = 26
$prog.Margin = "0,18,0,0"
$prog.Text = "0% complete"
$stack.Children.Add($prog) | Out-Null

$stop = New-Object Windows.Controls.TextBlock
$stop.Foreground = [Windows.Media.Brushes]::White
$stop.FontFamily = "Segoe UI"
$stop.FontSize = 18
$stop.Margin = "0,18,0,0"
$stop.TextWrapping = "Wrap"
$stop.Text = "Stop code: DEMO_VISUAL_ONLY`nWhat failed: (none)"
$stack.Children.Add($stop) | Out-Null

$img = New-Object Windows.Controls.Image
$img.Source = (New-BitmapFromBase64 $QrBase64)
$img.Width = 280
$img.Height = 280
$img.HorizontalAlignment = "Right"
$img.VerticalAlignment = "Top"
$img.Margin = "0,150,0,0"
[Windows.Controls.Grid]::SetColumn($img, 1)
$bg.Children.Add($img) | Out-Null

$hint = New-Object Windows.Controls.TextBlock
$hint.Foreground = (New-Object Windows.Media.SolidColorBrush([Windows.Media.Color]::FromArgb(200,255,255,255)))
$hint.FontFamily = "Consolas"
$hint.FontSize = 12
$hint.Text = "Press ESC to exit demo"
$hint.HorizontalAlignment = "Right"
$hint.VerticalAlignment = "Bottom"
$hint.Margin = "0,0,12,10"
[Windows.Controls.Grid]::SetColumnSpan($hint, 2)
$bg.Children.Add($hint) | Out-Null

$bsod.Add_KeyDown({ param($s,$e) if ($e.Key -eq 'Escape') { Close-All } })

$bsPct = 0
$bsTimer = New-Object Windows.Threading.DispatcherTimer
$bsTimer.Interval = [TimeSpan]::FromMilliseconds(140)
$bsTimer.Add_Tick({
    if ($bsPct -lt 100) {
        $step = if ($bsPct -lt 60) { Get-Random -Min 1 -Max 4 }
                elseif ($bsPct -lt 90) { Get-Random -Min 0 -Max 3 }
                else { Get-Random -Min 0 -Max 2 }
        $bsPct = [Math]::Min(100, $bsPct + $step)
        $prog.Text = "$bsPct% complete"
    }
})

$bsod.Add_ContentRendered({
    $bsPct = 0
    $prog.Text = "0% complete"
    $bsTimer.Start()
})

$bsod.Add_Closed({
    try { $bsTimer.Stop() } catch {}
})

# ---------------- Run ----------------
$null = $w.ShowDialog()
Close-All
