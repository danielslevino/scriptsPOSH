# VERIFICA SE O PACOTE RSAT ESTÁ INSTALADO

Get-WindowsCapability -name rsat.activedirectory.DS-LDS.Tools* -online


# Instala o pacote contendo os módulos Powershell para gerenciamento de Active Directory.

Get-WindowsCapability -name rsat.activedirectory.DS-LDS.Tools* -online | Add-WindowsCapability –Online


# Opcionalmente, use o nome completo do pacote para instalar o software necessário.

Add-WindowsCapability -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0 –online


# Lista todos os computadores do domínio e salva em um arquivo
Get-ADComputer -SearchBase 'dc=sistemafibra,dc=local'  -Filter * | Select-Object Name |out-file -filepath C:\TESTE4.txt


# Comando que busca usuários nos computadores salvos em um arquivo
$computers = Get-Content -Path C:\TESTE4.txt
$user = "daniel.levino"

foreach ($computer in $computers) {
    $session = Get-CimInstance -ComputerName $computer -Namespace root\cimv2 -ClassName Win32_LogonSession -ErrorAction SilentlyContinue
    if ($session) {
        foreach ($s in $session) {
            $userSID = $s.PSChildName
            $userObject = Get-CimInstance -ComputerName $computer -Namespace root\cimv2 -ClassName Win32_Account -Filter "SID='$userSID'" -ErrorAction SilentlyContinue
            if ($userObject.Name -eq $user) {
                Write-Output "$user está logado em $computer"
            }
        }
    } else {
        Write-Output "Não foi possível se conectar a $computer"
    }
}
