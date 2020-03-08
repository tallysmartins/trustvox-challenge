defmodule TrustvoxWeb.Router do
  use TrustvoxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TrustvoxWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/complains", ComplainsController
    resources "/companies", CompaniesController
    get "/complains/stats", ComplainsController, :stats

    match :*, "/search/companies", CompaniesController, :search
  end

  # Other scopes may use custom stacks.
  # scope "/api", TrustvoxWeb do
  #   pipe_through :api
  # end
end
