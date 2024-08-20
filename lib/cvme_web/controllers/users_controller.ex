defmodule CvmeWeb.UsersController do
  use CvmeWeb, :controller

  alias Cvme.Users
  alias Users.User
  alias Cvme.Experiences
  alias CvmeWeb.Auth.Guardian

  alias CvmeWeb.Auth.ErrorResponse

  action_fallback CvmeWeb.FallbackController

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
    case Guardian.authenticate(email, password_hash) do
      {:ok, token, user} ->
        conn
        |> put_status(:ok)
        |> render(:sign_in, user: user, token: token)
      {:error, :unauthorized} -> raise ErrorResponse.Unauthorized, message: "Email or password incorrect"
    end
  end
end
