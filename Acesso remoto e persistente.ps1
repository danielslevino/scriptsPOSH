#Executar powerShell remotamente

#veririca a versão do windows
winver

#GET HOTFIX VERIFICA OS ULTIMOS UPDATES
Get-HotFix
Get-HotFix -Id KB5022924


#INVOKE-COMAND -- Traz a informação solicitada  e encerra a conexão (ACESSO REMOTO)
Invoke-Command -ComputerName DESKTOP-1QFIQ58 -ScriptBlock {Get-HotFix -Id KB5022924}

#ACESSO INTERATIVO  persistente
Enter-PSSession DESKTOP-1QFIQ58




#EXEMPLO DE SESSÃO PERSISTENTE USANDO PSSESSION, INVOKE-COMMNAD E JOBS

$s = New-PSSession -name DESKTOP-1QFIQ58 #cria nova sessão no servidor/

Invoke-Command -session $s -ScriptBlock {

$i = 0
while ($true)
{
$i++
Write-Host "vou contar até $i"
sleep 1
if ($i -ge 1000) {break}
}
} -AsJob -JobName longoTrabalho #Nome do trabalho


#comandos

get-job -name nomedotrabalho | Receive-Job  #-> Mostra o que esta sendo executado dentro do servidor remoto
Disconnect-PSSession $s  # -> Desconecta a sessão criada
get-job -name nomedotrabalho | stop-Job  #-> Para o trabalho que esta sendo executado dentro do servidor remoto