defmodule Restapp.LoginController do
  use Restapp.Web, :controller

  plug :action

  def login_admin(conn, _params) do
    case Joken.encode(%{company: "123456789", aud: "admin"}) do
      {:ok, token} ->
	    text conn, token
	  {:error, error} ->
	    text conn, error
    end
  end

  def login_user(conn, _params) do
    case Joken.encode(%{company: "123456789", aud: "user"}) do
      {:ok, token} ->
      text conn, token
    {:error, error} ->
      text conn, error
    end
  end

  def admin(conn, _params) do
    claims = conn.assigns[:claims]
    text conn, "Company id is " <> claims.company
  end
end