# 重连WIFI
$wifiName = "1-904_5G"

$pingTarget = "8.8.8.8"

while ($true) {
    $online = Test-Connection -ComputerName $pingTarget -Count 1 -Quiet

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
