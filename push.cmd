set /P ver=Enter Version: 
docker build . -t docker.pkg.github.com/backinbash/moby-plex/plex:%ver%
docker push docker.pkg.github.com/backinbash/moby-plex/plex:%ver%