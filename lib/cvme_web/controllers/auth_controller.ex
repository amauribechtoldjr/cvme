defmodule CvmeWeb.AuthController do
  use CvmeWeb, :controller

  plug(Ueberauth)

  alias Cvme.Users

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, %{"provider" => "cognito"}) do
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => "cognito"}) do
    %{email: email, name: name} = auth.info

    case Users.sign_in(%{"email" => email, "name" => name}) do
      {:ok, user} ->
        conn
        |> put_status(:ok)
        |> render(:sign_in, %{user: user})
      {:error, _any} ->
        conn
        |> render(:unauthorized)
    end
  end

  def request(conn, %{"provider" => "cognito"}) do
    Ueberauth.Strategy.Cognito.handle_request!(conn)
  end
end
