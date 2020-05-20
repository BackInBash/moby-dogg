FROM mcr.microsoft.com/windows:1809

LABEL Description="Plex Media Server" Vendor="Plex Inc" Version="1.19.3.2831-181d9145d" Tag="plex"
LABEL maintainer="BackInBash"

EXPOSE 32400 1900/udp 3005 5353/udp 8324 32410/udp 32412/udp 32413/udp 32414/udp 32469

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Invoke-WebRequest -Method Get -Uri (([xml]((Invoke-WebRequest -UseBasicParsing -Uri \"https://plex.tv/downloads/details/1?build=windows-i386&distro=english\").Content)).MediaContainer.Release.Package.url) -OutFile c:\PlexInstaller.exe; \
    Start-Process C:\PlexInstaller.exe -ArgumentList '/quiet /install InstallFolder=C:\Plex' -Wait; \
    Start-Sleep -Seconds 1; \
    New-Item c:\media -type directory; \
    New-Item 'C:\Users\ContainerAdministrator\AppData\Local\Plex Media Server' -type directory; \
    Remove-Item c:\PlexInstaller.exe -Force

WORKDIR /plex

VOLUME c:\\PlexData

COPY Bootstrap.ps1 /

ENTRYPOINT ["powershell", "-ExecutionPolicy", "Unrestricted", "C:\\Bootstrap.ps1"]