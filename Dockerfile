FROM python:3.10-alpine@sha256:b974a5de91b4ac6da8313502cd5bfe65c499e390d32658e1f2deea26fa5afb14 AS base

RUN apk --update add --no-cache ffmpeg git

FROM base AS builder

WORKDIR /install
COPY pyproject.toml /build/pyproject.toml
COPY zotify /build/zotify

RUN apk add gcc jpeg-dev libc-dev zlib zlib-dev
RUN pip install --prefix="/install" /build

FROM base

COPY --from=builder /install /usr/local/lib/python3.10/site-packages
RUN mv /usr/local/lib/python3.10/site-packages/lib/python3.10/site-packages/* /usr/local/lib/python3.10/site-packages/

# Patch librespot OAuth to bind listener to 0.0.0.0 instead of the redirect hostname (Fixes oauth redirect for running in Docker in some cases)
RUN sed -i 's/(url\.hostname, url\.port)/(\"0.0.0.0\", url.port)/' \
    /usr/local/lib/python3.10/site-packages/librespot/oauth.py

COPY zotify /app/zotify

WORKDIR /app
EXPOSE 4381
CMD ["python3", "-m", "zotify"]