defmodule Restapp.Router do
  use Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
    plug PlugJwt, secret: "test", claims: %{aud: "johndoe"}, json_module: JWT.Module
    plug Plug.Parsers, parsers: [ :json],
                       pass: ["application/json"],
                       json_decoder: Poison
  end

  pipeline :login do
    plug :accepts, ["json"]
    plug Plug.Parsers, parsers: [ :json],
                       pass: ["application/json"],
                       json_decoder: Poison
  end

  scope "/api", Restapp do
    pipe_through :api 
    resources "/invoices", InvoiceController
  end

  scope "/user", Restapp do
    pipe_through :login
    get "/login", LoginController, :login
  end

  # Other scopes may use custom stacks.
  # scope "/api", Myapp do
  #   pipe_through :api
  # end
end
