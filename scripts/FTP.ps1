& "C:\Program Files (x86)\WinSCP\winscp.com" `
  /log="B:\SOURCES\Repos\site\logs\winscp.log" /ini=nul `
  /command `
    "open sftp://u820870703@213.190.6.85:65002/ -hostkey=`"`"ssh-ed25519 255 N/B4Y2kCLwdIFLIkhsc6ppfpknNOIAuq01VFBgKn4kM=`"`" -privatekey=`"`"B:\SITES\SSH\BrandonFongMusic_PRIVATE.ppk`"`" -passphrase=`"`"819295224bfWANG/`"`"" `
    "lcd B:\SOURCES\Repos\Site" `
    "cd /home/u820870703/domains/brandonmfong.com/public_html" `
    "put img" `
    "lcd B:\SOURCES\Repos\Site" `
    "cd /home/u820870703/domains/brandonmfong.com/public_html" `
    "put docs" `
    "lcd B:\SOURCES\Repos\Site\config" `
    "cd /home/u820870703/domains/brandonmfong.com/public_html/config" `
    "put DBCred.xml" `
    "exit"

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