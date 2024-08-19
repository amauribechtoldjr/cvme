defmodule CvmeWeb.WelcomeController do
  use CvmeWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{
      message: "Welcome to CVME API. Version: #{Mix.Project.config()[:version]}",
      status: :ok
    })
  end
end
