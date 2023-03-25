# script array
Clear-Host
$googleDNS = @("8.8.8.8", "8.8.4.4")
$totalDNS = $googleDNS.Count

Write-Host Pingando todos os $totalDNS DNS do Google
Test-Connection $googleDNS -Count 1
sleep 3

Write-host "fimE"