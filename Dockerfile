FROM chocolatey/choco
LABEL org.opencontainers.image.authors="bsmreker1@icloud.com"
LABEL org.label-schema.vcs-url="https://github.com/bsmirks/manypacks"

RUN apt-get update \
  && apt-get install \
    git \
    ruby-dev \
    rpm \
    build-essential -y \
  && gem install --no-ri --no-rdoc fpm;