defmodule CvmeWeb.Auth.SetUser do
  import Plug.Conn

  alias Cvme.Users

  def init(_options) do
  end

  def call(conn, _options) do
    if conn.assigns[:user] do
      conn
    else
      user_id = get_session(conn, :user_id)

      if user_id == nil do
        conn
        |> put_status(:unauthorized)
      else
        case Users.get(user_id) do
          {:ok, user} ->
            cond do
              user_id && user -> assign(conn, :user, user)
              true -> assign(conn, :user, nil)
            end

          {:error, _} ->
            conn
            |> put_status(:unauthorized)
        end
      end
    end
  end
end
