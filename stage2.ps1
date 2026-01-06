<# 
CINEMATIC "HACKED" VISUAL DEMO (HARMLESS)
- Fake C:\ paths ONLY (does not enumerate real files)
- No network, no persistence, no file changes
- ESC closes instantly (including BSOD)
#>

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase

# ---------------- Helpers ----------------
function Stamp { (Get-Date).ToString("HH:mm:ss.fff") }
function RHex([int]$len=8){ -join ((1..$len) | ForEach-Object { "{0:X}" -f (Get-Random -Min 0 -Max 16) }) }
function RIp { "{0}.{1}.{2}.{3}" -f (Get-Random -Min 11 -Max 223),(Get-Random -Min 0 -Max 255),(Get-Random -Min 0 -Max 255),(Get-Random -Min 1 -Max 254) }

function Trim-Textbox {
    param([Windows.Controls.TextBox]$Box, [int]$KeepLast=900)
    if ($Box.LineCount -gt 1200) {
        $lines = $Box.Text -split "`r`n"
        if ($lines.Count -gt $KeepLast) {
            $Box.Text = ($lines[-$KeepLast..-1] -join "`r`n")
            $Box.CaretIndex = $Box.Text.Length
            $Box.ScrollToEnd()
        }
    }
}

# Fake-but-realistic C:\ paths (NO disk access)
function Get-FakePath {
    $user = $env:USERNAME

    $roots = @(
        "C:\Users\$user\Desktop",
        "C:\Users\$user\Documents",
        "C:\Users\$user\Downloads",
        "C:\Users\$user\Pictures",
        "C:\Users\$user\Videos",
        "C:\Users\$user\AppData\Local",
        "C:\Users\$user\AppData\Roaming",
        "C:\ProgramData",
        "C:\Windows\System32",
        "C:\Windows\Temp",
        "C:\Program Files",
        "C:\Program Files (x86)"
    )

    $dirsA = @("Microsoft","Google","Discord","Steam","Roblox","Drivers","Logs","Cache","Telemetry","Sessions","Temp","Packages","Services","System","Backup","Profiles","Config")
    $dirsB = @("UserData","Default","GPUCache","Local Storage","IndexedDB","CodeCache","CrashDumps","Reports","History","Auth","Vault","Keys","Staging","Runtime","Updates")
    $dirsC = @("2024","2025","2026","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec","Final","Old","New","Export","Import","Build","Release")

    $names = @("notes","report","invoice","backup","session","telemetry","cookies","tokens","inventory","settings","drivers","events","cache","bundle","manifest","index","db","vault","archive","dump")
    $exts  = @(".txt",".log",".json",".bin",".dat",".db",".sqlite",".zip",".7z",".bak",".cfg",".ini",".tmp",".pdf",".png",".jpg",".mp4",".lua",".xml",".dll")

    $root = $roots | Get-Random
    $p1 = $dirsA | Get-Random
    $p2 = $dirsB | Get-Random
    $p3 = $dirsC | Get-Random
    $file = "{0}_{1}_{2}{3}" -f ($names|Get-Random), (Get-Random -Min 10 -Max 9999), (RHex 4), ($exts|Get-Random)

    $depth = Get-Random -Min 1 -Max 4
    switch ($depth) {
        1 { return "{0}\{1}" -f $root, $file }
        2 { return "{0}\{1}\{2}" -f $root, $p1, $file }
        default { return "{0}\{1}\{2}\{3}\{4}" -f $root, $p1, $p2, $p3, $file }
    }
}

function Get-FakeSize {
    $mode = Get-Random -Min 1 -Max 4
    switch ($mode) {
        1 { "{0} KB" -f (Get-Random -Min 4 -Max 980) }
        2 { "{0}.{1} MB" -f (Get-Random -Min 1 -Max 48), (Get-Random -Min 0 -Max 9) }
        default { "{0}.{1} GB" -f (Get-Random -Min 1 -Max 6), (Get-Random -Min 0 -Max 9) }
    }
}

# Generate one "hacking log" line (no switch-cases blocks to break)
function New-FakeLogLine {
    param(
        [string[]]$verbs,
        [string[]]$things,
        [string[]]$states,
        [int[]]$ports
    )

    $ip  = RIp
    $v   = $verbs | Get-Random
    $t   = $things | Get-Random
    $p   = $ports | Get-Random
    $hex = RHex 12
    $st  = $states | Get-Random

    $k = Get-Random -Min 1 -Max 9
    if ($k -eq 1) { return "[$(Stamp)] $v $t ... $st" }
    if ($k -eq 2) { return "[$(Stamp)] CONNECT {0}:{1}  handshake={2}  status={3}" -f $ip,$p,$hex,$st }
    if ($k -eq 3) { return "[$(Stamp)] TRACE pid=$(Get-Random -Min 300 -Max 9999)  handle=0x$hex  $st" }
    if ($k -eq 4) { return "[$(Stamp)] PACKET $(Get-Random -Min 120 -Max 1500) bytes  src=$ip  flags=0x$(RHex 2)" }
    if ($k -eq 5) { return "[$(Stamp)] HASH sha256:$hex$(RHex 20)  verified=$st" }
    if ($k -eq 6) { return "[$(Stamp)] RULESET apply  policy=$(RHex 6)  scope=LOCAL  $st" }
    if ($k -eq 7) { return "[$(Stamp)] MODULE stage: kern.$(RHex 6).dll  sig=$(RHex 8)  $st" }
    return "[$(Stamp)] SYNC chunk $(Get-Random -Min 1 -Max 999)/999  id=$hex  $st"
}

function New-FakeQrText {
@"
█████████████████████████
██ ██  ███ █  ███  ██  ██
██ ███ █  █ ██ █ ███ █ ██
██  ████ ██  ████  ███  ██
██ █  ██ ███ █  ███ ███ ██
██ ██ ███  ██  ███  ██ ███
██ ███  █ ████ █ ██ ███  ██
██  ██ ███ █  ████  ███ ███
██ ███ █  █ ██ █ ███ ███  ██
██  ██  ███ █  ███  ██  ███
█████████████████████████
"@.TrimEnd()
}

# ---------------- Terminal Window ----------------
$win = New-Object Windows.Window
$win.WindowStyle = 'None'
$win.ResizeMode = 'NoResize'
$win.Topmost = $true
$win.WindowState = 'Maximized'
$win.Background = [Windows.Media.Brushes]::Black
$win.Title = "System"
$win.Cursor = [System.Windows.Input.Cursors]::None

$grid = New-Object Windows.Controls.Grid
$grid.Margin = "18"
$win.Content = $grid

$row1 = New-Object Windows.Controls.RowDefinition; $row1.Height = "9*"
$row2 = New-Object Windows.Controls.RowDefinition; $row2.Height = "1*"
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

$panel = New-Object Windows.Controls.StackPanel
$panel.Orientation = "Vertical"
[Windows.Controls.Grid]::SetRow($panel, 1)
$grid.Children.Add($panel) | Out-Null

$label = New-Object Windows.Controls.TextBlock
$label.Foreground = $tb.Foreground
$label.FontFamily = $tb.FontFamily
$label.FontSize = 14
$label.Text = "Initializing... (ESC to abort)"
$panel.Children.Add($label) | Out-Null

$bar = New-Object Windows.Controls.ProgressBar
$bar.Minimum = 0
$bar.Maximum = 100
$bar.Value = 0
$bar.Height = 18
$bar.Margin = "0,6,0,0"
$panel.Children.Add($bar) | Out-Null

# ESC closes terminal
$win.Add_KeyDown({
    param($sender, $e)
    if ($e.Key -eq 'Escape') { $sender.Close() }
})

# ---------------- SUPER BELIEVABLE FAKE BSOD ----------------
$bsod = New-Object Windows.Window
$bsod.WindowStyle = 'None'
$bsod.ResizeMode = 'NoResize'
$bsod.Topmost = $true
$bsod.WindowState = 'Maximized'
$bsod.Background = (New-Object Windows.Media.SolidColorBrush([Windows.Media.Color]::FromRgb(0,120,215)))
$bsod.Title = " "
$bsod.ShowInTaskbar = $false
$bsod.Cursor = [System.Windows.Input.Cursors]::None

# Grid layout: left text, right QR
$bsGrid = New-Object Windows.Controls.Grid
$bsGrid.Margin = "90,70,90,70"
$bsod.Content = $bsGrid

$col1 = New-Object Windows.Controls.ColumnDefinition; $col1.Width = "3*"
$col2 = New-Object Windows.Controls.ColumnDefinition; $col2.Width = "2*"
$bsGrid.ColumnDefinitions.Add($col1) | Out-Null
$bsGrid.ColumnDefinitions.Add($col2) | Out-Null

$left = New-Object Windows.Controls.StackPanel
$left.Orientation = "Vertical"
$left.VerticalAlignment = "Top"
$left.HorizontalAlignment = "Left"
[Windows.Controls.Grid]::SetColumn($left, 0)
$bsGrid.Children.Add($left) | Out-Null

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

$progress = New-Object Windows.Controls.TextBlock
$progress.Foreground = [Windows.Media.Brushes]::White
$progress.FontFamily = "Segoe UI"
$progress.FontSize = 26
$progress.Margin = "0,18,0,0"
$progress.Text = "0% complete"
$left.Children.Add($progress) | Out-Null

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

# QR block
$qr = New-Object Windows.Controls.TextBlock
$qr.Foreground = [Windows.Media.Brushes]::White
$qr.FontFamily = "Consolas"
$qr.FontSize = 14
$qr.Text = (New-FakeQrText)
$qr.VerticalAlignment = "Top"
$qr.HorizontalAlignment = "Right"
$qr.Margin = "0,120,0,0"
[Windows.Controls.Grid]::SetColumn($qr, 1)
$bsGrid.Children.Add($qr) | Out-Null

# ESC hint - appears ONLY after 10 seconds on BSOD
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
$bsGrid.Children.Add($hint) | Out-Null

# ESC closes BSOD
$bsod.Add_KeyDown({
    param($sender, $e)
    if ($e.Key -eq 'Escape') { $sender.Close() }
})

# BSOD timers: progress + delayed hint
$script:bsTimer = $null
$script:hintTimer = $null
$bsod.Add_ContentRendered({
    $pct = 0
    $progress.Text = "0% complete"
    $hint.Visibility = "Hidden"

    # progress timer (smooth-ish)
    $script:bsTimer = New-Object Windows.Threading.DispatcherTimer
    $script:bsTimer.Interval = [TimeSpan]::FromMilliseconds(140)
    $script:bsTimer.Add_Tick({
        if ($pct -lt 100) {
            # speed curve: fast at first, then slower
            $step = if ($pct -lt 60) { Get-Random -Min 1 -Max 4 }
                    elseif ($pct -lt 90) { Get-Random -Min 0 -Max 3 }
                    else { Get-Random -Min 0 -Max 2 }
            $pct = [Math]::Min(100, $pct + $step)
            $progress.Text = "$pct% complete"
        }
    })
    $script:bsTimer.Start()

    # hint appears AFTER 10 seconds on BSOD
    $script:hintTimer = New-Object Windows.Threading.DispatcherTimer
    $script:hintTimer.Interval = [TimeSpan]::FromSeconds(10)
    $script:hintTimer.Add_Tick({
        $hint.Visibility = "Visible"
        $script:hintTimer.Stop()
    })
    $script:hintTimer.Start()
})

$bsod.Add_Closed({
    try { if ($script:bsTimer) { $script:bsTimer.Stop() } } catch {}
    try { if ($script:hintTimer) { $script:hintTimer.Stop() } } catch {}
})

# ---------------- Content Setup ----------------
$hostName = $env:COMPUTERNAME
$userName = $env:USERNAME
$os = (Get-CimInstance Win32_OperatingSystem).Caption

$verbs  = @("Enumerating","Mapping","Decrypting","Injecting","Escalating","Indexing","Parsing","Harvesting","Capturing","Mirroring","Tracing","Spoofing","Hooking","Scrubbing","Staging")
$things = @("tokens","browser cache","credential blobs","registry hives","wifi profiles","session cookies","system inventory","process table","event logs","drivers","kernel handles","services","scheduled tasks","policy objects")
$states = @("OK","WARN","OK","OK","WARN","OK","OK","OK")
$ports  = @(22,80,443,445,3389,5985,5900,8080,1337,27017,6379)

$logQ  = New-Object System.Collections.Generic.Queue[string]
$fileQ = New-Object System.Collections.Generic.Queue[string]

@"
[$(Stamp)] :: SESSION OPENED
[$(Stamp)] :: TARGET = $hostName  USER = $userName
[$(Stamp)] :: OS = $os
[$(Stamp)] :: MODE = VISUAL SIMULATION (FAKE C DRIVE - NO DISK ACCESS)
-----------------------------------------------
"@.Split("`n") | ForEach-Object { $logQ.Enqueue($_.TrimEnd()) }

1..180 | ForEach-Object { $logQ.Enqueue( (New-FakeLogLine -verbs $verbs -things $things -states $states -ports $ports) ) }

$fakeCount = 1600
1..$fakeCount | ForEach-Object { $fileQ.Enqueue( (Get-FakePath) ) }

# ---------------- Effects + Timers ----------------
$flicker = New-Object Windows.Threading.DispatcherTimer
$flicker.Interval = [TimeSpan]::FromMilliseconds(120)
$flicker.Add_Tick({
    $r = Get-Random -Min 86 -Max 100
    $win.Opacity = $r / 100.0
})
$flicker.Start()

$timer = New-Object Windows.Threading.DispatcherTimer
$timer.Interval = [TimeSpan]::FromMilliseconds(25)  # FAST
$script:phase = 0

$timer.Add_Tick({
    if ($script:phase -eq 0) {
        $label.Text = "Linking... (ESC to abort)"
        $bar.Value = [Math]::Min(100, $bar.Value + (Get-Random -Min 1 -Max 4))

        $n = Get-Random -Min 4 -Max 10
        1..$n | ForEach-Object {
            if ($logQ.Count -gt 0) { $tb.AppendText($logQ.Dequeue() + "`r`n") }
        }
        Trim-Textbox -Box $tb

        if ($logQ.Count -eq 0) {
            $tb.AppendText("-----------------------------------------------`r`n")
            $tb.AppendText("[$(Stamp)] EXFIL SESSION: START (FAKE FILE LIST)`r`n")
            $tb.AppendText("-----------------------------------------------`r`n")
            $script:phase = 1
            $bar.Value = 0
        }
        return
    }

    if ($script:phase -eq 1) {
        $left = $fileQ.Count
        $done = $fakeCount - $left
        $pct  = [Math]::Floor(($done / [double]$fakeCount) * 100)
        $bar.Value = $pct
        $label.Text = ("Transferring... {0}%  ({1}/{2})  (ESC to abort)" -f $pct,$done,$fakeCount)

        $n = Get-Random -Min 8 -Max 18
        1..$n | ForEach-Object {
            if ($fileQ.Count -gt 0) {
                $path = $fileQ.Dequeue()
                $size = Get-FakeSize
                $tag  = @("STAGE","PACK","STREAM","CHUNK","PIPE","MUX","TUNNEL","BATCH") | Get-Random
                $id   = RHex 6
                $tb.AppendText(("[$(Stamp)] {0} id={1}  {2}  ->  transfer `"{3}`"" -f $tag,$id,$size,$path) + "`r`n")
            }
        }
        Trim-Textbox -Box $tb

        if ($fileQ.Count -eq 0) {
            $tb.AppendText("-----------------------------------------------`r`n")
            $tb.AppendText(("[$(Stamp)] TRANSFER COMPLETE  total={0} items`r`n" -f $fakeCount))
            $tb.AppendText("[$(Stamp)] FINALIZING...`r`n")
            $bar.Value = 100
            $label.Text = "Complete."
            $script:phase = 2
        }
        return
    }

    if ($script:phase -eq 2) {
        $timer.Stop()
        $flicker.Stop()
        $win.Hide()
        $null = $bsod.ShowDialog()
        $win.Close()
    }
})

$timer.Start()
$null = $win.ShowDialog()

try { $timer.Stop() } catch {}
try { $flicker.Stop() } catch {}
