defmodule CvmeWeb.FallbackController do
  use CvmeWeb, :controller

  def call(conn, {:error, status_name})
      when status_name in [:not_found, :bad_request, :unauthorized] do
    conn
    |> put_status(status_name)
    |> put_view(json: CvmeWeb.ErrorJSON)
    |> render(:error, status: status_name)
  end

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: CvmeWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
