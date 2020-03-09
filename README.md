# Trustvox.Umbrella

[![Travis Build Status](https://api.travis-ci.com/tallysmartins/trustvox-challenge.svg?token=YYPB6r3MNBGxpDFgnYJL&branch=master)](https://travis-ci.org/tallysmartins/trustvox-challenge)

This is the hiring challenge from TrustVox. [Here are the instructions](instructions.md)

## Running locally

**Install environment dependencies**

You can use [asdf](https://github.com/asdf-vm/asdf) to install language dependencies.

- elixir         1.9.1
- erlang         21.3.8.7


**Install packages**

`$ mix deps.get`

After installing dependencies ensure all tests are passing.

`$ mix test`

Now, to run the application `phx.server` and access `http://localhost:4000`


## Deploy on Heroku

The deploy is made based on docker containers.

First createe your account.
Create your app
Install heroku cli
  https://devcenter.heroku.com/articles/heroku-cli
Set your app config to use container stack
  https://devcenter.heroku.com/articles/build-docker-images-heroku-yml
Push branch to heroku. It will build the docker image from the Dockerfile and .herokuconfig
Set up phoenix build packs
Set up environment variables
	MIX_ENV
	SECRET
Acess your app URL

A few gotchas:
  Heroku dynos are limited in DB connections
  Heroku 
