defmodule CvmeWeb.ExperiencesController do
  use CvmeWeb, :controller

  alias Cvme.Experiences
  alias Experiences.Experience

  action_fallback CvmeWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Experience{} = experience} <- Experiences.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, experience: experience)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Experience{} = experience} <- Experiences.delete(id) do
      conn
      |> put_status(:ok)
      |> render(:delete, experience: experience)
    end
  end

  def update(conn, params) do
    with {:ok, %Experience{} = experience} <- Experiences.update(params) do
      conn
      |> put_status(:ok)
      |> render(:update, experience: experience)
    end
  end
end
