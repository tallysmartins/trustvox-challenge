# Use an official Elixir runtime as a parent image
FROM elixir:latest

RUN printenv

RUN apt-get update \
 && apt-get install -y postgresql-client \
 && curl -sL https://deb.nodesource.com/setup_10.x | bash \
 && apt-get install -y apt-utils \
 && apt-get install -y nodejs \
 && apt-get install -y build-essential \
 && apt-get install -y inotify-tools


# Create app directory and copy the Elixir projects into it
RUN mkdir /app
WORKDIR /app

COPY mix.exs  /app
COPY mix.lock  /app

RUN mix local.rebar --force
RUN mix local.hex --force
RUN mix deps.get

COPY . /app

CMD ["./entrypoint.sh"]
