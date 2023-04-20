# Define o caminho dos arquivos onde as informações serão salvas
$txtFilePath = "\\7417172307106\c$\Users\C1332555\Desktop\TesTe\informacoesComputador.txt"
$csvFilePath = "\\7417172307106\c$\Users\C1332555\Desktop\TesTe\informacoesComputador.csv"


# Verifica se os arquivos existem e, se não existirem, cria os arquivos com as colunas
$header = "Nome PC", "Endereço MAC da Placa Cabeada", "Endereço MAC da Placa Wi-Fi"
if (!(Test-Path $txtFilePath)) {
    $header -join "    " | Out-File -FilePath $txtFilePath
}
if (!(Test-Path $csvFilePath)) {
    $header | Export-Csv -Path $csvFilePath -NoTypeInformation
}


# Obtém o nome do computador
$computerName = $env:COMPUTERNAME

# Obtém o endereço MAC da placa de rede cabeada (se existir)
$cabledMacAddress = $null
$cabledAdapter = Get-NetAdapter | Where-Object {$_.PhysicalMediaType -eq '802.3'}
if ($cabledAdapter) {
    $cabledMacAddress = $cabledAdapter.MacAddress
}

# Obtém o endereço MAC da placa de rede Wi-Fi (se existir)
$wifiMacAddress = $null
$wifiAdapter = Get-NetAdapter | Where-Object {$_.PhysicalMediaType -eq 'Native WiFi'}
if ($wifiAdapter) {
    $wifiMacAddress = $wifiAdapter.MacAddress
}

# Adiciona as informações coletadas nos arquivos
$newRow = $computerName, $cabledMacAddress, $wifiMacAddress
$newRowTxt = $newRow -join "    "
$newRowTxt | Out-File -FilePath $txtFilePath -Append
$newRow | Out-File -FilePath $csvFilePath  -Append



