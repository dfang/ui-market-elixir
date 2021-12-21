defmodule PragmaticWeb.Router do
  use PragmaticWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PragmaticWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PragmaticWeb do
    pipe_through :browser

    # get "/", PageController, :index
    live "/", HomeLive, :index
    live "/about", AboutLive, :index
    live "/discover", DiscoverLive
    live "/contact", ContactLive, :index
    live "/items/:id", ItemLive
  end

  scope "/admin", PragmaticWeb.Admin, as: :admin do
    pipe_through :browser
    # resources "/items", ItemController
    resources "/partners", PartnerController
    resources "/", PartnerController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PragmaticWeb do
  #   pipe_through :api
  # end

  scope "/graphql" do
    pipe_through :api

    forward "/", Absinthe.Plug, schema: PragmaticWeb.Schema
  end

  if Mix.env() == :dev do
    forward "/graphiql",
            Absinthe.Plug.GraphiQL,
            schema: PragmaticWeb.Schema

    # interface: :simple
    # context: %{pubsub: PragmaticWeb.Endpoint}
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PragmaticWeb.Telemetry
    end
  end
end
