FROM openjdk:8-windowsservercore-1809

EXPOSE 8080

SHELL ["cmd", "/S", "/C"]
RUN mkdir c:\airsonic \
mkdir c:\media

COPY ffmpeg.exe C:\\Windows\\System32

WORKDIR /airsonic

VOLUME C:\\airsonic
VOLUME C:\\media

CMD ["start.cmd"]