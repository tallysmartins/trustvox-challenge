# Use an official Elixir runtime as a parent image
FROM elixir:latest

RUN mix local.hex --force \
 && apt-get update \
 && apt-get install -y apt-utils \
 && apt-get install -y build-essential \
 && apt-get install -y inotify-tools \
 && mix local.rebar --force

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Get project deps
RUN mix  deps.get
