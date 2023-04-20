# Define o nome do servidor a ser verificado
$ServerName = "SVWTKO02CD00001"

# Cria um objeto de sessão do Internet Explorer
$IE = New-Object -ComObject InternetExplorer.Application

# Navega até a página de atualizações do Windows Server 2012 no site da Microsoft
$IE.Navigate("https://www.catalog.update.microsoft.com/Search.aspx?q=windows+server+2012")

# Aguarda a página carregar completamente
While ($IE.ReadyState -ne 4) { Start-Sleep -Milliseconds 100 }

# Obtém a lista de atualizações disponíveis no site da Microsoft
$AvailableUpdates = @($IE.Document.getElementsByTagName("tr") | Where-Object { $_.id -like "KB*" } | Select-Object -Property innerText)

# Obtém as atualizações instaladas no servidor
$InstalledUpdates = Get-WmiObject -Class Win32_QuickFixEngineering -ComputerName $ServerName | Select-Object -Property HotFixID

# Compara as atualizações instaladas com as disponíveis para identificar as faltantes
$MissingUpdates = Compare-Object -ReferenceObject $InstalledUpdates -DifferenceObject $AvailableUpdates | Where-Object { $_.SideIndicator -eq "=>" } | Select-Object -ExpandProperty InputObject

# Salva a lista de atualizações faltantes em um arquivo de texto na área de trabalho
$MissingUpdates | Out-File -FilePath "$($env:USERPROFILE)\Desktop\AtualizacoesFaltantes_$ServerName.txt"

