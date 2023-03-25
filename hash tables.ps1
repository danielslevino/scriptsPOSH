#TESTE COM HASH TABLE
Clear-Host
$servidores = [ordered] @{server01="127.0.0.1";server02="127.0.0.2";server03="127.0.0.3"}
$servidores

#adicionar
$servidores["server04"]="127.0.0.4"

#remover
$servidores.Remove("server04")

#Exibir Valores
$servidores.values
