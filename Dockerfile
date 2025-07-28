FROM alpine:latest AS downloader

ARG URL=https://github.com/SteamRE/DepotDownloader/releases/download/DepotDownloader_3.4.0/DepotDownloader-framework.zip

RUN wget $URL -O depotdownloader.zip \
  && mkdir /depotdownloader \
  && unzip depotdownloader.zip -d /depotdownloader \
  && rm depotdownloader.zip

FROM mcr.microsoft.com/dotnet/runtime:9.0-alpine

COPY --from=downloader /depotdownloader /depotdownloader

ENTRYPOINT ["/usr/bin/dotnet", "/depotdownloader/DepotDownloader.dll"]
