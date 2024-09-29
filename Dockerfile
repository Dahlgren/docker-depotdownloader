FROM alpine:latest AS downloader

ARG URL=https://github.com/SteamRE/DepotDownloader/releases/download/DepotDownloader_2.6.0/DepotDownloader-framework.zip

RUN wget $URL -O depotdownloader.zip \
  && mkdir /depotdownloader \
  && unzip depotdownloader.zip -d /depotdownloader \
  && rm depotdownloader.zip

FROM mcr.microsoft.com/dotnet/runtime:8.0-alpine

COPY --from=downloader /depotdownloader /depotdownloader

ENTRYPOINT ["/usr/bin/dotnet", "/depotdownloader/DepotDownloader.dll"]
