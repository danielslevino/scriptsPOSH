
#AGENDAMENTO

Clear-Host
Get-Command -Module PSScheduledJob | Sort-Object Noun

$diario = New-JobTrigger -Daily -at 2pm
$umavez = New-JobTrigger -Once -At (get-date).AddHours(1)
$semanal = New-JobTrigger -Weekly -DaysOfWeek Monday -At 6pm

Register-ScheduledJob -Name Backup -Trigger $diario -ScriptBlock {
Copy-Item C:\Posh\*.* C:\Backup\ -Recurse -force 

}

# VERIFICAR AGENDAMENTO
Get-ScheduledJob

# VERIFICAR AGENDAMENTO E INFORMAÇÕES
Get-ScheduledJob Backup | Get-JobTrigger

#EXCLUIR AGENDAMENTO
Get-ScheduledJob Backup | Unregister-ScheduledJob