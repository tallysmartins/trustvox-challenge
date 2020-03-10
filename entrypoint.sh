#!/bin/bash
# Docker entrypoint script.
# entrypoint.sh
# copied from https://pspdfkit.com/blog/2018/how-to-run-your-phoenix-application-with-docker/


# Create, migrate, and seed database if it doesn't exist.
mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs
echo "Database $PGDATABASE created."

exec mix phx.server
