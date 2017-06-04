FROM alpine:3.6
MAINTAINER Ezequiel M Gioia <@eze1981>

ENV ELIXIR_VERSION 1.4.4

# nodejs and erlang
RUN apk --update add erlang \
  erlang-inets \
  erlang-crypto \
  erlang-ssl \
  erlang-public-key \
  erlang-asn1 \
  erlang-sasl \
  ca-certificates \
  bash

# elixir
RUN apk --update add --virtual build-dependencies \
    wget \
    && wget --no-check-certificate https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip \
    && mkdir -p /opt/elixir-${ELIXIR_VERSION}/ \
    && unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ \
    && rm Precompiled.zip \
    && apk del build-dependencies
    #&& rm -rf /etc/ssl

ENV PATH $PATH:/opt/elixir-${ELIXIR_VERSION}/bin

# dev dependencies
#RUN apk --update add bash \
  #erlang-syntax-tools \
  #erlang-parsetools \
  #erlang-eunit \
  #erlang-erl-interface \
  #erlang-dev \
  #ca-certificates
  #git \
 # && rm -rf /var/cache/apk/*
  
# install hex and rebar
RUN mix local.hex --force \ 
  && mix local.rebar --force

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

CMD ["bash"]
