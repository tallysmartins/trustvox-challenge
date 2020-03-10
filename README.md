# Trustvox.Umbrella 

[![Travis Build Status](https://api.travis-ci.com/tallysmartins/trustvox-challenge.svg?token=YYPB6r3MNBGxpDFgnYJL&branch=master)](https://travis-ci.org/tallysmartins/trustvox-challenge)


This is the hiring challenge from TrustVox. [Here are the instructions](instructions.md)

## Running the project locally

To run the project in development mode you can use Docker or install dependencies in your host.

## Local setup
**For host install environment dependencies**

You can use [asdf](https://github.com/asdf-vm/asdf) to install language dependencies.

- elixir         1.9.1
- erlang         21.3.8.7
- postgresql		 9.5

**Install packages**

`$ mix deps.get`

**Setup the database**

`mix ecto.create && mix ecto.migrate && mix run priv/repo.seeds.exs`

After installing dependencies ensure all tests are passing.

`$ mix test --exclude wip`

Now, to run the application `phx.server` and access `http://localhost:4000`

## Docker setup

Ensure you have docker up and running in your machine. And simple go in the
project directory and run:

`$ docker-compose up`

This will build the images of Elixir based container and Postgresql. After
a few minutes the application shall be available at the same address  `http://localhost:4000`


## Generating releases with Distillery

This project uses `distillery` for deployments. The relese requires `PORT` and
`DATABASE_URL` environment variables. Built releases are placed under `_build/prod/rel/trustvox`
directory.

```
$ MIX_ENV=prod mix release
```

Start the application passing the required variables

```
DATABASE_URL="postgresql://user:password@localhost:5432/trustvox_dev" PORT=4000 _build/prod/rel/trustvox/bin/trustvox start
```

## Deploy on Gigalixir

This project ships the configuration needed to deploy on [Gigalixir](https://gigalixir.com), a Heroku like
service. To make a deploy on Gigalixir you will have to follow this simple guide and refer
to the documentation for further information, see [Getting Started](https://gigalixir.readthedocs.io/en/latest/main.html#getting-started-guide)

- Install the Gigalixir CLI, all steps are performed through it
- Create an account and login
- Create an app and give it a name
- Setup your `confifg/prod.exs` to match Gigalixir requirements
- Add a database to your app
- Push your code to gigalixir
- Manually run migrations and seeds
