# thank you chatgpt

$logPath = Join-Path $env:APPDATA "Macromedia\Flash Player\Logs\flashlog.txt"

if (!(Test-Path $logPath)) {
Write-Host "Log file not found at: $logPath"
exit
}

Write-Host "Watching flashlog.txt in real-time"
Write-Host "Path: $logPath"
Write-Host "Press Ctrl+C to stop.`n"

Get-Content $logPath -Wait -Tail 0
