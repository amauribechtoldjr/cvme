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

      if user_id == nil, do: {:error, :unauthorized}

      {:ok, user} = Users.get(user_id)

      cond do
        user_id && user -> assign(conn, :user, user)
        true -> assign(conn, :user, nil)
      end
    end
  end
end
