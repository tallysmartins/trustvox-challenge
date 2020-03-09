#!/bin/bash
# Docker entrypoint script.

#echo "-------------------------"
#echo "##### Mix commands"
#echo "-------------------------"
#
#mix local.rebar --force
#mix local.hex --force
#mix deps.get

echo "-------------------------"
echo "##### Database commands"
echo "-------------------------"

# Create, migrate, and seed database if it doesn't exist.
mix ecto.create || true
mix ecto.migrate || true
mix run apps/trustvox/priv/repo/seeds.exs || true

echo "-------------------------"
echo "##### Starting application"
echo "-------------------------"
exec mix phx.server
