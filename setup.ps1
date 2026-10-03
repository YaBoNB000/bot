#Requires -Version 5.1
<#
    Luraph deobfuscator Discord bot - Windows installer launcher.

    This file is intentionally ASCII-only and does nothing but find Python and
    run setup_wizard.py. Reason: Windows PowerShell 5.1 reads .ps1 files
    without a UTF-8 BOM using the system ANSI code page, which corrupts
    non-ASCII characters (Chinese text) and breaks string parsing
    ("The string is missing the terminator"). Keeping this file ASCII makes
    it work on every Windows regardless of code page.

    Usage:
        powershell -ExecutionPolicy Bypass -File setup.ps1
        powershell -ExecutionPolicy Bypass -File setup.ps1 -Token "YOUR_TOKEN"
        powershell -ExecutionPolicy Bypass -File setup.ps1 -DeobfDir "D:\path\to\deobf"
#>
[CmdletBinding()]
param(
    [string]$Token = "",
    [string]$DeobfDir = "",
    [ValidateSet("auto", "git", "zip")] [string]$Method = "auto",
    [switch]$Force,
    [switch]$SkipDeps
)

$ErrorActionPreference = "Stop"
Set-Location -Path (Split-Path -Parent $MyInvocation.MyCommand.Path)

function Test-PyCandidate([string]$exe, [string[]]$pre) {
    # returns the version string when $exe runs and is >= 3.10, otherwise $null
    try {
        $ver = & $exe @pre -c "import sys;print(sys.version.split()[0])" 2>$null
        if ($LASTEXITCODE -ne 0 -or -not $ver) { return $null }
        $ok = & $exe @pre -c "import sys;raise SystemExit(0 if sys.version_info>=(3,10) else 3)" 2>$null
        if ($LASTEXITCODE -ne 0) { return "OLD:$ver" }
        return $ver
    } catch { return $null }
}

$py = $null
$pre = @()
$pyVer = ""
$oldVer = ""
$candidates = @(
    @("py", @("-3")),
    @("python", @()),
    @("python3", @())
)
foreach ($d in @("$env:LOCALAPPDATA\Programs\Python", "$env:ProgramFiles")) {
    if ($d -and (Test-Path $d)) {
        Get-ChildItem -Path $d -Filter "Python3*" -Directory -ErrorAction SilentlyContinue |
            ForEach-Object {
                $exe = Join-Path $_.FullName "python.exe"
                if (Test-Path $exe) { $candidates += ,@($exe, @()) }
            }
    }
}
foreach ($cand in $candidates) {
    $exe = $cand[0]
    if (-not (Get-Command $exe -ErrorAction SilentlyContinue) -and -not (Test-Path $exe)) { continue }
    $res = Test-PyCandidate $exe $cand[1]
    if ($res -and $res -notlike "OLD:*") { $py = $exe; $pre = $cand[1]; $pyVer = $res; break }
    if ($res -like "OLD:*") { $oldVer = $res.Substring(4) }
}
if (-not $py) {
    if ($oldVer) {
        Write-Host "[x] The Python found ($oldVer) is older than 3.10, which this bot needs." -ForegroundColor Red
        Write-Host "    Install Python 3.12 from https://www.python.org/downloads/windows/"
    } else {
        Write-Host "[x] Python 3.10+ was not found." -ForegroundColor Red
        Write-Host "    Install Python 3.12 from https://www.python.org/downloads/windows/"
        Write-Host "    and tick 'Add python.exe to PATH' during setup."
    }
    exit 1
}
Write-Host "[*] Python $pyVer  ($py $pre)"

if (-not (Test-Path "setup_wizard.py")) {
    Write-Host "[x] setup_wizard.py is missing next to this script." -ForegroundColor Red
    exit 1
}

$wizardArgs = @("setup_wizard.py")
if ($Token)    { $wizardArgs += @("--token", $Token) }
if ($DeobfDir) { $wizardArgs += @("--deobf-dir", $DeobfDir) }
if ($Method -ne "auto") { $wizardArgs += @("--method", $Method) }
if ($Force)    { $wizardArgs += "--force" }
if ($SkipDeps) { $wizardArgs += "--skip-deps" }

& $py @pre $wizardArgs
exit $LASTEXITCODE
