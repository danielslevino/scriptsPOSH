$UserName = "NomeDoUsuario" # Substitua pelo nome do usuário que você deseja pesquisar

$Computers = Get-ADComputer -Filter * # Recupera todos os computadores no Active Directory

ForEach ($Computer in $Computers) { # Itera sobre todos os computadores
    $Session = Query User /server:$Computer.Name $UserName # Verifica se o usuário está logado no computador
    If ($Session) { # Se a sessão do usuário for encontrada
        Write-Host "$UserName está logado em $($Computer.Name)" # Exibe o nome do computador
    }
}
