defmodule Cvme.Experiences.Update do
  alias Cvme.Experiences.Experience
  alias Cvme.Repo

  def call(%{"id" => id} = params) do
    case Repo.get(Experience, id) do
      nil -> {:error, :not_found, entity: :experience}
      experience -> update(experience, params)
    end
  end

  def update(experience, params) do
    experience
    |> Experience.changeset(params)
    |> Repo.update()
  end
end
