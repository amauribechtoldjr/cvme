defmodule CvmeWeb.WelcomeController do
  use CvmeWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{
      message: "CVme API",
      status: :ok
    })
  end
end
