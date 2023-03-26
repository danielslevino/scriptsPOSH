# GERENCIANDO O AD VIA POWERSHELL

Get-Command -Module ActiveDirectory  #Lista todos os comandos liberados
get-ADUser usuario.sobrenome -properties * #  Mostra as propriedade do usuário do AD
get-ADUser usuario.sobrenome -properties LastLogonDate #  Mostra a ultima vez que fez logon
get-ADUser usuario.sobrenome -properties * | Export-Csv C:\POSH\ListaUser.csv #  Mostra as propriedades de todos os usuários do AD e salva em um arquivo CSV
Import-Csv C:\POSH\ListaUser.csv #importa a lista de usuários para o AD

New-ADUser nome.sobrenome # Adiciona novo usuário
Get-ADUser nome.sobrenome | Remove-ADUser  # Remove usuário
