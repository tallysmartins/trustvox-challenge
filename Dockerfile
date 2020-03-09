# Use an official Elixir runtime as a parent image
FROM elixir:latest

RUN mix local.hex --force \
 && mix archive.install --force hex phx_new 1.4.11 \
 && apt-get update \
 && curl -sL https://deb.nodesource.com/setup_10.x | bash \
 && apt-get install -y apt-utils \
 && apt-get install -y nodejs \
 && apt-get install -y build-essential \
 && apt-get install -y inotify-tools \
 && mix local.rebar --force

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix local.hex --force

# Get project deps
RUN mix  deps.get

# Compile the project
RUN mix do compile

# Local Hex again
RUN mix local.hex --force

CMD ["mix", "phx.server"]
