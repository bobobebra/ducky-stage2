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
    $dirsB = @("UserData","Default","GPUCache","Local Storage","IndexedDB","Code Cache","DawnCache","CrashDumps","Reports","History","Auth","Vault","Keys","Staging","Runtime","Updates")
    $dirsC = @("2024","2025","2026","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec","Final","Old","New","Export","Import","Build","Release")

    $names = @(
        "notes","report","invoice","backup","session","telemetry","cookies","tokens","inventory","settings",
        "drivers","events","cache","bundle","manifest","index","db","vault","archive","dump"
    )

    $exts = @(".txt",".log",".json",".bin",".dat",".db",".sqlite",".zip",".7z",".bak",".cfg",".ini",".tmp",".pdf",".png",".jpg",".mp4",".lua",".xml",".dll")

    $root = $roots | Get-Random
    $p1 = $dirsA | Get-Random
    $p2 = $dirsB | Get-Random
    $p3 = $dirsC | Get-Random

    $file = "{0}_{1}_{2}{3}" -f ($names|Get-Random), (Get-Random -Min 10 -Max 9999), (RHex 4), ($exts|Get-Random)

    # Randomly choose depth
    $depth = Get-Random -Min 1 -Max 4
    switch ($depth) {
        1 { return "{0}\{1}" -f $root, $file }
        2 { return "{0}\{1}\{2}" -f $root, $p1, $file }
        Default { return "{0}\{1}\{2}\{3}\{4}" -f $root, $p1, $p2, $p3, $file }
    }
}

function Get-FakeSize {
    $mode = Get-Random -Min 1 -Max 4
    switch ($mode) {
        1 { "{0} KB" -f (Get-Random -Min 4 -Max 980) }
        2 { "{0}.{1} MB" -f (Get-Random -Min 1 -Max 48), (Get-Random -Min 0 -Max 9) }
        Default { "{0}.{1} GB" -f (Get-Random -Min 1 -Max 6), (Get-Random -Min 0 -Max 9) }
    }
}

# ---------------- Terminal Window ----------------
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
$label.Text = "Initializing… (ESC to abort)"
$panel.Children.Add($label) | Out-Null

$bar = New-Object Windows.Controls.ProgressBar
$bar.Minimum = 0
$bar.Maximum = 100
$bar.Value = 0
$bar.Height = 18
$bar.Margin = "0,6,0,0"
$panel.Children.Add($bar) | Out-Null

# ESC closes
$win.Add_KeyDown({
    param($sender, $e)
    if ($e.Key -eq 'Escape') { $sender.Close() }
})

# ---------------- Fake BSOD Window ----------------
$bsod = New-Object Windows.Window
$bsod.WindowStyle = 'None'
$bsod.ResizeMode = 'NoResize'
$bsod.Topmost = $true
$bsod.WindowState = 'Maximized'
$bsod.Background = (New-Object Windows.Media.SolidColorBrush([Windows.Media.Color]::FromRgb(0,120,215)))
$bsod.Title = " "

$bsGrid = New-Object Windows.Controls.Grid
$bsGrid.Margin = "80"
$bsod.Content = $bsGrid

$bsText = New-Object Windows.Controls.TextBlock
$bsText.Foreground = [Windows.Media.Brushes]::White
$bsText.FontFamily = "Segoe UI"
$bsText.FontSize = 28
$bsText.TextWrapping = "Wrap"
$bsText.VerticalAlignment = "Top"
$bsText.HorizontalAlignment = "Left"
$bsText.Text = @"
:(
Your PC ran into a problem and needs to restart.
We're just collecting some error info, and then we'll restart for you.

Stop code: KERNEL_DATA_INPAGE_ERROR
What failed: win32kfull.sys
"@.Trim()
$bsGrid.Children.Add($bsText) | Out-Null

$bsTiny = New-Object Windows.Controls.TextBlock
$bsTiny.Foreground = (New-Object Windows.Media.SolidColorBrush([Windows.Media.Color]::FromArgb(160,255,255,255)))
$bsTiny.FontFamily = "Consolas"
$bsTiny.FontSize = 10
$bsTiny.Text = "press ESC to exit"
$bsTiny.HorizontalAlignment = "Right"
$bsTiny.VerticalAlignment = "Bottom"
$bsTiny.Margin = "0,0,10,10"
$bsGrid.Children.Add($bsTiny) | Out-Null

$bsod.Add_KeyDown({
    param($sender, $e)
    if ($e.Key -eq 'Escape') { $sender.Close() }
})

# ---------------- Content Queues ----------------
$hostName = $env:COMPUTERNAME
$userName = $env:USERNAME
$os = (Get-CimInstance Win32_OperatingSystem).Caption

$verbs  = @("Enumerating","Mapping","Decrypting","Injecting","Escalating","Indexing","Parsing","Harvesting","Capturing","Mirroring","Tracing","Spoofing","Hooking","Scrubbing","Staging")
$things = @("tokens","browser cache","credential blobs","registry hives","wifi profiles","session cookies","system inventory","process table","event logs","drivers","kernel handles","services","scheduled tasks","policy objects")
$states = @("OK","WARN","OK","OK","WARN","OK","OK","OK")
$ports  = @(22,80,443,445,3389,5985,5900,8080,1337,27017,6379)

$logQ   = New-Object System.Collections.Generic.Queue[string]
$fileQ  = New-Object System.Collections.Generic.Queue[string]

# Banner (explicitly says fake)
@"
[$(Stamp)] :: SESSION OPENED
[$(Stamp)] :: TARGET = $hostName  USER = $userName
[$(Stamp)] :: OS = $os
[$(Stamp)] :: MODE = VISUAL SIMULATION (FAKE C:\ INDEX — NO DISK ACCESS)
-----------------------------------------------
"@.Split("`n") | ForEach-Object { $logQ.Enqueue($_.TrimEnd()) }

# Warm-up logs
1..180 | ForEach-Object {
    $ip  = RIp
    $v   = $verbs | Get-Random
    $t   = $things | Get-Random
    $p   = $ports | Get-Random
    $hex = RHex 12
    $st  = $states | Get-Random

    $logQ.Enqueue( (switch (Get-Random -Min 1 -Max 8) {
        1 { "[$(Stamp)] $v $t … $st" }
        2 { "[$(Stamp)] CONNECT {0}:{1}  handshake={2}  status={3}" -f $ip,$p,$hex,$st }
        3 { "[$(Stamp)] TRACE pid=$(Get-Random -Min 300 -Max 9999)  handle=0x$hex  $st" }
        4 { "[$(Stamp)] PACKET $(Get-Random -Min 120 -Max 1500) bytes  src=$ip  flags=0x$(RHex 2)" }
        5 { "[$(Stamp)] HASH sha256:$hex$(RHex 20)  verified=$st" }
        6 { "[$(Stamp)] RULESET apply  policy=$(RHex 6)  scope=LOCAL  $st" }
        7 { "[$(Stamp)] MODULE stage: kern.$(RHex 6).dll  sig=$(RHex 8)  $st" }
        Default { "[$(Stamp)] SYNC chunk $(Get-Random -Min 1 -Max 999)/999  id=$hex  $st" }
    }) )
}

# Fake "C:\ drive scan" file list
# (purely generated strings)
$fakeCount = 1600
1..$fakeCount | ForEach-Object {
    $fileQ.Enqueue( (Get-FakePath) )
}

# ---------------- Effects + Timers ----------------
# Flicker
$flicker = New-Object Windows.Threading.DispatcherTimer
$flicker.Interval = [TimeSpan]::FromMilliseconds(120)
$flicker.Add_Tick({
    $r = Get-Random -Min 86 -Max 100
    $win.Opacity = $r / 100.0
})
$flicker.Start()

$timer = New-Object Windows.Threading.DispatcherTimer
$timer.Interval = [TimeSpan]::FromMilliseconds(25)  # FAST
$script:phase = 0      # 0=logs, 1=transfer, 2=complete->bsod
$script:progress = 0
$script:transferred = 0
$script:startFiles = $fakeCount

$timer.Add_Tick({
    # ESC kill-switch already handled by window key event.

    if ($script:phase -eq 0) {
        $label.Text = "Linking… (ESC to abort)"
        $bar.Value = [Math]::Min(100, $bar.Value + (Get-Random -Min 1 -Max 4))

        $n = Get-Random -Min 4 -Max 10
        1..$n | ForEach-Object {
            if ($logQ.Count -gt 0) {
                $tb.AppendText($logQ.Dequeue() + "`r`n")
            }
        }
        Trim-Textbox -Box $tb

        if ($logQ.Count -eq 0) {
            $tb.AppendText("-----------------------------------------------`r`n")
            $tb.AppendText("[$(Stamp)] EXFIL SESSION: START (FAKE FILE LIST)`r`n")
            $tb.AppendText("[$(Stamp)] NOTE: This demo does NOT read real files.`r`n")
            $tb.AppendText("-----------------------------------------------`r`n")
            $script:phase = 1
            $bar.Value = 0
            $script:progress = 0
        }
        return
    }

    if ($script:phase -eq 1) {
        # Transfer phase (prints fake C:\ paths)
        $left = $fileQ.Count
        $done = $script:startFiles - $left
        $pct  = [Math]::Floor(($done / [double]$script:startFiles) * 100)
        $bar.Value = $pct
        $label.Text = ("Transferring… {0}%  ({1}/{2})  (ESC to abort)" -f $pct,$done,$script:startFiles)

        # Speedy printing
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
            $tb.AppendText(("[$(Stamp)] TRANSFER COMPLETE  total={0} items`r`n" -f $script:startFiles))
            $tb.AppendText("[$(Stamp)] FINALIZING…`r`n")
            $tb.AppendText("[$(Stamp)] (demo) switching display mode…`r`n")
            $bar.Value = 100
            $label.Text = "Complete."
            $script:phase = 2
        }
        return
    }

    if ($script:phase -eq 2) {
        # short beat then BSOD
        $timer.Stop()
        $flicker.Stop()
        $win.Hide()
        $null = $bsod.ShowDialog()
        # after BSOD closes
        $win.Close()
    }
})

$timer.Start()
$null = $win.ShowDialog()

# Cleanup
try { $timer.Stop() } catch {}
try { $flicker.Stop() } catch {}
