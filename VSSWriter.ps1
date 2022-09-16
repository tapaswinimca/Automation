

[ScriptBlock]$scb={

$ServiceArray = @{
'ASR Writer' = 'VSS';
'Bits Writer' = 'BITS';
'Certificate Authority' = 'EventSystem';
'COM+ REGDB Writer' = 'VSS';
'DFS Replication service writer' = 'DFSR';
'Dhcp Jet Writer' = 'DHCPServer';
'FRS Writer' = 'NtFrs';
'IIS Config Writer' = 'AppHostSvc';
'IIS Metabase Writer' = 'IISADMIN';
'Microsoft Exchange Writer' = 'MSExchangeIS';
'Microsoft Hyper-V VSS Writer' = 'vmms';
'MS Search Service Writer' = 'EventSystem';
'NPS VSS Writer' = 'EventSystem';
'NTDS' = 'EventSystem';
'OSearch VSS Writer' = 'OSearch';
'OSearch14 VSS Writer' = 'OSearch14';
'Registry Writer' = 'VSS';
'Shadow Copy Optimization Writer' = 'VSS';
'Sharepoint Services Writer' = 'SPWriter';
'SPSearch VSS Writer' = 'SPSearch';
'SPSearch4 VSS Writer' = 'SPSearch4';
'SqlServerWriter' = 'SQLWriter';
'System Writer' = 'CryptSvc';
'WMI Writer' = 'Winmgmt';
'TermServLicensing' = 'TermServLicensing';
}
#vssadmin list writers | Select-String -Context 0,4 'writer name:' | ? {$_.Context.PostContext[3].Trim() -ne "last error: no error"} | Select Line | %{$_.Line.tostring().Split("'")[1]}| ForEach-Object {Restart-Service $ServiceArray.Item($_) -Force}

Write-Host vssadmin list writers | Select-String -Context 0,4 'writer name:' | ? {$_.Context.PostContext[3].Trim() -ne "last error: no error"} | Select Line | %{$_.Line.tostring().Split("'")[1]}

}

Invoke-Command -ScriptBlock $scb 
