FROM ubuntu:hirsute

# Simplified from: https://github.com/uphold/docker-litecoin-core/blob/master/0.18/Dockerfile

# Setup some variables.
ENV ARCH=x86_64
ENV LITECOIN_VERSION=0.18.1
ENV LITECOIN_DATA=/home/litecoin/.litecoin
ENV LITECOIN_USER=litecoin

# Get the base ready.
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y wget gnupg && apt-get clean \
    && gpg --no-tty --keyserver pgp.mit.edu --recv-keys 0xFE3348877809386C

WORKDIR /

# Install litecoin.
RUN wget https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-${ARCH}-linux-gnu.tar.gz \
    && wget https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
    && gpg --verify litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
    && tar --strip=2 -xzf *.tar.gz -C /usr/local/bin \
    && rm -f *.tar.gz *.asc

# Setup how we're going to run it.
RUN useradd -r ${LITECOIN_USER} && mkdir -p ${LITECOIN_DATA} && chmod 770 ${LITECOIN_DATA} && chown -R ${LITECOIN_USER} ${LITECOIN_DATA}

USER ${LITECOIN_USER}

VOLUME ["/home/litecoin/.litecoin"]

CMD ["/usr/local/bin/litecoind", "-datadir=/home/litecoin/.litecoin"]