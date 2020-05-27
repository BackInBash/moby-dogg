# Docker Container Windows

!(dogger)[header.png]

## Plex Media Server

## Setup

Start Container
``` console
docker run -d -p 32400:32400 --name plexmediaserver --restart=always --network host -v C:\temp\docker\plex_meta:"C:\Users\ContainerAdministrator\AppData\Local\Plex Media Server" -v C:\temp\docker\plex_data:c:\media\01 0953bf444771
```

## JDownloader

Start Container

``` console
docker run -d --name jdownloader --cpus=4 -m 2048 --restart=always -v F:\JDownloader:"C:\jdownloader" -v D:\_Downloads:C:\downloads\d -v E:\_Downloads:C:\downloads\e 50c242a7f8f7
```

## Airsonic

Start Container

``` console
docker run -d -p 8080:8080 --name airsonic --cpus=4 -m 4096 --restart=always -v F:\airsonic:"C:\airsonic" -v d:\#Musik:c:\media 648dcea93b8b
```