$XMLlists = @("ApplicationGroups","DriverGroups")

Foreach ($XMLlist in $XMLlists) {
    If (Test-Path $XMLlist'.xml') {
        $outFile = $XMLlist + '_Sorted.xml'
        [xml]$driversList = (Get-Content $XMLlist'.xml')

        '<?xml version="1.0" encoding="utf-8"?><groups>' | Out-File -Encoding "UTF8" $outFile -NoNewline
        ($driversList.groups.group | Where {$_.name -eq 'default' -or $_.name -eq 'hidden'}).OuterXml | Out-File  -Append -Encoding "UTF8" $outFile -NoNewline
        ($driversList.groups.group | Where {$_.name -ne 'default' -and $_.name -ne 'hidden'} | Sort Name).OuterXml | Out-File -Append -Encoding 'UTF8' $outFile -NoNewline
        '</groups>' | Out-File -Append -Encoding "UTF8" $outFile -NoNewline
    }
}
