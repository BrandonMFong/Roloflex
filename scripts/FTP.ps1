param([switch]$Default)
$creds = Get-Content $PSScriptRoot\..\config\ssh.json|Out-String|ConvertFrom-Json
[XML]$FTPItems = Get-Content $PSScriptRoot\..\config\Transfer.xml

if($Default)
{
  foreach($dest in $FTPItems.Site.Destination)
  {
    if($dest.Name -eq "Default")
    {
      Write-Host "`nTransferring to $($dest.Site)`n" -ForegroundColor Yellow;
      [System.Object[]]$Processes = $dest.Processes;
      foreach($item in $Processes.Process)
      {
        Write-Host "`nTag: $($item.Tag)" -ForegroundColor Green;
        & "C:\Program Files (x86)\WinSCP\winscp.com" `
          /log="B:\SOURCES\Repos\Roloflex\logs\Roloflex.log" /ini=nul `
          /command `
          "open sftp://$($creds.Username):$($creds.Password)@$($creds.IP)/ -hostkey=`"`"$($creds.HostKey)`"`"" `
          "lcd $($item.LCD)" `
          "cd $($item.CD)" `
          "put $($item.Package)" `
          "exit"
      }
    }
  }
}

$winscpResult = $LastExitCode
if ($winscpResult -eq 0)
{
  Write-Host "Success"
}
else
{
  Write-Host "Error"
}

exit $winscpResult