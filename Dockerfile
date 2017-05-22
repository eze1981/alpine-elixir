FROM alpine:3.5
MAINTAINER Ezequiel M Gioia <@eze1981>

ENV ELIXIR_VERSION 1.4.4
ENV PHOENIX_VERSION 1.2.4

# nodejs and erlang
RUN apk --update add nodejs \
  erlang \
  erlang-inets \
  erlang-crypto \
  erlang-ssl \
  erlang-public-key \
  erlang-asn1 \
  erlang-sasl

# elixir
RUN apk --update add --virtual build-dependencies \
    wget \
    ca-certificates \
    && wget --no-check-certificate https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip \
    && mkdir -p /opt/elixir-${ELIXIR_VERSION}/ \
    && unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ \
    && rm Precompiled.zip \
    && apk del build-dependencies \
    && rm -rf /etc/ssl

ENV PATH $PATH:/opt/elixir-${ELIXIR_VERSION}/bin

# DEV dependencies
RUN apk --update add bash \
  erlang-syntax-tools \
  erlang-parsetools \
  erlang-eunit \
  erlang-erl-interface \
  erlang-dev \
  git \
  && rm -rf /var/cache/apk/*
  
# phoenix
RUN mix local.hex --force \ 
  # && mix hex.info \
  && mix local.rebar --force \
  #&& mix archive.install https://github.com/phoenixframework/archives/blob/master/phoenix_new-1.2.4.ez --force
  #&& mix archive.install https://github.com/phoenixframework/archives/blob/master/phoenix_new-${PHOENIX_VERSION}.ez --force
  && mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force
  
#ENV PORT 8000
#EXPOSE 8000

# Create working directory and deploy app
#VOLUME ["/var/www/app"]
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
#COPY ./app .
#RUN mix deps.get
#RUN mix compile
#RUN mix ecto.migrate

CMD ["bash"]