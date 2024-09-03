defmodule CvmeWeb.AuthController do
  use CvmeWeb, :controller

  plug(Ueberauth)

  alias Cvme.Users
  alias CvmeWeb.Plugs.AuthPlug
  alias Ueberauth.Strategy.Cognito

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, %{"provider" => "cognito"}) do
    conn
    |> render(:unauthorized)
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => "cognito"}) do
    %{email: email, name: name} = auth.info

    remote_url = "http://localhost:5173/profile"

    case Users.sign_in(%{"email" => email, "name" => name}) do
      {:ok, user} ->
        conn
        |> AuthPlug.login(user)
        |> put_status(:ok)
        |> redirect(external: remote_url)

      {:error, _any} ->
        conn
        |> render(:unauthorized)
    end
  end

  def request(conn, %{"provider" => "cognito"}) do
    Cognito.handle_request!(conn)
  end

  def logout(conn, _params) do
    remote_logout_url = "http://localhost:5173"

    conn
    |> AuthPlug.logout()
    |> redirect(external: remote_logout_url)
  end
end
