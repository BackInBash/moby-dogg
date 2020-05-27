FROM openjdk:8-windowsservercore-1809

SHELL ["cmd", "/S", "/C"]
RUN mkdir c:\jdownloader \
c:\downloads

WORKDIR /jdownloader

VOLUME C:\\jdownloader

CMD ["java", "-Xmx2048m", "-jar", "JDownloader.jar"]