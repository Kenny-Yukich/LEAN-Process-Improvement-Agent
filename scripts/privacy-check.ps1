$ErrorActionPreference = 'Stop'

$repositoryRoot = Split-Path -Parent $PSScriptRoot
Push-Location $repositoryRoot

try {
    $files = @(git ls-files)
    if ($LASTEXITCODE -ne 0) {
        throw 'Run this check inside the initialized Git repository.'
    }

    $problems = [System.Collections.Generic.List[string]]::new()
    $blockedExtensions = @('.doc', '.docx', '.xls', '.xlsx', '.ppt', '.pptx', '.pdf')
    $blockedFileNames = @(
        'conn.json',
        'connectionreferences.mcs.yml',
        'botdefinition.json',
        'changetoken.txt'
    )

    $privatePatterns = @(
        ('K' + 'EITH'),
        ('ke' + 'ithwalkingfloor'),
        ('Data' + 'verseEndpoint'),
        ('Tenant' + 'Id'),
        ('Account' + 'Email'),
        ('Environment' + 'Id'),
        ('Environment' + 'DisplayName'),
        ('-----BEGIN ' + 'PRIVATE KEY-----'),
        ('gh' + 'p_[A-Za-z0-9]{20,}'),
        ('AK' + 'IA[0-9A-Z]{16}')
    )

    foreach ($relativePath in $files) {
        $normalizedPath = $relativePath -replace '\\', '/'
        $extension = [System.IO.Path]::GetExtension($relativePath).ToLowerInvariant()
        $fileName = [System.IO.Path]::GetFileName($relativePath)

        if ($normalizedPath -match '(^|/)\.mcs/' -or $blockedExtensions -contains $extension -or $blockedFileNames -contains $fileName) {
            $problems.Add("Blocked export or document artifact: $relativePath")
            continue
        }

        $absolutePath = Join-Path $repositoryRoot $relativePath
        try {
            $content = Get-Content -Raw -LiteralPath $absolutePath -ErrorAction Stop
        }
        catch {
            continue
        }

        if ($content -match '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}') {
            $problems.Add("Email address detected: $relativePath")
        }

        foreach ($pattern in $privatePatterns) {
            if ($content -match $pattern) {
                $problems.Add("Private or secret pattern detected in: $relativePath")
                break
            }
        }
    }

    if ($problems.Count -gt 0) {
        $problems | Sort-Object -Unique | ForEach-Object { Write-Error $_ }
        exit 1
    }

    Write-Host "Privacy check passed for $($files.Count) tracked files."
}
finally {
    Pop-Location
}
