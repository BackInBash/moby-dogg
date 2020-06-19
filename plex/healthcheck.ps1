REG export 'HKCU\Software\Plex, Inc.\Plex Media Server' C:\PlexData\regbackup.reg
try {
    $proc = Start-Process -FilePath "curl" -ArgumentList '--connect-timeout 15 --silent --show-error --silent --fail "http://localhost:32400/identity"' -NoNewWindow -PassThru -Wait -RedirectStandardOutput $false
    exit $proc.ExitCode
}
catch {
    exit 1
}