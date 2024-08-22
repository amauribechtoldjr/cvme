defmodule CvmeWeb.UsersController do
  use CvmeWeb, :controller

  alias Cvme.Users
  alias Users.User
  alias Cvme.Experiences
  alias CvmeWeb.Auth.Guardian

  plug :is_authorized when action in [:update, :delete, :show, :experiences]

  action_fallback CvmeWeb.FallbackController

  defp is_authorized(conn, _) do
    %{params: %{"id" => user_id}} = conn

    case Users.get(user_id) do
      {:ok, user} ->
        if conn.assigns.user.id == user.id do
          conn
        else
          conn
          |> put_status(:forbidden)
          |> put_view(json: CvmeWeb.ErrorJSON)
          |> render(:error, status: :forbidden)
          |> halt()
        end

      {:error, :not_found} ->
        conn
        |> put_status(:forbidden)
        |> put_view(json: CvmeWeb.ErrorJSON)
        |> render(:error, status: :forbidden)
        |> halt()
    end
  end

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render(:create, user: user, token: token)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.delete(id) do
      conn
      |> put_status(:ok)
      |> render(:delete, user: user)
    end
  end

  def experiences(conn, %{"id" => id}) do
    with {:ok, experiences: experiences} <- Experiences.user_experiences(id) do
      conn
      |> put_status(:ok)
      |> render(:user_experiences, experiences: experiences)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.get(id) do
      conn
      |> put_status(:ok)
      |> render(:get, user: user)
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Users.update(params) do
      conn
      |> put_status(:ok)
      |> render(:update, user: user)
    end
  end

  def sign_in(conn, %{"email" => email, "password_hash" => password_hash}) do
    with {:ok, token, user} <- Guardian.authenticate(email, password_hash) do
      conn
      |> Plug.Conn.put_session(:user_id, user.id)
      |> put_status(:ok)
      |> render(:sign_in, token: token)
    end
  end
end
