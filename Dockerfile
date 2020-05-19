FROM mcr.microsoft.com/windows:1809

LABEL key="PlexMediaServer"
# Copy/download install files to container
COPY PlexMediaServer-1.19.3.2831-181d9145d-x86.exe setup.exe

# Install Plex
RUN setup.exe /quiet

# Cleanup
RUN del /F /Q setup.exe

# Expose images possible configuration
EXPOSE 32400/tcp

# Define the entrypoint
CMD ["C:\\Program Files (x86)\\Plex\\Plex Media Server\\Plex Media Server.exe"]