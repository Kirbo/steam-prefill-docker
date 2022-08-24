# docker build . --build-arg PREFILL_VERSION=latest -t kirbownz/steam-prefill-docker:latest
# docker push kirbownz/steam-prefill-docker:latest
# docker run -v ${PWD}/Cache:/app/Cache -v ${PWD}/Config:/app/Config --rm kirbownz/steam-prefill-docker:latest version


FROM --platform=linux/amd64 alpine:3 AS download
ARG PREFILL_VERSION=latest
RUN \
    apk --no-cache add curl && \
    cd /tmp && \
    LATEST_RELEASE_LINK=$(curl -s https://api.github.com/repos/tpill90/steam-lancache-prefill/releases/latest | grep 'browser_' | cut -d\" -f4 | grep 'linux-x64') && \
    LATEST_VERSION=$(echo ${LATEST_RELEASE_LINK} | sed 's/.*-\(.*\)-.*-.*/\1/') && \
    DOWNLOAD_VERSION=$([ "${PREFILL_VERSION}" == "latest" ] && echo ${LATEST_VERSION} || echo ${PREFILL_VERSION}) \
    DOWNLOAD_URL=$([ "${PREFILL_VERSION}" == "latest" ] && echo ${LATEST_RELEASE_LINK} || echo https://github.com/tpill90/steam-lancache-prefill/releases/download/v${DOWNLOAD_VERSION}/SteamPrefill-${DOWNLOAD_VERSION}-linux-x64.zip) && \
    wget -O SteamPrefill.zip ${DOWNLOAD_URL} && \
    unzip SteamPrefill.zip && \
    mv SteamPrefill-${DOWNLOAD_VERSION}-linux-x64\\SteamPrefill SteamPrefill && \
    chmod +x SteamPrefill

FROM --platform=linux/amd64 ubuntu:22.04
LABEL maintainer="kirbo@kirbo-designs.com"

ARG DEBIAN_FRONTEND=noninteractive

RUN \
    apt-get update && \
    apt-get install -y ca-certificates && \
    mkdir -p /app && \
    rm -rf /var/lib/apt/lists/*

COPY --from=download /tmp/SteamPrefill /app/SteamPrefill

WORKDIR /app
ENTRYPOINT [ "/app/SteamPrefill" ]
