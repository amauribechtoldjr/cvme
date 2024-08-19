defmodule CvmeWeb.Plugs.Auth do
  import Plug.Conn

  alias CvmeWeb.AuthToken
  alias Phoenix.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- AuthToken.verify(token) do
      assign(conn, :email, data.email)
    else
      _error ->
        conn
        |> put_status(:unauthorized)
        |> Controller.put_view(json: CvmeWeb.ErrorJSON)
        |> Controller.render(:error, status: :unauthorized)
        |> halt()
    end
  end
end
