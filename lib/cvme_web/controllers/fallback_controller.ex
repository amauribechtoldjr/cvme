defmodule CvmeWeb.FallbackController do
  use CvmeWeb, :controller

  def call(conn, {:error, :not_found, entity: entity}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: CvmeWeb.ErrorJSON)
    |> render(:error, status: :not_found, entity: entity)
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: CvmeWeb.ErrorJSON)
    |> render(:error, status: :bad_request)
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(json: CvmeWeb.ErrorJSON)
    |> render(:error, status: :unauthorized)
  end

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: CvmeWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
