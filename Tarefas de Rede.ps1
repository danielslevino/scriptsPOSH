# RENOMEAR COMPUTADORES

$Info = Get-WmiObject -Class Win32_ComputerSystem
$Info.Rename("NovoNome")
Restart-Computer

# ALTERAR IP E COLOCAR NO DOMINIO

Get-NetIPConfiguration # Verifica o IP

# IP ESTÁTICO
New-NetIPAddress 192.168.1.102 -InterfaceAlias Ethernet -DefaultGateway 192.168.1.1 -AddressFamily IPv4 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses 192.168.1.123

# IP DHCP

Set-NetIPInterface -InterfaceAlias Ethernet -Dhcp Enabled
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ResetServerAddresses

# ADICIONAR NO DOMINIO

Add-Computer -ComputerName NomeComputador -DomainName "nomedominio.local"