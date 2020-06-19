FROM mcr.microsoft.com/windows:1809

LABEL Description="Plex Media Server" Vendor="Plex Inc" Version="1.19.4.2935-79e214ead"
LABEL maintainer="BackInBash"

EXPOSE 32400 1900/udp 3005 5353/udp 8324 32410/udp 32412/udp 32413/udp 32414/udp 32469

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Invoke-WebRequest -Method Get -Uri (([xml]((Invoke-WebRequest -UseBasicParsing -Uri \"https://plex.tv/downloads/details/1?build=windows-i386&distro=english\").Content)).MediaContainer.Release.Package.url) -OutFile c:\PlexInstaller.exe; \
    Start-Process C:\PlexInstaller.exe -ArgumentList '/quiet /install InstallFolder=C:\Plex' -Wait; \
    Start-Sleep -Seconds 1; \
    New-Item c:\PlexData -type directory; \
    New-Item c:\Media -type directory; \
    New-ItemProperty -Path 'HKCU:\Software\Plex, Inc.\Plex Media Server\' -Name 'LocalAppDataPath' -Value 'C:\PlexData\' -PropertyType String; \
    Remove-Item c:\PlexInstaller.exe -Force

WORKDIR /plex

VOLUME c:\\PlexData

COPY *.ps1 /

ENTRYPOINT ["powershell", "-ExecutionPolicy", "Unrestricted", "C:\\Bootstrap.ps1"]

HEALTHCHECK --interval=5s --timeout=2s --retries=20 CMD ["powershell", "-ExecutionPolicy", "Unrestricted", "C:\\healthcheck.ps1"]