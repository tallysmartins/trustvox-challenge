# Use an official Elixir runtime as a parent image
FROM elixir:latest

ENV MIX_ENV prod

RUN apt-get update \
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

RUN printenv

RUN mix local.rebar --force
RUN mix local.hex --force
RUN mix deps.get
RUN mix phoenix.digest

COPY . /app

RUN mix compile --return-errors

# Get project deps
CMD ["./entrypoint.sh"]
