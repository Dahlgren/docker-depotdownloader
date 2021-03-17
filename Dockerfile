FROM alpine:latest AS downloader

ARG URL=https://github.com/SteamRE/DepotDownloader/releases/download/DepotDownloader_2.3.6/depotdownloader-2.3.6.zip

RUN wget $URL -O depotdownloader.zip \
  && mkdir /depotdownloader \
  && unzip depotdownloader.zip -d /depotdownloader \
  && rm depotdownloader.zip

FROM mcr.microsoft.com/dotnet/runtime:5.0-alpine

COPY --from=downloader /depotdownloader /depotdownloader

ENTRYPOINT ["/usr/bin/dotnet", "/depotdownloader/DepotDownloader.dll"]
