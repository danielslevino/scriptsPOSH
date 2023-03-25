# CREDENCIAIS DE ACESSO


$cred = Get-Credential nomedomino\nomeusuario   #--> Salvando credenciais em uma variável para ser utilizada depois
New-PSSession -ComputerName NomeDoServidor -Credential $cred   #--> abre nova sessão e chama a variável salva
$ListaServer = New-PSSession -ComputerName (Get-Content C:\POSH\servers.txt) -Credential $cred  #--> cria uma variável que se conecta aos servidores contidos em uma lista e utiliza as credenciais salvas
Invoke-Command $ListaServer {Get-Service} #--> Lista todos os serviços em todos os servidores na rede

Test-Connection DESKTOP-1QFIQ58