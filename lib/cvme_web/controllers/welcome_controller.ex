defmodule CvmeWeb.WelcomeController do
  use CvmeWeb, :controller

  def index(conn) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Welcome to CVme API", status: :ok})
  end
end
