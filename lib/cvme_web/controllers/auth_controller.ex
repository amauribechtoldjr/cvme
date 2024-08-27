defmodule CvmeWeb.AuthController do
  use CvmeWeb, :controller

  plug(Ueberauth)

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, %{"provider" => "cognito"}) do
    IO.inspect("1")
    IO.inspect(conn)
    # what to do if sign in fails
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => "cognito"}) do
    IO.inspect("2")
    IO.inspect(auth)
    # sign the user in or something.
    # auth is a `%Ueberauth.Auth{}` struct, with Cognito token info
    send_resp(conn, 200, "Welcome, #{auth.uid}")
  end

  def request(conn, %{"provider" => "cognito"}) do
    Ueberauth.Strategy.Cognito.handle_request!(conn)
  end
end
