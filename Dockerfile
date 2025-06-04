FROM golang:1.24-alpine AS helper
WORKDIR /go/src/github.com/bdwyertech/buildx-gitlab/helper-utility
COPY helper-utility/ .
RUN CGO_ENABLED=0 GOFLAGS=-mod=vendor go build -ldflags="-s -w" -trimpath .

FROM moby/buildkit:v0.22.0-rootless

COPY --from=helper /go/src/github.com/bdwyertech/buildx-gitlab/helper-utility/helper-utility /usr/local/bin/.

ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="bdwyertech/buildx-gitlab" \
      org.opencontainers.image.description="For running buildx within a GitLab CI Environment" \
      org.opencontainers.image.authors="Brian Dwyer <bdwyertech@github.com>" \
      org.opencontainers.image.url="https://hub.docker.com/r/bdwyertech/buildx-gitlab" \
      org.opencontainers.image.source="https://github.com/bdwyertech/docker-buildx-gitlab.git" \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.created=$BUILD_DATE \
      org.label-schema.name="bdwyertech/buildx-gitlab" \
      org.label-schema.description="For running buildx within a GitLab CI Environment" \
      org.label-schema.url="https://hub.docker.com/r/bdwyertech/buildx-gitlab" \
      org.label-schema.vcs-url="https://github.com/bdwyertech/docker-buildx-gitlab.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.build-date=$BUILD_DATE

WORKDIR /buildx

RUN mkdir -p /home/user/.docker

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
