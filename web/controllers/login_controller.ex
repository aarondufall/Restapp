defmodule Restapp.LoginController do
  use Restapp.Web, :controller

  plug :action

  def login(conn, params) do
    case Joken.encode(%{aud: "johndoe"}) do
      {:ok, token} ->
	    text conn, token
	  {:error, error} ->
	    text conn, error
    end
  end
end