defmodule Restapp.Router do
  use Phoenix.Router

  pipeline :admin do
    plug :accepts, ["json"]
    plug PlugToken, claims: %{aud: "admin"}
    plug Plug.Parsers, parsers: [ :json],
                       pass: ["application/json"],
                       json_decoder: Poison
  end

  pipeline :user do
    plug :accepts, ["json"]
    plug PlugToken, claims: %{aud: "user"}
    plug Plug.Parsers, parsers: [ :json],
                       pass: ["application/json"],
                       json_decoder: Poison
  end

  pipeline :guest do
    plug :accepts, ["json"]
    plug Plug.Parsers, parsers: [ :json],
                       pass: ["application/json"],
                       json_decoder: Poison
  end

  scope "/api", Restapp do
    pipe_through :user 
    resources "/invoices", InvoiceController
  end

  scope "/admin", Restapp do
    pipe_through :admin 
    get "/", LoginController, :admin
  end

  scope "/login", Restapp do
    pipe_through :guest
    get "/user", LoginController, :login_user
    get "/admin", LoginController, :login_admin
  end

  # Other scopes may use custom stacks.
  # scope "/api", Myapp do
  #   pipe_through :api
  # end
end
