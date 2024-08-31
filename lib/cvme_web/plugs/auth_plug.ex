defmodule CvmeWeb.Plugs.AuthPlug do
  @behaviour Plug

  import Plug.Conn

  alias Cvme.Users

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Users.get(user_id)

    if user do
      assign(conn, :current_user, user)
    else
      conn
      |> put_status(:unauthorized)
      |> send_resp(:unauthorized, "")
      |> halt()
    end
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    conn
    |> configure_session(drop: true)
    |> assign(:current_user, nil)
  end
end
