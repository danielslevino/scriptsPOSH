$session = New-Object -ComObject Microsoft.Update.Session
$searcher = $session.CreateUpdateSearcher()
$pendingUpdates = $searcher.Search("IsInstalled=0")

$updateList = New-Object -TypeName System.Collections.ArrayList

foreach ($update in $pendingUpdates.Updates) {
  if ($update.InstallationBehavior.CanRequestUserInput -ne $true) {
    foreach ($category in $update.Categories) {
      if ($category.Name -eq "Updates") {
        $updateList.Add($update) | Out-Null
      }
    }
  }
}

$desktopPath = [Environment]::GetFolderPath("Desktop")
$updatesFile = Join-Path $desktopPath "updates.txt"

foreach ($update in $updateList) {
  $missingUpdates = New-Object -TypeName System.Collections.ArrayList
  foreach ($dependency in $update.Dependencies) {
    if ($dependency.IsInstalled -eq $false) {
      $missingUpdates.Add($dependency) | Out-Null
    }
  }
  if ($missingUpdates.Count -gt 0) {
    $updateText = "A seguinte atualização tem dependências faltando: $($update.Title)`r`n"
    $updateText += "As seguintes atualizações devem ser instaladas antes de $($update.Title):`r`n"
    foreach ($missingUpdate in $missingUpdates) {
      $updateText += "- $($missingUpdate.Title)`r`n"
    }
    Add-Content -Path $updatesFile -Value $updateText
  }
}
