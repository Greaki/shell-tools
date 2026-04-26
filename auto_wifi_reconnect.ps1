$wifiName = "1-904_5G"

while ($true) {
    $online = $false

    try {
        $online = Test-NetConnection -ComputerName "www.baidu.com" -Port 443 -InformationLevel Quiet
    } catch {
        $online = $false
    }

    if ($online) {
        Write-Host "$(Get-Date) - connected"
    } else {
        Write-Host "$(Get-Date) - network down, reconnecting WiFi..."

        netsh wlan disconnect | Out-Null
        Start-Sleep -Seconds 2
        netsh wlan connect name="$wifiName" | Out-Null
    }

    Start-Sleep -Seconds 5
}