FROM mhart/alpine-node:5.9

MAINTAINER Ezequiel Gioia <@eze1981>

RUN apk add --no-cache --update \
  bash \
  grep \
  bc \
  coreutils \
#  ca-certificates \
  erlang-crypto \
  erlang-syntax-tools \
  erlang-parsetools \
  elixir

RUN mix local.hex --force

RUN mix hex.info

RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

#WORKDIR /bin
#RUN wget http://s3.amazonaws.com/rebar3/rebar3 && chmod u+x rebar3

WORKDIR /var/www/app

VOLUME ["/var/www/app"]


ENV PORT 8000
EXPOSE 8000
CMD ["mix","phoenix.server"]
