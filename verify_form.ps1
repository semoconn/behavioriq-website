# verify_form.ps1

$htmlContent = Get-Content -Path "index.html" -Raw

# Expected Values
$expectedOid = "00DgK00000BI3wI"
$expectedSource = "Website Waitlist"

# Check OID
if ($htmlContent -match "name=`"oid`"\s+value=`"$expectedOid`"") {
    Write-Host "[PASS] OID matches $expectedOid" -ForegroundColor Green
} else {
    Write-Host "[FAIL] OID not found or incorrect. Expected $expectedOid" -ForegroundColor Red
}

# Check Lead Source
if ($htmlContent -match "name=`"lead_source`"\s+value=`"$expectedSource`"") {
    Write-Host "[PASS] Lead Source matches '$expectedSource'" -ForegroundColor Green
} else {
    Write-Host "[FAIL] Lead Source not found or incorrect. Expected '$expectedSource'" -ForegroundColor Red
}
