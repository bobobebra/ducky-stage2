# ===== Stage 2 demo script =====

Add-Type -AssemblyName PresentationFramework
[System.Windows.MessageBox]::Show(
    "Loaded from GitHub successfully!",
    "2-Stage Ducky Demo"
)

# Set volume to a reasonable level (not max)
$wsh = New-Object -ComObject WScript.Shell
1..10 | ForEach-Object { $wsh.SendKeys([char]175) }

Start-Process "https://youtube.com"
