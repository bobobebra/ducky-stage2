<# 
FAKE "HACKED" VISUAL DEMO (HARMLESS)
- No file changes, no network calls, no persistence
- ESC to quit instantly
Run: powershell -ExecutionPolicy Bypass -File .\fake_hacked_demo.ps1
#>

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase

# ---------- Helpers ----------
function Get-RandIP {
    "{0}.{1}.{2}.{3}" -f (Get-Random -Min 11 -Max 223), (Get-Random -Min 0 -Max 255), (Get-Random -Min 0 -Max 255), (Get-Random -Min 1 -Max 254)
}
function Get-RandHex([int]$len = 8) {
    -join ((1..$len) | ForEach-Object { "{0:X}" -f (Get-Random -Min 0 -Max 16) })
}
function Add-Line([string]$s) {
    $script:tb.AppendText($s + "`r`n")
    $script:tb.ScrollToEnd()
}
function Stamp { (Get-Date).ToString("HH:mm:ss.fff") }

# ---------- Window ----------
$win = New-Object Windows.Window
$win.WindowStyle = 'None'
$win.ResizeMode = 'NoResize'
$win.Topmost = $true
$win.WindowState = 'Maximized'
$win.Background = [Windows.Media.Brushes]::Black
$win.Title = "System"

$grid = New-Object Windows.Controls.Grid
$grid.Margin = "18"
$win.Content = $grid

# rows: terminal + progress
$row1 = New-Object Windows.Controls.RowDefinition
$row1.Height = "9*"
$row2 = New-Object Windows.Controls.RowDefinition
$row2.Height = "1*"
$grid.RowDefinitions.Add($row1) | Out-Null
$grid.RowDefinitions.Add($row2) | Out-Null

$tb = New-Object Windows.Controls.TextBox
$tb.IsReadOnly = $true
$tb.BorderThickness = 0
$tb.Background = [Windows.Media.Brushes]::Black
$tb.Foreground = (New-Object Windows.Media.SolidColorBrush([Windows.Media.Color]::FromRgb(0,255,110)))
$tb.FontFamily = "Consolas"
$tb.FontSize = 16
$tb.VerticalScrollBarVisibility = "Auto"
$tb.HorizontalScrollBarVisibility = "Auto"
$tb.TextWrapping = "NoWrap"
$tb.CaretBrush = $tb.Foreground
[Windows.Controls.Grid]::SetRow($tb, 0)
$grid.Children.Add($tb) | Out-Null

# Progress panel
$panel = New-Object Windows.Controls.StackPanel
$panel.Orientation = "Vertical"
[Windows.Controls.Grid]::SetRow($panel, 1)
$grid.Children.Add($panel) | Out-Null

$label = New-Object Windows.Controls.TextBlock
$label.Foreground = $tb.Foreground
$label.FontFamily = $tb.FontFamily
$label.FontSize = 14
$label.Text = "Initializing… (ESC to abort)"
$panel.Children.Add($label) | Out-Null

$bar = New-Object Windows.Controls.ProgressBar
$bar.Minimum = 0
$bar.Maximum = 100
$bar.Value = 0
$bar.Height = 18
$bar.Margin = "0,6,0,0"
$panel.Children.Add($bar) | Out-Null

# Make ESC close immediately
$win.Add_KeyDown({
    param($sender, $e)
    if ($e.Key -eq 'Escape') { $sender.Close() }
})

# Keep references global for helper functions
$script:tb = $tb

# ---------- Fake script content ----------
$hostName = $env:COMPUTERNAME
$userName = $env:USERNAME
$os = (Get-CimInstance Win32_OperatingSystem).Caption

$banner = @"
[$(Stamp)] :: SESSION OPENED
[$(Stamp)] :: TARGET = $hostName  USER = $userName
[$(Stamp)] :: OS = $os
[$(Stamp)] :: MODE = VISUAL SIMULATION (NO CHANGES)
-----------------------------------------------
"@.TrimEnd()

# Some scary-ish but clearly fake-ish themes
$verbs = @("Enumerating","Mapping","Decrypting","Injecting","Escalating","Indexing","Parsing","Harvesting","Capturing","Mirroring","Tracing","Spoofing")
$things = @("tokens","browser cache","credential vault","registry hives","wifi profiles","ssh keys","session cookies","system inventory","process table","event logs","drivers","kernel handles")
$states = @("OK","WARN","OK","OK","WARN","OK","OK","OK")
$ports  = @(22,80,443,445,3389,5985,5900,8080,1337,27017,6379)

# Glitch/flicker effect (opacity pulses)
$flicker = New-Object Windows.Threading.DispatcherTimer
$flicker.Interval = [TimeSpan]::FromMilliseconds(180)
$flicker.Add_Tick({
    # Random little flicker; still readable
    $r = Get-Random -Min 85 -Max 100
    $win.Opacity = $r / 100.0
})
$flicker.Start()

# Main output timer
$timer = New-Object Windows.Threading.DispatcherTimer
$timer.Interval = [TimeSpan]::FromMilliseconds(90)

$script:lines = New-Object System.Collections.Generic.Queue[string]
$script:progress = 0
$script:phase = 0

# Preload banner
$banner.Split("`n") | ForEach-Object { $script:lines.Enqueue($_.TrimEnd()) }

# Preload a bunch of fake log lines
1..350 | ForEach-Object {
    $ip = Get-RandIP
    $v  = $verbs | Get-Random
    $t  = $things | Get-Random
    $p  = $ports | Get-Random
    $hex = Get-RandHex 12
    $st = $states | Get-Random

    $msg = switch (Get-Random -Min 1 -Max 8) {
        1 { "[$(Stamp)] $v $t … $st" }
        2 { "[$(Stamp)] CONNECT $ip:$p  handshake=$hex  status=$st" }
        3 { "[$(Stamp)] TRACE pid=$(Get-Random -Min 300 -Max 9999)  handle=0x$hex  $st" }
        4 { "[$(Stamp)] PACKET $(Get-Random -Min 120 -Max 1500) bytes  src=$ip  flags=0x$(Get-RandHex 2)" }
        5 { "[$(Stamp)] HASH sha256:$hex$(Get-RandHex 20)  verified=$st" }
        6 { "[$(Stamp)] ROUTE add 0.0.0.0/0 -> $ip  metric=$(Get-Random -Min 1 -Max 50)  $st" }
        7 { "[$(Stamp)] MODULE load: kern.$(Get-RandHex 6).dll  sig=$(Get-RandHex 8)  $st" }
        Default { "[$(Stamp)] SYNC chunk $(Get-Random -Min 1 -Max 999)/999  id=$hex  $st" }
    }
    $script:lines.Enqueue($msg)
}

# Closing / punchline (still “visual demo”, not threatening)
@(
"-----------------------------------------------",
"[$(Stamp)] FINALIZING…",
"[$(Stamp)] NOTE: This was a VISUAL DEMO only.",
"[$(Stamp)] Press ESC to close."
) | ForEach-Object { $script:lines.Enqueue($_) }

$timer.Add_Tick({
    # Print a few lines per tick
    $n = Get-Random -Min 1 -Max 4
    1..$n | ForEach-Object {
        if ($script:lines.Count -gt 0) {
            Add-Line $script:lines.Dequeue()
        }
    }

    # Progress increases while lines remain
    if ($script:lines.Count -gt 0) {
        $script:progress = [Math]::Min(100, $script:progress + (Get-Random -Min 0 -Max 3))
        $bar.Value = $script:progress
        $label.Text = "Transferring… $([int]$bar.Value)%  (ESC to abort)"
    } else {
        $bar.Value = 100
        $label.Text = "Complete. (ESC to close)"
        $timer.Stop()
    }
})
$timer.Start()

# Show window
$win.ShowDialog() | Out-Null

# Cleanup
$flicker.Stop()
