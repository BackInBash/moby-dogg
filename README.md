# Plex Media Server Docker for Windows

## Setup

Start Container
``` console
docker run -d -p 32400:32400 --name plexmediaserver -v C:\temp\docker\plex_meta:"C:\Users\ContainerAdministrator\AppData\Local\Plex Media Server" -v C:\temp\docker\plex_data:c:\media\01 0953bf444771
```